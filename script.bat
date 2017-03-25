set category_length=5
set category_index=0
set category[0]=L0
set category[1]=L1
set category[2]=L2
set category[3]=C70
set category[4]=C80


SET /A category_indexEndPoint=%category_length% - 1
for /l %%i in (0, 1, %category_indexEndPoint%) do (
  echo %%i
  echo ********
)


:LoopStart
IF %category_index% EQU %category_length% GOTO :EOF

set category_current=category[%category_index%]

echo %category_current%
echo %category[1]=L1%

SET /A category_index=%category_index% + 1

GOTO LoopStart




if /i "%1"=="L0" (
  echo 2222
  echo %1

  echo CallMyFunc
  call:myDosFunc L0
  echo ReturnedFromFunc

  goto shift
)

if /i "%1"=="L1" (
  call:myDosFunc L1

  goto shift
)

if /i "%1"=="L2" (
  call:myDosFunc L2

  goto shift
)
