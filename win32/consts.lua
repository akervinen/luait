local ffi = require "ffi"

require "win32/types"

ffi.cdef [[
    static const int WS_POPUP = 0x80000000;
    static const int WS_MAXIMIZEBOX  = 0x00010000;
    static const int WS_SIZEBOX  = 0x00040000;
    static const int WS_SYSMENU  = 0x00080000;
    static const int WS_HSCROLL  = 0x00100000;
    static const int WS_VSCROLL  = 0x00200000;
    static const int WS_OVERLAPPEDWINDOW = 0x00CF0000;
    static const int WS_MAXIMIZE  = 0x01000000;
    static const int WS_VISIBLE  = 0x10000000;
    static const int WS_MINIMIZE  = 0x20000000;
    static const int WS_EX_WINDOWEDGE = 0x00000100;
    static const int WS_EX_APPWINDOW = 0x00040000;

    static const int WM_CREATE  = 0x0001;
    static const int WM_DESTROY  = 0x0002;
    static const int WM_SIZE  = 0x0005;
    static const int WM_ACTIVATE  = 0x0006;
    static const int WM_SETFOCUS = 0x0007;
    static const int WM_KILLFOCUS = 0x0008;
    static const int WM_ENABLE = 0x000A;
    static const int WM_SETTEXT  = 0x000C;
    static const int WM_GETTEXT  = 0x000D;
    static const int WM_PAINT = 0x000F;
    static const int WM_CLOSE  = 0x0010;
    static const int WM_QUIT  = 0x0012;
    static const int WM_ACTIVATEAPP  = 0x001C;
    static const int WM_SETCURSOR  = 0x0020;
    static const int WM_GETMINMAXINFO  = 0x0024;
    static const int WM_WINDOWPOSCHANGING = 0x0046;
    static const int WM_WINDOWPOSCHANGED = 0x0047;
    static const int WM_NCCREATE  = 0x0081;
    static const int WM_NCDESTROY  = 0x0082;
    static const int WM_NCCALCSIZE  = 0x0083;
    static const int WM_NCHITTEST  = 0x0084;
    static const int WM_NCPAINT  = 0x0085;
    static const int WM_NCACTIVATE  = 0x0086;

    static const int WM_NCMOUSEMOVE  = 0x00A0;
    static const int WM_NCLBUTTONDOWN  = 0x00A1;
    static const int WM_NCLBUTTONUP  = 0x00A2;
    static const int WM_NCLBUTTONDBLCLK  = 0x00A3;
    static const int WM_NCRBUTTONDOWN  = 0x00A4;
    static const int WM_NCRBUTTONUP  = 0x00A5;
    static const int WM_NCRBUTTONDBLCLK  = 0x00A6;
    static const int WM_NCMBUTTONDOWN  = 0x00A7;
    static const int WM_NCMBUTTONUP  = 0x00A8;
    static const int WM_NCMBUTTONDBLCLK  = 0x00A9;
    static const int WM_INPUT_DEVICE_CHANGE = 0x00FE;
    static const int WM_INPUT = 0x00FF;

    static const int WM_KEYDOWN = 0x0100;
    static const int WM_KEYUP = 0x0101;
    static const int WM_CHAR = 0x0102;
    static const int WM_DEADCHAR = 0x0103;
    static const int WM_SYSKEYDOWN = 0x0104;
    static const int WM_SYSKEYUP = 0x0105;
    static const int WM_SYSCHAR = 0x0106;
    static const int WM_SYSDEADCHAR = 0x0107;
    static const int WM_COMMAND = 0x0111;
    static const int WM_SYSCOMMAND = 0x0112;
    static const int WM_TIMER = 0x0113;

    static const int WM_MOUSEFIRST = 0x0200;
    static const int WM_MOUSEMOVE = 0x0200;
    static const int WM_LBUTTONDOWN = 0x0201;
    static const int WM_LBUTTONUP = 0x0202;
    static const int WM_LBUTTONDBLCLK = 0x0203;
    static const int WM_RBUTTONDOWN = 0x0204;
    static const int WM_RBUTTONUP = 0x0205;
    static const int WM_RBUTTONDBLCLK = 0x0206;
    static const int WM_MBUTTONDOWN = 0x0207;
    static const int WM_MBUTTONUP = 0x0208;
    static const int WM_MBUTTONDBLCLK = 0x0209;
    static const int WM_MOUSEWHEEL = 0x020A;
    static const int WM_XBUTTONDOWN = 0x020B;
    static const int WM_XBUTTONUP = 0x020C;
    static const int WM_XBUTTONDBLCLK = 0x020D;
    static const int WM_MOUSELAST = 0x020D;

    static const int WM_SIZING  = 0x0214;
    static const int WM_CAPTURECHANGED  = 0x0215;
    static const int WM_MOVING  = 0x0216;
    static const int WM_DEVICECHANGE  = 0x0219;
    static const int WM_ENTERSIZEMOVE  = 0x0231;
    static const int WM_EXITSIZEMOVE  = 0x0232;
    static const int WM_DROPFILES  = 0x0233;
    static const int WM_IME_SETCONTEXT  = 0x0281;
    static const int WM_IME_NOTIFY  = 0x0282;
    static const int WM_NCMOUSEHOVER = 0x02A0;
    static const int WM_MOUSEHOVER  = 0x02A1;
    static const int WM_NCMOUSELEAVE = 0x02A2;
    static const int WM_MOUSELEAVE = 0x02A3;
    static const int WM_PRINT = 0x0317;
    static const int WM_DWMCOMPOSITIONCHANGED = 0x031E;
    static const int WM_DWMNCRENDERINGCHANGED = 0x031F;
    static const int WM_DWMCOLORIZATIONCOLORCHANGED = 0x0320;
    static const int WM_DWMWINDOWMAXIMIZEDCHANGE = 0x0321;

    static const int SW_SHOW = 5;

    static const int PM_REMOVE = 0x0001;
    static const int PM_NOYIELD = 0x0002;

    static const int HC_ACTION = 0;

    static const int WH_KEYBOARD_LL = 13;

    static const int LLKHF_EXTENDED = 0x0001;
    static const int LLKHF_UP = 0x0080;

    static const int MOUSEEVENTF_ABSOLUTE = 0x8000;
    static const int MOUSEEVENTF_HWHEEL = 0x01000;
    static const int MOUSEEVENTF_MOVE = 0x0001;
    static const int MOUSEEVENTF_MOVE_NOCOALESCE = 0x2000;
    static const int MOUSEEVENTF_LEFTDOWN = 0x0002;
    static const int MOUSEEVENTF_LEFTUP = 0x0004;
    static const int MOUSEEVENTF_RIGHTDOWN = 0x0008;
    static const int MOUSEEVENTF_RIGHTUP = 0x0010;
    static const int MOUSEEVENTF_MIDDLEDOWN = 0x0020;
    static const int MOUSEEVENTF_MIDDLEUP = 0x0040;
    static const int MOUSEEVENTF_VIRTUALDESK = 0x4000;
    static const int MOUSEEVENTF_WHEEL = 0x0800;
    static const int MOUSEEVENTF_XDOWN = 0x0080;
    static const int MOUSEEVENTF_XUP = 0x0100;

    static const int KEYEVENTF_EXTENDEDKEY = 0x0001;
    static const int KEYEVENTF_KEYUP = 0x0002;
    static const int KEYEVENTF_SCANCODE = 0x0008;
    static const int KEYEVENTF_UNICODE = 0x0004;

    static const int INPUT_MOUSE = 0;
    static const int INPUT_KEYBOARD = 1;
    static const int INPUT_HARDWARE = 2;

    static const int WINEVENT_INCONTEXT = 4;
    static const int WINEVENT_OUTOFCONTEXT = 0;
    static const int WINEVENT_SKIPOWNPROCESS = 2;
    static const int WINEVENT_SKIPOWNTHREAD = 1;

    static const int EVENT_SYSTEM_FOREGROUND = 3;
]]

return setmetatable({}, {
    __index = ffi.C
})