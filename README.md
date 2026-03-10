# Surokkha App

Flutter application using **clean architecture** and **GetX** for state management and routing.

## Project structure

```
lib/
├── main.dart
├── app/                    # App configuration
│   ├── bindings/           # Dependency injection (initial + per-route)
│   ├── routes/              # AppRoutes, AppPages (GetX)
│   └── theme/               # Colors, text styles, theme
├── core/                    # Shared utilities and services
│   ├── constants/
│   ├── controllers/         # GlobalController
│   ├── localization/
│   ├── services/
│   ├── utils/
│   └── widgets/             # Reusable UI components
├── data/                    # Data layer
│   ├── models/
│   └── repositories/
├── helpers/
└── presentation/            # Feature-based UI
    ├── main/
    ├── splash/
    ├── auth/
    ├── home/
    ├── feature_a/
    ├── feature_b/
    └── settings/
```

## Getting started

1. Install dependencies: `flutter pub get`
2. Run: `flutter run`

## Architecture

- **app**: Bindings, routes, theme (no business logic).
- **core**: Constants, global controller, localization, services, utils, shared widgets.
- **data**: Models and repositories (data sources).
- **presentation**: One folder per feature with `controllers/` and `views/` (and optional `models/`).

Business logic is implemented in controllers and repositories; this scaffold provides placeholders only.
