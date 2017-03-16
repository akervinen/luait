local bit = require "bit"

local user32 = require "win32/user32"

local function testflag(flags, flag)
    return bit.band(flags, flag) == flag
end

local function keyboard(event, struct)
    return {
        released = (event == user32.WM_KEYUP or event == user32.WM_SYSKEYUP),
        virtualkey = struct.vkCode,
        scancode = struct.scanCode,
        flags = {
            extended = testflag(struct.flags, user32.LLKHF_EXTENDED),
            up = testflag(struct.flags, user32.LLKHF_UP)
        }
    }
end

local function focus(hwnd)
    return hwnd
end

return {
    keyboard = keyboard,
    focus = focus
}