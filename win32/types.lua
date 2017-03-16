local ffi = require "ffi"
local user32 = ffi.load "user32"

local _WIN64 = ffi.os == "Windows" and ffi.abi("64bit")

ffi.cdef [[
    typedef char            CHAR;
    typedef unsigned char   UCHAR;
    typedef unsigned char   BYTE;
    typedef int16_t         SHORT;
    typedef unsigned short  USHORT;
    typedef uint16_t        WORD;
    typedef int             INT;
    typedef unsigned int    UINT;
    typedef long            LONG;
    typedef unsigned long   ULONG;
    typedef unsigned long   DWORD;
    typedef int64_t         LONGLONG;
    typedef uint64_t        ULONGLONG;
    typedef uint64_t        DWORDLONG;

    typedef uint64_t        *PDWORDLONG;

    typedef int8_t          INT8, *PINT8;
    typedef int16_t         INT16, *PINT16;
    typedef int32_t         INT32, *PINT32;
    typedef int64_t         INT64, *PINT64;
    typedef uint8_t         UINT8, *PUINT8;
    typedef uint16_t        UINT16, *PUINT16;
    typedef uint32_t        UINT32, *PUINT32;
    typedef uint64_t        UINT64, *PUINT64;

    typedef int32_t         LONG32, *PLONG32;
    typedef uint32_t        ULONG32, *PULONG32;
    typedef uint32_t        DWORD32, *PDWORD32;
]]

if _WIN64 then
    ffi.cdef [[
        typedef int64_t     INT_PTR, *PINT_PTR;
        typedef uint64_t    UINT_PTR, *PUINT_PTR;
        typedef intptr_t    LONG_PTR, *PLONG_PTR, *PLONG_PTR;
        typedef uint64_t    ULONG_PTR, *PULONG_PTR;
    ]]
else
    ffi.cdef [[
        typedef int             INT_PTR, *PINT_PTR;
        typedef unsigned int    UINT_PTR, *PUINT_PTR;
        typedef intptr_t        LONG_PTR, *PLONG_PTR;
        typedef unsigned long   ULONG_PTR, *PULONG_PTR;
    ]]
end

ffi.cdef [[
    typedef ULONG_PTR       SIZE_T, *PSIZE_T;
    typedef LONG_PTR        SSIZE_T, *PSSIZE_T;
    typedef ULONG_PTR       DWORD_PTR, *PDWORD_PTR;
    typedef int64_t         LONG64, *PLONG64;
    typedef uint64_t        ULONG64, *PULONG64;
    typedef uint64_t        DWORD64, *PDWORD64;

    typedef uint32_t        *PDWORD;
    typedef long            *PLONG;
    typedef long            *LPLONG;
    typedef unsigned char   *PBYTE;

    typedef BYTE            BOOLEAN;

    typedef wchar_t         WCHAR;

    typedef long            BOOL;
    typedef long            *PBOOL;

    typedef int             *LPINT;
    typedef int             *PINT;

    typedef float           FLOAT;
    typedef double          DOUBLE;

    typedef uint8_t         BCHAR;
    typedef unsigned int    UINT32;

    typedef char            *PCHAR;
    typedef const char      *PCCHAR;
    typedef unsigned char   *PUCHAR;
    typedef char            *PSTR;

    typedef uint16_t        *PWCHAR;

    typedef unsigned char   *PBOOLEAN;
    typedef const unsigned char *PCUCHAR;
    typedef unsigned int    *PUINT;
    typedef unsigned int    *PUINT32;
    typedef unsigned long   *PULONG;
    typedef unsigned short  *PUSHORT;
    typedef LONGLONG        *PLONGLONG;
    typedef ULONGLONG       *PULONGLONG;


    typedef void            VOID;
    typedef void            *PVOID;


    typedef DWORD           *LPCOLORREF;

    typedef BOOL            *LPBOOL;
    typedef BYTE            *LPBYTE;
    typedef char            *LPSTR;
    typedef short           *LPWSTR;
    typedef short           *PWSTR;
    typedef const           WCHAR *LPCWSTR;
    typedef const           WCHAR *PCWSTR;
    typedef PWSTR           *PZPWSTR;
    typedef LPSTR           LPTSTR;

    typedef DWORD           *LPDWORD;
    typedef void            *LPVOID;
    typedef WORD            *LPWORD;

    typedef const char      *LPCSTR;
    typedef const char      *PCSTR;
    typedef LPCSTR          LPCTSTR;
    typedef const void      *LPCVOID;


    typedef LONG_PTR        LRESULT;

    typedef LONG_PTR        LPARAM;
    typedef UINT_PTR        WPARAM;


    typedef unsigned char   TBYTE;
    typedef char            TCHAR;

    typedef USHORT          COLOR16;
    typedef DWORD           COLORREF;

    // Special types
    typedef WORD            ATOM;
    typedef DWORD           LCID;
    typedef USHORT          LANGID;

    typedef PVOID           HANDLE;
    typedef HANDLE          HWND;
    typedef HANDLE          HINSTANCE;
    typedef HANDLE          HMODULE;
    typedef HANDLE          HHOOK;
    typedef HANDLE          HWINEVENTHOOK;

    typedef LRESULT (*HOOKPROC)(int code, WPARAM wParam, LPARAM lParam);
    typedef void (*WINEVENTPROC)(HWINEVENTHOOK hWinEventHook, DWORD event, HWND hwnd, LONG idObject,
        LONG idChild, DWORD dwEventThread, DWORD dwmsEventTime);
]]

return setmetatable({}, {
    __index = ffi.C
})