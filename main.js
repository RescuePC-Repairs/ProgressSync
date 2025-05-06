// main.js

document.addEventListener('DOMContentLoaded', () => {
    const logForm = document.getElementById('logForm');
    const logList = document.getElementById('logList');
    const searchInput = document.getElementById('searchLogs');
    const logs = JSON.parse(localStorage.getItem('logs')) || [];

    // Render Logs List
    const renderLogs = () => {
        logList.innerHTML = '';
        logs.forEach((log, index) => {
            const li = document.createElement('li');
            li.innerHTML = `
                <span class="log-date">${log.date}</span>
                <p class="log-text">${log.entry}</p>
                <button class="edit-btn" onclick="editLog(${index})">Edit</button>
                <button class="delete-btn" onclick="deleteLog(${index})">Delete</button>
            `;
            logList.appendChild(li);
        });
    };

    // Add new log entry
    logForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const entry = document.getElementById('logEntry').value.trim();
        const logDate = document.getElementById('logDate').value;

        if (entry && logDate) {
            const log = { date: logDate, entry };
            logs.push(log);
            localStorage.setItem('logs', JSON.stringify(logs));
            renderLogs();
            logForm.reset();
        }
    });

    // Edit log entry
    window.editLog = (index) => {
        const newEntry = prompt("Edit your log:", logs[index].entry);
        if (newEntry) {
            logs[index].entry = newEntry;
            localStorage.setItem('logs', JSON.stringify(logs));
            renderLogs();
        }
    };

    // Delete log entry
    window.deleteLog = (index) => {
        if (confirm("Are you sure you want to delete this entry?")) {
            logs.splice(index, 1);
            localStorage.setItem('logs', JSON.stringify(logs));
            renderLogs();
        }
    };

    // Filter logs by search
    window.filterLogs = () => {
        const searchQuery = searchInput.value.toLowerCase();
        logList.innerHTML = '';
        logs.forEach((log, index) => {
            if (log.entry.toLowerCase().includes(searchQuery) || log.date.includes(searchQuery)) {
                const li = document.createElement('li');
                li.innerHTML = `
                    <span class="log-date">${log.date}</span>
                    <p class="log-text">${log.entry}</p>
                    <button class="edit-btn" onclick="editLog(${index})">Edit</button>
                    <button class="delete-btn" onclick="deleteLog(${index})">Delete</button>
                `;
                logList.appendChild(li);
            }
        });
    };

    searchInput.addEventListener("keyup", filterLogs);
    renderLogs();
});

// Modal handling for delete confirmation
const deleteModal = document.getElementById('deleteModal');
const cancelDelete = document.getElementById('cancelDelete');
const confirmDelete = document.getElementById('confirmDelete');
let entryToDelete = null;

// Function to show the delete confirmation modal
function showDeleteModal(entryId) {
  entryToDelete = entryId;
  deleteModal.classList.add('active');
}

// Function to hide the delete confirmation modal
function hideDeleteModal() {
  deleteModal.classList.remove('active');
  entryToDelete = null;
}

// Event listener for the cancel button
cancelDelete.addEventListener('click', () => {
  hideDeleteModal();
});

// Event listener for the confirm delete button
confirmDelete.addEventListener('click', () => {
  if (entryToDelete) {
    // Delete the entry
    deleteLogEntry(entryToDelete);
    hideDeleteModal();
  }
});

// Example function to set up delete buttons
function setupDeleteButtons() {
  const deleteButtons = document.querySelectorAll('.delete-btn');
  
  deleteButtons.forEach(button => {
    button.addEventListener('click', (e) => {
      const logItem = e.target.closest('.log-item');
      const entryId = logItem.dataset.id;
      showDeleteModal(entryId);
    });
  });
}

// Example function to actually delete the entry
function deleteLogEntry(entryId) {
  // Get existing logs from localStorage
  const logs = JSON.parse(localStorage.getItem('progressLogs') || '[]');
  
  // Filter out the entry to delete
  const updatedLogs = logs.filter(log => log.id !== entryId);
  
  // Save back to localStorage
  localStorage.setItem('progressLogs', JSON.stringify(updatedLogs));
  
  // Update the UI
  displayLogs(updatedLogs);
}