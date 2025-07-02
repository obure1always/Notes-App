# Notes App

A Flutter notes application with Firebase authentication and Firestore database integration.

## Features

- **Authentication**: Email/password signup and login with Firebase Auth
- **CRUD Operations**: Create, read, update, and delete notes
- **Real-time Sync**: Notes are synchronized with Firestore in real-time
- **Clean Architecture**: Follows clean architecture principles with separation of concerns
- **State Management**: Uses BLoC pattern for state management
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Responsive UI**: Material Design with responsive layout

## Architecture

The app follows Clean Architecture principles with the following layers:

### Domain Layer
- **Entities**: Core business objects (Note)
- **Repositories**: Abstract interfaces for data operations
- **Use Cases**: Business logic implementation

### Data Layer
- **Models**: Data transfer objects
- **Data Sources**: Firebase Auth and Firestore implementations
- **Repository Implementations**: Concrete implementations of domain repositories

### Presentation Layer
- **BLoC**: State management using flutter_bloc
- **Pages**: UI screens
- **Widgets**: Reusable UI components

## Project Structure

\`\`\`
lib/
├── core/
│   └── di/                 # Dependency injection
├── data/
│   ├── datasources/        # Remote data sources
│   ├── models/            # Data models
│   └── repositories/      # Repository implementations
├── domain/
│   ├── entities/          # Business entities
│   ├── repositories/      # Repository interfaces
│   └── usecases/         # Business logic
└── presentation/
    ├── bloc/             # BLoC state management
    ├── pages/            # UI screens
    └── widgets/          # Reusable widgets
\`\`\`

## Setup Instructions

### Prerequisites
- Flutter SDK (>=3.0.0)
- Firebase project with Authentication and Firestore enabled
- Android Studio or VS Code with Flutter extensions

### Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)

2. Enable Authentication:
   - Go to Authentication > Sign-in method
   - Enable Email/Password provider

3. Enable Firestore:
   - Go to Firestore Database
   - Create database in test mode

4. Add your app to Firebase:
   - For Android: Download `google-services.json` and place in `android/app/`
   - For iOS: Download `GoogleService-Info.plist` and place in `ios/Runner/`

5. Install Firebase CLI and FlutterFire CLI:
   \`\`\`bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   \`\`\`

6. Configure Firebase for your Flutter app:
   \`\`\`bash
   flutterfire configure
   \`\`\`

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd notes_app
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   flutter pub get
   \`\`\`

3. Run the app:
   \`\`\`bash
   flutter run
   \`\`\`

## Usage

### Authentication
- **Sign Up**: Create a new account with email and password
- **Login**: Sign in with existing credentials
- **Logout**: Sign out from the app

### Notes Management
- **Add Note**: Tap the ➕ button to create a new note
- **View Notes**: All notes are displayed in a scrollable list
- **Edit Note**: Tap the edit icon on any note to modify it
- **Delete Note**: Tap the delete icon and confirm to remove a note

## State Management

The app uses BLoC pattern for state management:

- **AuthBloc**: Handles authentication state (login, signup, logout)
- **NotesBloc**: Manages notes state (CRUD operations)

## Error Handling

- Form validation for email and password
- Firebase error handling with user-friendly messages
- Network error handling
- Success/error feedback via SnackBars

## Testing

Run tests with:
\`\`\`bash
flutter test
\`\`\`

## Dart Analyzer

Check code quality with:
\`\`\`bash
flutter analyze
\`\`\`

## Building for Release

### Android
\`\`\`bash
flutter build apk --release
\`\`\`

### iOS
\`\`\`bash
flutter build ios --release
\`\`\`

## Dependencies

- `firebase_core`: Firebase core functionality
- `firebase_auth`: Firebase authentication
- `cloud_firestore`: Firestore database
- `flutter_bloc`: State management
- `equatable`: Value equality
- `uuid`: Unique identifier generation
- `get_it`: Dependency injection

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and analyzer
5. Submit a pull request

## License

This project is licensed under the MIT License.
