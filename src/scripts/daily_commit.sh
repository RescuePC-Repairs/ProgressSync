#!/bin/bash
# =============================================
# RescuePC Repairs - ProgressSync
# Daily Commit Script
# 
# This script automatically commits changes to the repository
# and pushes them to the remote origin.
# =============================================

# Display colorful output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print script header
echo -e "${BLUE}=====================================================${NC}"
echo -e "${BLUE}      RescuePC Repairs - ProgressSync                ${NC}"
echo -e "${BLUE}      Automatic Daily Commit Script                  ${NC}"
echo -e "${BLUE}=====================================================${NC}"

# Navigate to the repository root directory (parent of the script directory)
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
REPO_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
cd "$REPO_ROOT" || { echo -e "${RED}Failed to navigate to repository root.${NC}"; exit 1; }

echo -e "${YELLOW}Working directory:${NC} $(pwd)"

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo -e "${RED}Error: Not a git repository.${NC}"
    echo "Please make sure this script is located in src/scripts/ of your repository."
    exit 1
fi

# Check if logs.json exists and create a backup
if [ -f logs.json ]; then
    echo -e "${YELLOW}Creating backup of logs.json...${NC}"
    cp logs.json "logs_backup_$(date +"%Y%m%d").json"
fi

# Get the current status
echo -e "${YELLOW}Checking for changes...${NC}"
git status -s

# Check if there are any changes to commit
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${GREEN}No changes to commit.${NC}"
    exit 0
fi

# Add all changes
echo -e "${YELLOW}Adding changes to staging area...${NC}"
git add .

# Create a descriptive commit message with date and summary of changes
CHANGES=$(git status --porcelain | wc -l)
COMMIT_MSG="Daily update ($(date +"%Y-%m-%d")): ${CHANGES} file(s) modified"

# Add specific details if logs.json was modified
if git status --porcelain | grep -q "logs.json"; then
    # Count the entries if jq is available
    if command -v jq &> /dev/null; then
        ENTRIES=$(jq length logs.json 2>/dev/null)
        if [ $? -eq 0 ]; then
            COMMIT_MSG="${COMMIT_MSG}, now tracking ${ENTRIES} repair entries"
        fi
    fi
fi

# Commit changes
echo -e "${YELLOW}Committing changes...${NC}"
git commit -m "$COMMIT_MSG"

# Check if commit was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to commit changes.${NC}"
    exit 1
fi

# Push to origin if remote exists
echo -e "${YELLOW}Checking remote repository...${NC}"
if git remote -v | grep -q origin; then
    echo -e "${YELLOW}Pushing changes to remote repository...${NC}"
    git push origin "$(git branch --show-current)"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Successfully pushed changes to remote repository.${NC}"
    else
        echo -e "${RED}Failed to push changes to remote repository.${NC}"
        echo -e "${YELLOW}Your changes have been committed locally.${NC}"
        echo -e "${YELLOW}You'll need to push them manually when you're online.${NC}"
    fi
else
    echo -e "${YELLOW}No remote repository found. Changes committed locally only.${NC}"
fi

# Display success message
echo -e "${GREEN}=====================================================${NC}"
echo -e "${GREEN}Commit completed successfully!${NC}"
echo -e "${GREEN}Commit message: ${COMMIT_MSG}${NC}"
echo -e "${GREEN}=====================================================${NC}"

# Add a note about setting up as a scheduled task
echo -e "${BLUE}NOTE:${NC} To automate this process, set up this script as a:"
echo -e "  - ${YELLOW}Cron job${NC} (Linux/macOS): ${BLUE}0 20 * * * $SCRIPT_DIR/daily_commit.sh${NC}"
echo -e "  - ${YELLOW}Task Scheduler${NC} (Windows): Run daily at 8:00 PM"
echo -e "${BLUE}=====================================================${NC}"

exit 0