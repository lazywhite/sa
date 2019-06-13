## 死循环与sleep
```
@echo off

:start
taskkill /F /IM dllhost.exe
choice /t 5 /d y /n >nul

goto start
```
