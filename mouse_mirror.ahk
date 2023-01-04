; Directives
#SingleInstance force
CoordMode "Mouse", "Screen"
SetDefaultMouseSpeed(0)
SetMouseDelay(-1)
SendMode "Event"

; Global variables
Half := SysGet(61) >> 1
Mirror := 1
Autofire := 0

; Function to perform mouse clicks or mouse wheel events on both halves of the screen
Dupe(action, var) {
    ; Get current mouse position
    MouseGetPos &x, &y

    ; Calculate left and right halves of the screen
    if (x < Half) {
        izq := (Half + x)
    }
    else {
        izq := (x - Half)
    }

    ; Perform mouse event on both halves of the screen
    if (action = 0) {
        if (var = 0) {
            if Mirror
                Click izq, y
            Click x, y
        }
        if (var = 1) {
            if Mirror
                Click izq, y, "WheelUp "
            Click x, y, "WheelUp "
        }
        if (var = 2) {
            if Mirror
                Click izq, y, "WheelDown"
            Click x, y, "WheelDown"
        }
    }
}

; Hotkeys
!+q::
{
    global Mirror
    Mirror := !Mirror
    ;MsgBox  "Mirror:" Mirror
}

^+q::
{
    global Autofire
    Autofire := !Autofire
    ;MsgBox  "Autofire:" Autofire
}
^!+q:: Suspend
^!+#q:: ExitApp
+#q:: Reload

; Mouse event handlers
*$LButton::
{
    loop {
;        if (Mirror) {
            Dupe(0, 0)
;        }
        global Autofire
        if (!Autofire || (GetKeyState("LButton", "P") = 0)) {
            break
        }
        Sleep 10
    }
}

*$WheelUp::
{
    loop {
;        if (Mirror) {
            Dupe(0, 1)
;        }
        global Autofire
        if (!Autofire || (GetKeyState("LButton", "P") = 0)) {
            break
        }
        Sleep 1000
    }
}

*$WheelDown::
{
    loop {
;        if (Mirror) {
            Dupe(0, 2)
;        }
        global Autofire
        if (!Autofire || (GetKeyState("LButton", "P") = 0)) {
            break
        }
        Sleep 1000
    }
}
