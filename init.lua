local backend = require "backend"

local ffi = require "ffi"
local user32 = require "win32/user32"

local keystate = {}

local function print_input(inp)
    print(inp.type, inp.ki.dwFlags, inp.ki.time, inp.ki.dwExtraInfo, inp.ki.wScan, string.char(inp.ki.wScan))
end

local function add_input(inp, vk, scan, flags)
    inp.type = user32.INPUT_KEYBOARD
    inp.ki.wVk = vk
    inp.ki.wScan = scan
    inp.ki.dwFlags = flags
    inp.ki.time = 0
    inp.ki.dwExtraInfo = 0
end

local function write_input(msg)
    local len = msg:len()
    local inps = ffi.new("INPUT[?]", (len*2) + 2)
    --print(len, len*2 + 2)
    add_input(inps[0], 162, 0, user32.KEYEVENTF_KEYUP)

    print("type", "flags", "time", "extra", "scan", "char")

    for i = 1, len do
        add_input(inps[(i-1)*2+1], 0, msg:byte(i), user32.KEYEVENTF_UNICODE)
        print_input(inps[(i-1)*2+1])
        add_input(inps[(i-1)*2+2], 0, msg:byte(i), bit.bor(user32.KEYEVENTF_UNICODE, user32.KEYEVENTF_KEYUP))
        print_input(inps[(i-1)*2+2])
    end

    add_input(inps[len*2 + 1], 162, 0, 0)
    
    user32.SendInput(len*2 + 2, inps, ffi.sizeof("INPUT"))
end

local function kbcallback(event)
    local key = event.virtualkey

    keystate[key] = not event.released

    -- Win + Shift + Q = exit
    if keystate[91] and keystate[160] and keystate[81] then
        print "Win+Shift+Q, quitting"
        return false, true
    end

    -- Ctrl + H = hello world
    if keystate[162] and keystate[0x48] then
        write_input "hello, world!"

        return true, true
    end

    if keystate[162] and keystate[0x47] then
        write_input "wew\tlad\n"

        return true, true
    end

    return true, false
end

local function focuschange(hwnd)
    print("focus", hwnd)
end

local back = backend.create(kbcallback, focuschange)
back:pump()
back:close()