local user32 = require "win32/user32"
local ffi = require "ffi"
local bit = require "bit"

local luaize = require "luaize"

local prototype = {}

local function create(kbcb, focuscb)
    local ret = {
        run = true,
        calling = false,
        callbacks = {
            kb = kbcb,
            focus = focuscb
        },
        hooks = {}
    }

    ret.hooks.kbll = user32.SetWindowsHookEx(
        user32.WH_KEYBOARD_LL,
        ffi.cast("HOOKPROC", function(nCode, wParam, lParam)
            if nCode < user32.HC_ACTION or ret.calling then
                return user32.CallNextHookEx(nil, nCode, wParam, lParam)
            end

            local event = tonumber(ffi.cast("unsigned int", wParam))
            local struct = ffi.cast("KBDLLHOOKSTRUCT*", lParam)
            local block

            ret.calling = true
            ret.run, block = ret.callbacks.kb(luaize.keyboard(event, struct))
            ret.calling = false

            if block then
                return 1
            else
                return user32.CallNextHookEx(nil, nCode, wParam, lParam)
            end
        end),
        nil,
        0
    )

    ret.hooks.focus = user32.SetWinEventHook(
        user32.EVENT_SYSTEM_FOREGROUND,
        user32.EVENT_SYSTEM_FOREGROUND,
        nil,
        ffi.cast("WINEVENTPROC", function(_, _, hwnd, _, _, _, _)
            ret.callbacks.focus(luaize.focus(hwnd))
        end),
        0,
        0,
        bit.bor(user32.WINEVENT_OUTOFCONTEXT, user32.WINEVENT_SKIPOWNPROCESS)
    )

    return setmetatable(ret, {
        __index = prototype
    })
end

function prototype:close()
    user32.UnhookWindowsHookEx(self.hooks.kbll)
    user32.UnhookWinEvent(self.hooks.focus)
end

function prototype:pump()
    jit.off()
    local msg = ffi.new("MSG[1]")
    while self.run do
        if user32.PeekMessage(msg, nil, 0, 0, user32.PM_REMOVE) > 0 then
            if msg.message == user32.WM_QUIT then
                print "bye"
                break
            end

            user32.TranslateMessage(msg)
            user32.DispatchMessage(msg)
        end
    end
end

return {
    create = create
}
