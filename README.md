# 🛠️ RescuePC Repairs - ProgressSync

![RescuePC Logo](assets/logo.png)

**ProgressSync** is a streamlined web application designed to help computer repair technicians and IT professionals track daily progress on repair jobs, maintain detailed logs, and synchronize information across devices.

![Version](https://img.shields.io/badge/version-1.2.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## 📋 Overview

ProgressSync provides an intuitive interface for documenting repair progress, tracking client devices, and managing your daily workflow. Whether you're a solo repair technician or part of a team, ProgressSync helps maintain organized records of all repair activities.

### Key Features

- **📝 Daily Progress Tracking**: Log your daily repair activities and progress updates
- **🔍 Searchable Records**: Quickly find previous repair notes and history
- **🌓 Dark/Light Mode**: Eye-friendly interface for day and night use
- **🏷️ Status Tracking**: Categorize repairs by status (In Progress, Completed, Waiting for Parts, etc.)
- **📊 Data Export**: Export your logs for reporting and backup
- **📱 Responsive Design**: Works on desktop and mobile devices
- **🔄 Git Integration**: Optional automatic commits for version control (see `daily_commit.sh`)

## 🚀 Getting Started

### Prerequisites

- Modern web browser (Chrome, Firefox, Edge, Safari)
- Git (optional, for version control)
- Python 3.6+ (optional, for advanced features)

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/RescuePC-Repairs/ProgressSync
cd RescuePC-ProgressSync
```

2. **Configuration**

Copy the example environment file:

```bash
cp config/env.example config/.env
```

Edit the `.env` file to configure your preferences.

3. **Set up (Optional Python Features)**

If you want to use the Python-based features:

```bash
# Create a virtual environment
python -m venv venv

# Activate the environment
# On Windows
venv\Scripts\activate
# On macOS/Linux
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run the Python server (if needed)
python main.py
```

4. **Open the application**

Open `index.html` in your web browser, or if you're running the Python server, navigate to `http://localhost:8000`.

## 💻 Usage

### Adding a New Progress Entry

1. Navigate to the main page
2. Fill in the date field (defaults to today)
3. Enter your progress details in the text area
4. Select the appropriate status
5. Click "Save Entry"

### Finding Previous Entries

- Use the search bar to filter entries by keyword
- Use the filter buttons to show only entries with specific statuses
- Entries are displayed with the most recent at the top

### Data Export

Click the "Export Data" link in the footer to download a JSON file with all your progress entries.

### Dark Mode

Toggle between light and dark mode using the "Switch Theme" button in the header.

## 🔧 Customization

### Settings

The application settings can be modified in `config/settings.json`:

```json
{
  "maxEntries": 50,
  "defaultView": "all",
  "autoCommit": false,
  "commitInterval": "daily"
}
```

### Styling

You can customize the appearance by modifying `style.css`. The stylesheet uses CSS variables that can be easily changed to match your preferred color scheme.

## 📁 Directory Structure

```
RescuePC-ProgressSync/
├── assets/                  # Static assets
│   ├── screenshots/         # Application screenshots
│   ├── logo.png             # Application logo
│   └── ...                  # Other assets
├── config/                  # Configuration files
│   ├── env.example          # Environment template
│   └── settings.json        # Application settings
├── docs/                    # Documentation
│   ├── README.md            # General documentation
│   ├── roadmap.md           # Future development plans
│   └── setup.md             # Detailed setup instructions
├── logs/                    # Log files directory
├── src/                     # Source code
│   ├── functions/           # JavaScript functions
│   ├── scripts/             # Shell/utility scripts
│   │   └── daily_commit.sh  # Automatic git commit script
│   └── ui/                  # UI components
├── index.html               # Main HTML file
├── style.css                # Main stylesheet
├── main.js                  # Main JavaScript file
├── main.py                  # Python server (optional)
├── logs.json                # Data storage file
└── README.md                # This file
```

## 🛡️ Data Security

ProgressSync stores all data locally in your browser's localStorage by default. For additional security and backup:

- Use the Export Data feature regularly
- Enable the automatic commit script if using Git
- Do not store sensitive client information in the application

## 🔄 Git Integration

The `src/scripts/daily_commit.sh` script can be set up to automatically commit your changes:

1. Make the script executable:
   ```bash
   chmod +x src/scripts/daily_commit.sh
   ```

2. Set up a cron job (Linux/macOS) or Task Scheduler (Windows) to run the script daily.

3. Ensure the `autoCommit` setting is enabled in `config/settings.json`.

## 🐛 Troubleshooting

### Common Issues

- **Data not saving**: Make sure localStorage is enabled in your browser
- **Script errors**: Check the browser console for specific error messages
- **Style issues**: Try clearing your browser cache or using a different browser

### Getting Help

If you encounter any issues:

1. Check the [documentation](docs/README.md)
2. Open an issue on the GitHub repository
3. Contact support at support@rescuepc-repairs.com

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](assets/CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature-name`
5. Submit a pull request

## 📜 License

This project is licensed under the MIT License - see [LICENSE.md](assets/LICENSE.md) for details.

## 🙏 Acknowledgments

- Icons provided by [Feather Icons](https://feathericons.com/)
- Font: [Inter](https://fonts.google.com/specimen/Inter) by Google Fonts
- Special thanks to the RescuePC Repairs team for feedback and testing

---

Made with ❤️ by [RescuePC Repairs] - [Website](https://rescuepc-repairs.github.io/RescuePC-Repair-Toolkit/index.html)
