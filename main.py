import json
import datetime

LOG_FILE = "logs.json"

# Load existing logs
def load_logs():
    try:
        with open(LOG_FILE, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        return {}

# Save logs to file
def save_logs(logs):
    with open(LOG_FILE, "w") as file:
        json.dump(logs, file, indent=4)

# Add a new daily log
def add_log(entry):
    logs = load_logs()
    date = datetime.date.today().strftime("%Y-%m-%d")
    logs[date] = entry
    save_logs(logs)
    print(f"Log added for {date}: {entry}")

# View logs for a specific date
def view_log(date):
    logs = load_logs()
    return logs.get(date, "No entry found for this date.")

# CLI interaction
if __name__ == "__main__":
    print("Welcome to ProgressSync!")
    while True:
        action = input("Choose: (1) Add Log (2) View Log (3) Exit: ")
        if action == "1":
            entry = input("Enter today's progress: ")
            add_log(entry)
        elif action == "2":
            date = input("Enter date (YYYY-MM-DD): ")
            print(view_log(date))
        elif action == "3":
            break
        else:
            print("Invalid choice. Try again.")