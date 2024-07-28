# Dynamic News App

A news app in flutter using firebase and provider.

## Features

- **Firebase Authentication**: Email-only authentication.
- **Collect User Details**: Collecting user details (name, email) and storing them in Firestore under the `user` collection.
- **News Feed**: Displaying top headlines from a country using [newsapi.org](https://newsapi.org/).
- **Dynamic Country Change**: Change the country code dynamically, stored in Firebase Remote Config.
- **State Management**: Utilizing [Provider](https://pub.dev/packages/provider) for state management.
- **Clean Code Architecture**: Implementing a clean code architecture for maintainability and scalability.

## Getting Started

To run the app, follow these steps:

1. **Clone the project**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
2. **Connect with Firebase**:

    Set up a Firebase project.
    Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) to the respective directories.

3. Add .env file:

    Create a .env file in the project root with the following content:
    ```bash
    NEWS_API_KEY=<your-api-key>
4. Run the app:
    ```bash
    flutter run
