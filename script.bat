::run.bat

@echo off
setlocal enabledelayedexpansion

set categories=L0,L1,L2,C70,C80

set count=0
set parameters=
set valid=1

if "%1"=="" goto runMvn

echo ==============================================
echo Check all passed parameters
time/t
echo ==============================================
:LOOP

:: count++
set count+=1

:: Read the parameter
for %%i in (%categories%) do (
  echo Case - %%i
  if /i "%1"=="%%i" (
    echo %1 --------------- correct
    call:myDosFunc %%i
    goto shift
  )
)

:: We check all categories, but no one matching
echo %1 --------------- incorrect
set valid=0

:shift
shift /1

if "%1"=="" goto checkPara
goto LOOP
:END

:checkPara
if %valid%==0 (
  echo Please correct your parameters
  goto endOfBatch
) else (
  goto setPara
)

:setPara
echo ==============================================
echo The parameters got passed
time/t
echo ==============================================
echo %parameters%
set parameters=-Dgroups="%parameters%"
echo Parameters: %parameters%

:runMvn
echo ==============================================
echo Run mvn
time/t
echo ==============================================
echo mvn test %parameters%
mvn test %parameters%


goto endOfBatch

:: Define my functions
:myDosFunc - here starts my function identified by it`s label
  set category=%1

  if defined parameters (
    echo old parameters: !parameters!
    echo new category: !category!

    echo !parameters! | findstr !category!>nul && (
        echo We already has category !category! in parameters
    ) || (
        echo This is a new category to be included
        set newPara=, com.huawei.hec.mls.restapi.category.!category!Test
        echo Func - newPara: !newPara!
        set parameters=%parameters%!newPara!
        echo Func - parameters: %parameters%
        echo !parameters!
    )
  ) else (
    set parameters=com.huawei.hec.mls.restapi.category.!category!Test
    echo Func - parameters: %parameters%
    echo !parameters!
  )
goto:eof


:endOfBatch
