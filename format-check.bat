@echo off 
setlocal enabledelayedexpansion

set /a error=0

for /D %%s in (*) do ( 
    set temp=%%s
    echo !temp! | findstr /R /C:"^ex[0-9][0-9]*" && set /a state=1 || set /a state=0
    if !state!==1 (
        echo Directory !temp! detected^^!
        cd %%s
        set /a exfile=0
        for %%f in (*) do ( 
            if !temp!.c==%%f (
                echo C Source file %%f found. 
                set /a exfile=1
            )
            if !temp!.cpp==%%f (
                echo C++ Source file %%f found. 
                set /a exfile=1
            )
        )
        if !exfile!==0 (
            echo Error: No Source file found in !temp!.
        )
        echo.
        cd ..
    ) else (
        echo Error: Directory !temp! invalid.
        set /a error=1
    )
) 

echo.

if !error!==0 (
    echo Congratulations^^! All tests passed.
) else (
    echo Error found. Please check your files again^^!
)

pause
