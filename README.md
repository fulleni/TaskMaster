## TaskMaster: A Streamlined Productivity Solution 🎯

TaskMaster is a cross-platform (Android, iOS, and Web) task management application developed using Flutter.  It offers a streamlined and intuitive interface for efficient task organization and prioritization.

## ✨ Key Features

*   **📊 Task Overview Dashboard:** A centralized dashboard displays all tasks, with convenient filtering options based on completion status (completed/pending).
*   **📈 Task Statistics:** A dedicated statistics view provides insights into task completion rates, displaying the total number of tasks, completed tasks, and pending tasks. Future iterations will incorporate visual representations, such as graphs, for enhanced data analysis.
*   **➕ Task Creation:** A user-friendly interface for adding new tasks, including details such as descriptions and due dates (to be implemented in future versions).
*   **✏️ Task Editing:** Modify existing tasks seamlessly via a dedicated edit view accessible from the task overview.
*   **🗑️ Task Deletion:** Tasks can be easily removed with a swipe gesture on the task list. An undo functionality is provided for accidental deletions.
*   **⚙️ Comprehensive Settings:**
    *   **🎨 Theme Customization:** Personalize the app's appearance with light, dark, and system theme modes, along with customizable accent colors (Grey, Red, Blue).
    *   **🔤 Font Options:** Select from a curated collection of 10 Google Fonts and adjust the font size (Default, Medium, Large) to optimize readability.
    *   **🌐 Localization:** The app supports both English and Arabic languages, with full localization and right-to-left (RTL) layout support.
    *   **ℹ️ About TaskMaster:** Provides information about the application, including a description and a list of open-source licenses for dependencies.

## 🏗️ Architecture

TaskMaster is built upon a layered architecture, adhering to SOLID principles and clean code practices for maintainability and scalability. BLoC (Business Logic Component) is employed for state management, ensuring consistent and predictable application behavior. A robust error handling mechanism, utilizing custom exceptions, provides informative error messages to the user through dedicated UI screens. Task data and user preferences are persistently stored using local storage.

## 🚀 Planned Features

This section outlines the features currently planned for future development.

*   **⏰ Reminders and Due Dates:** Set reminders for specific times or locations and assign due dates to tasks.
*   **🏷️ Task Categorization/Tagging:** Organize tasks using categories, tags, projects, or lists.
*   **🔄 Synchronization Across Devices:** Access and manage tasks seamlessly across multiple devices.
*   **🤝 Collaboration/Sharing:** Share lists or tasks with others, assign tasks, and collaborate on projects.
*   **⭐ Priority Levels:** Assign priority levels (e.g., high, medium, low) to tasks for better prioritization.
*   **🔁 Recurring Tasks:** Set tasks to repeat on a regular basis (daily, weekly, monthly, etc.).
*   **✨ Enhanced Task Overview Page:**
    *   **📅 Clear Visual Cues:** Display due dates, categories/tags, priority levels, and recurring task indicators prominently.
    *   **🎛️ Interactive Elements:** Implement filtering (by completion, category/tag, priority, due date) and sorting (by due date, priority, category/tag, alphabetically).
    *   **👆 Swipe Actions:** Maintain swipe-to-delete and consider adding swipe-to-edit or swipe-to-mark-as-complete.
    *   **✏️ Tap to Edit:** Make task items tappable to open the edit screen.
    *   **👁️‍🗨️ Visual Hierarchy:** Use clear spacing, concise information, and consider progress indicators.
    *   **📜 Empty State:** Display a friendly message and call to action when there are no tasks.

## 🛠️ Installation

1.  Ensure that the Flutter SDK is installed on your development machine. Refer to the official [Flutter installation guide](https://flutter.dev/docs/get-started/install) for detailed instructions.
2.  Clone the TaskMaster repository: `git clone https://github.com/fulleni/TaskMaster.git` (Replace with your actual repository URL)
3.  Navigate to the project directory: `cd TaskMaster`
4.  Install the required dependencies: `flutter pub get`

## 🏃 Running the Application

1.  Connect a physical device (Android or iOS) or launch a simulator.
2.  Execute the application: `flutter run`

For web deployment:

1.  Execute the application: `flutter run -d chrome` (or your preferred browser)

## 🙌 Contributing

We welcome contributions from the community! Please submit issues and pull requests through the repository. Detailed contribution guidelines are available in [CONTRIBUTING.md](CONTRIBUTING.md). (Create this file)

## 📜 Licensing

This project is licensed under the MIT License.

## 💬 Contact

For bug reports, feature requests, or general inquiries, please use the [issue tracker](https://github.com/fulleni/TaskMaster/issues).