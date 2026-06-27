# RentalHub — Agent Instructions

Flutter Clean Architecture rental marketplace app. State: Bloc/Cubit. DI: GetIt. Routing: GoRouter. Networking: Dio.

## Sources of Truth

- `.github/copilot-instructions.md` (or `.cursor/cursor.md` — identical copy) — comprehensive architecture, pattern, and workflow rules. **Read first before any code change.**
- `docs/api/api_collection.json` — single source of truth for all API endpoints. Read before implementing any API feature.
- `lib/core/databases/api/end_points.dart` — Dart endpoint constants derived from `api_collection.json`. Both must stay in sync.

## Commands

| Action | Command |
|---|---|
| Dependencies | `flutter pub get` |
| Localization codegen | `flutter gen-l10n` |
| Lint + analyze | `flutter analyze` |
| Format | `flutter format .` |
| All tests | `flutter test` |
| Run app | `flutter run` |
| Build Android | `flutter build apk --release` or `flutter build appbundle --release` |
| Build iOS | `flutter build ipa` |
| Auto-watch l10n | `watch-l10n.bat` (Windows only, polls ARB changes) |

Run order before committing: `flutter analyze && flutter format . && flutter test`.

## Architecture Facts

- Design size for `flutter_screenutil`: **402 × 889** with `minTextAdapt: true` (`lib/main.dart:49-50`).
- DI registry at `lib/core/utils/service_locator.dart`. **Two Dio instances**: default (`ApiConsumer`) and a named `'ai'` instance with 120s timeout & separate base URL (`getIt<ApiConsumer>(instanceName: 'ai')`). All feature dependencies registered here.
- OTP Cubit uses `registerFactoryParam` (`lib/core/utils/service_locator.dart:603`). Pass email as first param: `getIt<OtpCubit>(param1: email)`.
- GoRouter config at `lib/core/routing/router_generation_config.dart`. Cubits are created from GetIt (not default constructors) inside route builders.
- Localization ARBs at `lib/l10n/app_{en,ar}.arb`, generated to `lib/l10n/generated/`. Use `context.l10n` in widgets. Locale persistence via `LocaleCubit` + SharedPreferences.
- Chat real-time uses **SignalR** (`signalr_netcore` package) via `ChatSignalRDataSource` (`lib/feature/chat/data/datasources/chat_signalr_data_source.dart`).
- AI endpoint is a **development ngrok URL** (`end_points.dart:3-4`) — must be replaced before production.

## Testing

- Very few tests exist. No CI/CD pipeline configured.
- `test_hub.dart`, `test_signalr*.dart`, `test_signalr*.js` are **standalone debug scripts**, not `flutter test` suites.

## Repo-Specific Conventions

- Feature directories follow `lib/feature/<name>/{data,domain,presentation}/` but some features are incomplete (presentation-only).
- Repository implementation suffixes are **inconsistent** across features (e.g. `*Impl`, `*Imp`, `*RepositoryImpl`). When editing existing code, preserve the local convention. For new files, use `*Impl`.
- Auth feature is split by sub-domain (login, forgot_password, validate_otp) each with its own datasource + repo slice — follow this pattern for auth, not a single monolithic approach.
- `AnalysisOptions.yaml` uses only `package:flutter_lints/flutter.yaml` with no custom rules.

## Widget Extraction Convention

Presentation layer splits into `screens/` and `widgets/`. Extract reusable or sizable UI blocks into feature-local widget files rather than inlining them in the screen file. This is widely followed (15 of 20 features; 85 extracted widget files vs 35 screen files).

Preferred structure:
```
lib/feature/<name>/presentation/
├── screens/
├── widgets/
└── cubit/
```

**When to extract** — any private widget class defined inside a screen file that is non-trivial (roughly >40 lines, or used conceptually as a distinct UI block) should be extracted to `widgets/`. Exceptions: trivial wrappers, single-line layout helpers, and the State class itself.

**Screen size guideline** — prefer screens under ~300 lines. Existing screens exceeding this (e.g. `add_listing_screen.dart` at 941 lines, `community_screen.dart` at 712) are outliers and should be refactored when touched.

## Existing Instruction Files

Do not duplicate or override `.github/copilot-instructions.md`. That file contains thorough architecture, workflow, and code review rules. This file only adds what it misses.

## Implementation Policy

When implementing a backend feature:
- Search for all related endpoints before starting.
- Fully integrate the feature across Data, Domain, Presentation, DI, Routing, and UI.
- Do not leave partially implemented endpoints.
- If existing UI is not connected to the backend, complete the integration.
- Preserve the project's architecture and naming conventions.