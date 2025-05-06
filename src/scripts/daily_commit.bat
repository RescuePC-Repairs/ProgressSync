@echo off
:: =============================================
:: RescuePC Repairs - ProgressSync
:: Daily Commit Script (Windows Version)
:: 
:: This script automatically commits changes to the repository
:: and pushes them to the remote origin.
:: =============================================

echo.
echo =====================================================
echo       RescuePC Repairs - ProgressSync 
echo       Automatic Daily Commit Script (Windows)
echo =====================================================
echo.

:: Navigate to the repository root directory
cd /d "%~dp0\..\..\"

echo Working directory: %CD%

:: Check if we're in a git repository
if not exist ".git" (
    echo Error: Not a git repository.
    echo Please make sure this script is located in src\scripts\ of your repository.
    pause
    exit /b 1
)

:: Create a backup of logs.json if it exists
if exist "logs.json" (
    echo Creating backup of logs.json...
    copy "logs.json" "logs_backup_%date:~-4,4%%date:~-7,2%%date:~-10,2%.json" > nul
)

:: Check if there are any changes
echo Checking for changes...
git status -s

:: Check if there are changes to commit
git status --porcelain > temp_status.txt
for %%I in (temp_status.txt) do if %%~zI == 0 (
    echo No changes to commit.
    del temp_status.txt
    pause
    exit /b 0
)
del temp_status.txt

:: Add all changes
echo Adding changes to staging area...
git add .

:: Create commit message with date
set "COMMIT_MSG=Daily update (%date:~-4,4%-%date:~-7,2%-%date:~-10,2%): Files modified"

:: Commit changes
echo Committing changes...
git commit -m "%COMMIT_MSG%"

if %ERRORLEVEL% neq 0 (
    echo Failed to commit changes.
    pause
    exit /b 1
)

:: Push to remote if it exists
echo Checking remote repository...
git remote -v | findstr "origin" > nul
if %ERRORLEVEL% equ 0 (
    echo Pushing changes to remote repository...
    
    :: Get current branch name
    for /f "tokens=*" %%a in ('git branch --show-current') do set "CURRENT_BRANCH=%%a"
    
    git push origin %CURRENT_BRANCH%
    
    if %ERRORLEVEL% equ 0 (
        echo Successfully pushed changes to remote repository.
    ) else (
        echo Failed to push changes to remote repository.
        echo Your changes have been committed locally.
        echo You'll need to push them manually when you're online.
    )
) else (
    echo No remote repository found. Changes committed locally only.
)

:: Display success message
echo.
echo =====================================================
echo Commit completed successfully!
echo Commit message: %COMMIT_MSG%
echo =====================================================
echo.

:: Add a note about scheduling
echo NOTE: To automate this process, add this script to Windows Task Scheduler:
echo  1. Open Task Scheduler
echo  2. Create a new Basic Task named "ProgressSync Daily Commit"
echo  3. Set trigger to Daily at 8:00 PM
echo  4. Set action to Start a Program and select this batch file
echo  5. Finish the wizard
echo =====================================================

pause
exit /b 0