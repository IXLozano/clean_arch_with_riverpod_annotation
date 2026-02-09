# Clean Architecture Example (Monorepo)

Flutter monorepo organized with Melos. The app currently uses Clean Architecture with GetIt + Bloc. Riverpod migration will be done later.

**Packages**
1. `packages/app` - Flutter app entrypoint, router, composition root.
2. `packages/core` - Shared core utilities (errors, base usecases, etc.).
3. `packages/feature_auth` - Auth feature (data, domain, presentation).

**Prerequisites**
1. Flutter SDK (via FVM or system install).
2. Dart SDK (comes with Flutter).

**Bootstrap**
```bash
dart pub get
melos bootstrap
```

**Run the app**
```bash
cd packages/app
flutter run
```

**Notes**
1. Root `pubspec.yaml` is tooling-only (Melos).
2. Each package has its own `pubspec.yaml`.
