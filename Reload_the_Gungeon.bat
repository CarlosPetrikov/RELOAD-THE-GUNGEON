@echo off

@REM !!! PUT HERE THE LOCATION OF THE GAME EXECUTABLE !!!
@REM e.g:    "C:\Program Files\Epic Games\EnterTheGungeon\EtG.exe"

set EXE_GAME=""

@REM !!! PUT HERE THE LETTER OF THE SAVE SLOT !!! (standard: SlotA)

set SLOT=A

@REM |-----MODIFY THE REST OF THE CODE AT YOUR OWN RISK!-----|

@REM CHANGE THE SIZE OF CMD WINDOW AND SHOW FOR 1 SECOND THE ASCII ART
mode 46,26
cls
color f
echo ==========(AUTO)RELOAD THE GUNGEON===========
echo ooooooooooooooooooooooooooooooooooooooooooooo
echo yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
echo yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
echo yyyyyyyyyyyyyyyyyo/:-..-:/oyyyyyyyyyyyyyyyyyy
echo yyyyyyyyyyyyyys:``:/oooo/:``:yyyyyyyyyyyyyyyy
echo yyyyyyyyyyyyy+`.+yyyyyyyyyy+/yyyyyyyyyyyyyyyy
echo yyyyyyyyyyyyo`.syyyyyyyyyyyyyyyyyyyyyyyyyyyyy
echo yyyyyyyyyyyy-`+yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
echo yyyyyyyyyyyy-`+yyyyyyyyyyyyyyyyosyyyyyyyyyyyy
echo yyyyyyyyyyyy+`.yyyyyyyyyo/:-.```-yyyyyyyyyyyy
echo yyyyyyyyyyyyy/`.oyyyyyyys-``````oyyyyyyyyyyyy
echo yyyyyyyyyyyyyys:`./+osso+:`````-yyyyyyyyyyyyy
echo yyyyyyyyyyyyyyyyy+:-....-:+ss:`oyyyyyyyyyyyyy
echo yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
echo yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
echo yyyyyo+/+syyyyyyyyyyyyyyyyyyyyyyyyyo+/+oyyyyy
echo yyy/`     .oyyyyyyyyyyyyyyyyyyyyy+`     `+yyy
echo yy+        `yyyyyyyyyyyyyyyyyyyys        `yyy
echo yy+        .yyyyy           yyyys        .syy
echo yyy+.     .syyyyy.         .yyyyyo.     .oyyy
echo yyyyysoosyyyyyyyyyy       yyyyyyyyyyoooyyyyyy
echo yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
echo yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy 
timeout /T 1 /NOBREAK > nul
@REM CHANGE THE SIZE WINDOW AGAIN
mode 46,11

@REM CHANGE TO THE DIRECTORY WHERE ARE THE GAME DATA
cd %APPDATA% && cd.. && cd "LocalLow\Dodge Roll\Enter the Gungeon"

@REM CHECK AND/OR CREATE THE BACKUP DIRECTORY
if exist "bkp" (
	echo Backup directory already exists.
) else (
	echo The directory is missing and will now be created.
	mkdir bkp
)

:Menu

		@REM SELECTION MENU LAYOUT
		cls
		echo ---------------------------------------------
		echo =================EtGSaveScum=================
		echo ---------------------------------------------
		echo      1.          SAVE BACKUP
		echo      2.       RESTORE THE BACKUP
		echo      3.  LOOP MODE (view the README.md)
		echo ---------------------------------------------
		echo ==============PRESS 'Q' TO QUIT==============
		echo ---------------------------------------------
		echo.

		@REM VARIABLE THAT WILL READ THE USER INPUT
		set INPUT=
		set /p INPUT=Please select a number:

		if /i '%INPUT%'=='1' goto Selection1
		if /i '%INPUT%'=='2' goto Selection2
		if /i '%INPUT%'=='3' goto Selection3
		if /i '%INPUT%'=='Q' goto Quit

		cls

		@REM IF THE USER SELECTS AN OPTION DIFFERENT FROM THE PRE-DETERMINED
		echo ---------------------------------------------
		echo ================INVALID INPUT================
		echo ---------------------------------------------
		echo     Please select a number from the Main
		echo       Menu [1-3] or select 'Q' to quit.
		echo ---------------------------------------------
		echo ==========PRESS ANY KEY TO CONTINUE==========
		echo ---------------------------------------------
		
		pause > nul
		goto menu

	:Selection1

		@REM IF THE FILE THAT INDICATES A SAVE IS PRESENT, THE BACKUP WILL BE PERFORMED
		if exist "Active%slot%.game" (
			echo Backing up the save...
			copy Slot%slot%.save bkp /y
			copy Active%slot%.game bkp /y
			cls
            echo ---------------------------------------------
			echo ========BACKUP COMPLETED SUCCESSFULLY========
			echo ---------------------------------------------
			echo ==========PRESS ANY KEY TO CONTINUE==========
			echo ---------------------------------------------
			
			pause > nul
			goto menu
		@REM OTHERWISE, HE WILL NOTIFY THE USER TO CHECK IF THE SAVE DOES EXIST
		) else (
			echo  There are no save games!
			echo ---------------------------
			echo Please see if the save even
			echo exists and try again later.
			pause
			goto menu
		)

	:Selection2

		@REM IF THE FILE THAT INDICATES A BACKUP IS PRESENT, THE RESTORE WILL BE PERFORMED 
		if exist "bkp\Active%slot%.game" (
			copy bkp\Slot%slot%.save /y
			copy bkp\Active%slot%.game /y
			goto reg1
		@REM OTHERWISE, HE WILL NOTIFY THE USER TO CHECK IF BACKUP WAS DONE
		) else (
			echo There is no backup of save! 
			echo ---------------------------
			echo   Please try to do backup 
			echo  again and try later.
			pause
			goto menu
		)
		
		:reg1
			@REM WILL DELETE THE VALUE ON WINDOWS REGISTRY THAT MAKES THIS CHEAT DOESNT WORK
			set value=
			for /f "delims=" %%i in ('reg query "HKCU\Software\Dodge Roll\Enter the Gungeon" /v "*mgs*" ^| findstr "mgs"') do (set value=%%i)	
			reg delete "HKCU\Software\Dodge Roll\Enter the Gungeon" /v "%value:~04,22%" /f
			cls
			echo ---------------------------------------------
			echo ========RESTORE COMPLETED SUCCESSFULLY=======
			echo ---------------------------------------------
			echo ==========PRESS ANY KEY TO CONTINUE==========
			echo ---------------------------------------------
			
			pause > nul
			goto menu

	:Selection3

		@REM DELETE THE LAST GAME LOG TO NOT INTERFERE ON CODE DECISION
		del output_log.txt > nul
		@REM MAKE AGAIN A SAVE RESTORE FROM BACKUP
		copy bkp\Slot%slot%.save /y > nul
		copy bkp\Active%slot%.game /y > nul
		@REM GO TO A MODIFIED VERSION OF "REG1", WHAT WILL START THE GAME AND THE LOOP
		goto reg2

		:loop
		
		@REM THIS SEGMENT WILL COMPARE THE MODIFICATION TIME OF THE CURRENT SAVE AND THE BACKUP SAVE
		set time1=00:00
		set time2=00:00
		for /f "delims=" %%a in ('dir /T ^| find "Slot%slot%.save"') do (set time1=%%a)	
		for /f "delims=" %%b in ('dir /T bkp\ ^| find "Slot%slot%.save"') do (set time2=%%b)
		@REM IF THEY ARE DIFFERENT, IT WILL BE DONE A BACKUP OF THE CURRENT SAVE (THIS ALLOWS A BACKUP IN GAME)
		if "%time1:~12,05%" NEQ "%time2:~12,05%" goto backup
			@REM CHECK IN THE LOG FILE FOR THE OCCURRENCE WHEN LIFE TURNS TO ZERO, TO DECIDE IF THE GAME WILL RESTART
			type output_log.txt | find /c "health to: 0|" > nul
			if %errorlevel%==1 (
				echo RUNNING IN THE LOOP MODE
				goto loop
			) else (
				taskkill /f /im EtG.exe
				goto reg2
			)
			
			:backup
			
				@REM CHECK THE GAME LOG EXISTENCE
				if not exist "output_log.txt" goto loop
				@REM CHECK IF THE GAME IS DELETING THE CURRENT SAVE. IF THEY ARE, THE SAME WILL NOT BACKUP
				type output_log.txt | find /c "DELETING CURRENT MID GAME SAVE" > nul
				if %errorlevel%==1 (
					copy Slot%slot%.save bkp /y > nul
					copy Active%slot%.game bkp /y > nul
					goto loop
				) else (
					goto loop
				)
					
			:reg2

				@REM A MODIFIED VERSION OF REG1, WHERE THE SAME INITIATES THE GAME EXECUTABLE AND RESTART THE LOOP 	
				set value=
				for /f "delims=" %%i in ('reg query "HKCU\Software\Dodge Roll\Enter the Gungeon" /v "*mgs*" ^| findstr "mgs"') do (set value=%%i)	
				reg delete "HKCU\Software\Dodge Roll\Enter the Gungeon" /v "%value:~04,22%" /f
				start "" %exe_game%
				goto loop
			
	:Quit

		@REM FINAL MENU THAT WILL APPEAR AFTER USING OPTIONS 1 OR 2
		cls
		echo ---------------------------------------------
		echo ==================THANKYOU===================
		echo ---------------------------------------------
		echo ==========PRESS ANY KEY TO CONTINUE==========
		echo ---------------------------------------------
		
		pause > nul
		exit

@REM AUTHOR:    Carlos Petrikov
@REM DATE:      07/14/2019
@REM THANKS TO: LINCOLN SPOSITO (for the base version of the code to separate a string from findstr), DPSkinner (for the layout and code of the batch menu) and CheatyMcCheater (for the topic that explained which files and keys to modify to enable save scumming).


