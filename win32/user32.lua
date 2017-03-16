local ffi = require "ffi"

require "win32/types"
require "win32/consts"

ffi.cdef [[ // Structs
    typedef struct tagPOINT {
        LONG  x;
        LONG  y;
    } POINT, *PPOINT, *NPPOINT, *LPPOINT;

    typedef struct tagMSG {
        HWND   hwnd;
        UINT   message;
        WPARAM wParam;
        LPARAM lParam;
        DWORD  time;
        POINT  pt;
    } MSG, *PMSG, *LPMSG;

    typedef struct tagKBDLLHOOKSTRUCT {
        DWORD   vkCode;
        DWORD   scanCode;
        DWORD   flags;
        DWORD   time;
        ULONG_PTR dwExtraInfo;
    } KBDLLHOOKSTRUCT, *LPKBDLLHOOKSTRUCT, *PKBDLLHOOKSTRUCT;
    
    typedef struct tagMOUSEINPUT {
        LONG      dx;
        LONG      dy;
        DWORD     mouseData;
        DWORD     dwFlags;
        DWORD     time;
        ULONG_PTR dwExtraInfo;
    } MOUSEINPUT, *PMOUSEINPUT;

    typedef struct tagKEYBDINPUT {
        WORD      wVk;
        WORD      wScan;
        DWORD     dwFlags;
        DWORD     time;
        ULONG_PTR dwExtraInfo;
    } KEYBDINPUT, *PKEYBDINPUT;

    typedef struct tagHARDWAREINPUT {
        DWORD uMsg;
        WORD  wParamL;
        WORD  wParamH;
    } HARDWAREINPUT, *PHARDWAREINPUT;

    typedef struct tagINPUT {
        DWORD type;
        union {
            MOUSEINPUT    mi;
            KEYBDINPUT    ki;
            HARDWAREINPUT hi;
        };
    } INPUT, *PINPUT, *LPINPUT;
]]

ffi.cdef [[ // Functions
    HHOOK SetWindowsHookExA(int idHook, HOOKPROC lpfn, HINSTANCE hMod, DWORD dwThreadId);
    BOOL UnhookWindowsHookEx(HHOOK hhk);
    LRESULT CallNextHookEx(HHOOK hhk, int nCode, WPARAM wParam, LPARAM lParam);

    BOOL PostMessage(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
    void PostQuitMessage(int nExitCode);
    BOOL PostThreadMessageA(DWORD idThread, UINT Msg, WPARAM wParam, LPARAM lParam);
    int SendMessageA(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
    BOOL TranslateMessage(const MSG *lpMsg);
    LRESULT DispatchMessageA(const MSG *lpmsg);
    BOOL GetMessageA(PMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax);
    LPARAM GetMessageExtraInfo(void);
    BOOL PeekMessageA(PMSG lpMsg, HWND hWnd, UINT wMsgFilterMin, UINT wMsgFilterMax, UINT wRemoveMsg);
    BOOL WaitMessage(void);

    UINT SendInput(UINT nInputs, LPINPUT pInputs, int cbSize);
    DWORD GetLastError(void);

    HWND GetForegroundWindow(void);
    int GetClassNameA(HWND hWnd, LPTSTR lpClassName, int nMaxCount);

    HWINEVENTHOOK SetWinEventHook(UINT eventMin, UINT eventMax, HMODULE hmodWinEventProc,
        WINEVENTPROC lpfnWinEventProc, DWORD idProcess, DWORD idThread, UINT dwflags);

    BOOL UnhookWinEvent(HWINEVENTHOOK hWinEventHook);
]]

return setmetatable({
    SetWindowsHookEx = ffi.C.SetWindowsHookExA,
    PostThreadMessage = ffi.C.PostThreadMessageA,
    SendMessage = ffi.C.SendMessageA,
    DispatchMessage = ffi.C.DispatchMessageA,
    GetMessage = ffi.C.GetMessageA,
    PeekMessage = ffi.C.PeekMessageA,
    GetClassName = ffi.C.GetClassNameA
}, { __index = ffi.C })