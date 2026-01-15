# Hoppr Frontend

A production-ready Flutter frontend for the Hoppr ticket SaaS platform.

## Features

- **Material 3 Expressive Design**: Modern, expressive UI with rich animations and motion
- **Light & Dark Mode**: Full theme support with predefined tokens and optional Material You dynamic colors
- **Cross-Platform**: Mobile-first, responsive design for phones, tablets, and web
- **State Management**: Riverpod for reactive, testable state management
- **Offline-First**: SQLite caching for tickets, wishlist, and chat
- **Authentication**: Keycloak OIDC integration with feature gating
- **Deep Linking**: Support for sharing tickets and deep navigation

## Architecture

The app follows clean architecture principles:

```
lib/
├── core/           # Theme, routing, constants, utilities
├── features/        # Feature modules (auth, tickets, chat, etc.)
├── data/           # API client, cache, repositories
└── shared/         # Reusable widgets and animations
```

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Generate code (for freezed, drift, retrofit):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Run the app:
```bash
flutter run
```

## Configuration

### API Configuration

Set the API base URL via environment variable or build configuration:

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080/api/v1
```

Or modify `lib/core/constants/api_constants.dart` directly.

### Keycloak Configuration

Update Keycloak settings in `lib/features/auth/data/auth_service.dart`:

- `_clientId`: Your Keycloak client ID
- `_redirectUrl`: Your app's redirect URL
- `_issuer`: Keycloak realm URL

## Features

### Navigation

- **Home Tab**: Search bar and recent tickets
- **Search Tab**: Filterable ticket list with infinite scroll
- **Wishlist Tab**: Saved tickets (requires authentication)
- **Chat Tab**: Conversations and messaging (requires authentication)
- **Profile Tab**: User profile, settings, and own tickets

### Authentication

- Optional authentication for browsing
- Login modal triggered for protected actions
- JWT token management with automatic refresh
- Secure token storage

### Caching

- SQLite database for offline support
- Optimistic updates
- Cache invalidation strategies

## Development

### Code Generation

Run code generation after modifying:
- Freezed models (`*.freezed.dart`)
- Drift database (`*.drift.dart`)
- Retrofit API service (`*.g.dart`)

```bash
flutter pub run build_runner watch
```

### Linting

```bash
flutter analyze
```

### Testing

```bash
flutter test
```

## Project Structure

- **Features**: Organized by domain (tickets, auth, chat, etc.)
- **Data Layer**: API client, cache, repositories
- **Presentation**: Screens, widgets, state management
- **Shared**: Reusable components and utilities

## Dependencies

Key dependencies:
- `flutter_riverpod`: State management
- `go_router`: Navigation and deep linking
- `dio`: HTTP client
- `drift`: SQLite database
- `flutter_animate`: Animation utilities
- `flutter_appauth`: OIDC authentication

## License

GPL-3.0
