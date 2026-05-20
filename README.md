# RentalHub

![Flutter](https://img.shields.io/badge/Framework-Flutter-blue) ![Dart](https://img.shields.io/badge/Language-Dart-0175C2) ![Get It](https://img.shields.io/badge/DI-get_it-6de) ![Bloc](https://img.shields.io/badge/State%20Management-bloc-4CAF50) ![License](https://img.shields.io/badge/License-TBD-lightgrey)

A production-oriented mobile app for equipment & item rentals. RentalHub provides a marketplace-style experience for listing, discovering, and renting items with first-class localization, secure token-based authentication, an AI-powered assistant for natural language queries, and a modular Clean Architecture codebase.

---

## Overview

- What it does: RentalHub connects renters and item owners. Users can browse categories and products, view product details, add favorites, manage profiles, create listings, and complete booking flows. A built-in AI assistant can answer natural language queries and suggest relevant items.
- Problem it solves: Reduces friction for finding and renting items by combining catalogue search, rich product pages, secure authentication, and an AI chat assistant that understands rental intent.
- Target users: Renters looking for short-term equipment/item rentals and owners listing items for rent.
- Business idea: Marketplace for local rentals with improved discovery (AI assistant), secure sessions (JWT tokens), and localized UX.

---

## Features

Core implemented features (extracted from codebase)

- Authentication
	- Email/password login and signup
	- OTP verification and password reset
	- Token storage using secure storage
	- Auth interceptor for automatic Authorization header
- Product Catalogue
	- Categories listing
	- Paginated product lists
	- Product details with images and metadata
- Favorites
	- Add / Remove favorite items
	- Favorites screen
- Listings
	- Add new listing flow (Add Listing screen scaffold present)
- Booking
	- Booking flow screen scaffold
- AI Chat Assistant
	- Natural language chat UI
	- Backend integration to AI endpoint (custom API)
	- Returns textual answer plus product suggestions and images
- Localization
	- Multi-language (ARB / Flutter gen-l10n)
	- Locale cubit for runtime locale switching
- Theming
	- Light / Dark theme support via ThemeCubit
- Profile & Settings
	- Edit profile and settings screens
- Community / Deals / Wallet
	- Feature screens scaffolded and reachable from navigation
- Utilities & UX
	- Reusable widgets (PrimaryButtonWidget, CustomTextField, spacing)
	- Responsive UI via flutter_screenutil
	- SVG, Lottie, Image caching, shimmer placeholders

User vs Admin features
- User features: Authentication, browsing, booking, AI chat assistant, favorites, profile, add listing, community.
- Admin features: No explicit admin dashboard code found in repo — administrative responsibilities appear to be handled server-side.

---

## Upcoming Features (Roadmap)

- Rich booking completion flow with payments integration
- Push notifications and real-time updates
- Improved listing creation with image upload + validation
- Role-based admin dashboard and content moderation
- Offline-first caching / smarter sync for slow networks
- Multi-tenant and multi-region scaling for APIs
- Enhanced AI assistant: context-aware sessions, follow-up handling, and analytics
- Unit & integration test coverage expansion and CI/CD pipelines
- More social sign-in providers (Facebook/Google flows currently stubbed)

---

## Architecture

- Pattern: Clean Architecture with a feature-based structure.
	- Layers per feature: presentation (Cubit/BLoC and UI), domain (entities & usecases), data (datasources & repository implementations).
- Dependency Injection: get_it configured in `lib/core/utils/service_locator.dart`.
- State Management: flutter_bloc (Cubit classes for features: `ThemeCubit`, `LocaleCubit`, `ProductCubit`, `AiChatCubit`, etc.).
- Routing: go_router configured in `lib/core/routing/router_generation_config.dart`.
- Networking: Dio wrapped by an ApiConsumer / DioConsumer abstraction and global AuthInterceptor for token attachment and logging.
- Local storage:
	- SharedPreferences for non-sensitive data
	- Flutter Secure Storage for tokens via `TokenStorageHelper`
- Error handling: Centralized Dio exception mapping to domain-friendly `ServerException`/`Failure` objects (`lib/core/errors/*`).
- Feature-based structure:
	- Each major feature folder follows the data → domain → presentation convention, making it straightforward to reason about responsibilities and to add new features.

Data flow (summary)
- UI (presentation/cubit) → UseCase (domain) → Repository (data) → Remote DataSource (ApiConsumer/Dio) → HTTP API.
- Responses handled by ResponseParser and transformed into Models → Entities for domain layer.

---

## Tech Stack & Key Packages

- Flutter & Dart (Dart SDK constraint from `pubspec.yaml`: sdk: ^3.11.1)
- State management: flutter_bloc (bloc / cubit)
- Dependency Injection: get_it
- Networking: dio (DioConsumer wrapper + pretty_dio_logger)
- Routing: go_router
- Local storage: shared_preferences, flutter_secure_storage
- Other useful packages:
	- cached_network_image, flutter_svg, flutter_screenutil, flutter_rating_stars
	- infinite_scroll_pagination, lottie, shimmer
	- dartz (Either for functional error handling)
	- pretty_dio_logger (debug logging)
	- image_picker (image uploads)
	- pin_code_fields (OTP UI)
	- animated_toggle_switch, flutter_staggered_animations

Representative table

| Concern | Package(s) |
|---|---|
| State | flutter_bloc, bloc |
| DI | get_it |
| HTTP | dio, pretty_dio_logger |
| Routing | go_router |
| Storage | shared_preferences, flutter_secure_storage |
| UI / UX | flutter_screenutil, cached_network_image, flutter_svg, lottie, shimmer |

---

## Project Structure

Primary folders (condensed)

lib/
 ├── core/                      # App-wide utilities, networking, di, routing, themes, errors
 ├── feature/                   # Feature-first folders (auth, home, ai_chat, favorites, ...)
 │   ├── ai_chat/
 │   │   ├── data/
 │   │   ├── domain/
 │   │   └── presentation/
 │   ├── auth/
 │   ├── home/
 │   ├── product_details/
 │   ├── favorites/
 │   └── ...                     # booking, add_listing, profile, community, deals, wallet
 ├── l10n/                      # Localization resources (ARB + generated)
 └── main.dart

Explanation (major folders)
- core: central services and cross-cutting concerns
	- core/databases/api: ApiConsumer, DioConsumer, EndPoints, AuthInterceptor
	- core/databases/cache: CacheHelper, TokenStorageHelper
	- core/utils: service locator, response parser, helpers
	- core/routing: go_router config
	- core/styling: theme and style definitions
	- core/errors: error modeling and handling
- feature/*: each feature contains:
	- data/: remote/local data sources, model-to-entity mapping, repositories
	- domain/: entities, repository interfaces, use cases
	- presentation/: cubits, states, UI screens and widgets
- l10n: localization ARB files and generated localizations

---

## Screenshots

(Placeholders — replace with real screenshots)
- Authentication Screens  
	![Auth: Login](docs/screenshots/auth_login.png)
- Home Screen  
	![Home](docs/screenshots/home.png)
- Product Details  
	![Product Details](docs/screenshots/product_details.png)
- Admin / Listings  
	![Add Listing](docs/screenshots/add_listing.png)
- AI Chat Assistant  
	![AI Chat](docs/screenshots/ai_chat.png)
- Profile & Settings  
	![Profile](docs/screenshots/profile.png)

---

## API Integration

- Primary API base: defined in `lib/core/databases/api/end_points.dart`
	- baseUrl: http://rentalplatform.runasp.net
	- AI endpoint: aiBaseUrl value points to a hosted AI API (currently an ngrok URL used in code).
- Client: Dio is wrapped by ApiConsumer → DioConsumer. All network calls should go through ApiConsumer to centralize timeouts and error handling.
- Interceptors:
	- AuthInterceptor attaches Bearer token from secure storage for protected endpoints.
	- Logging interceptor is enabled in non-release builds.
- Token handling:
	- Tokens are persisted with `TokenStorageHelper` using flutter_secure_storage.
	- `AuthInterceptor` validates tokens before attaching; malformed values are rejected and logged.
- Endpoints:
	- Auth: /api/Account/login, /api/Account/register, /api/auth/forgot-password, /api/auth/validate-otp
	- Categories: /api/Categories
	- Products: /api/Product
	- Favorites: /api/Favorite
	- AI chat: `${aiBaseUrl}/chat`
	- Request/Response mapping:
	- Responses are parsed by ResponseParser and mapped to Models (data layer) then to Entities (domain layer).
	- Errors from Dio are converted into ServerException subclasses and surfaced as Failure objects in repositories.

Error strategy
- Network layer maps Dio exceptions to domain-friendly ServerException
- Repositories wrap exceptions into Failure objects (dartz Either pattern) for upstream handling in use cases/cubits
- Presentation layer shows SnackBar messages and exposes error strings in state objects

---

## Getting Started

Prerequisites
- Flutter installed (use the channel & version consistent with your development environment)
- Dart SDK matching `pubspec.yaml` constraint: ^3.11.1
- Android/iOS tooling for device/emulator

Quick setup
1. Clone the repo
2. Install dependencies
	 ```bash
	 flutter pub get
	 ```
3. Generate localizations (if needed)
	 ```bash
	 flutter gen-l10n
	 ```
4. Run the app
	 ```bash
	 flutter run
	 ```
5. Build APK
	 ```bash
	 flutter build apk --release
	 ```
6. Build iOS (on macOS, with Xcode configured)
	 ```bash
	 flutter build ipa
	 ```

Notes
- The project uses code generation for localization — ensure `flutter gen-l10n` runs or use the included generated files under `build/` if present.
- If you encounter missing generated files, run `flutter pub get` and `flutter gen-l10n` before running.

---

## Environment & Configuration

- API endpoints are centralized under:
	- `lib/core/databases/api/end_points.dart`
- To change the API base URL:
	- Edit `EndPoints.baseUrl` and `EndPoints.aiBaseUrl`.
- Secrets & keys:
	- No client-side secrets are committed. If you need environment-specific secrets, prefer using secure CI variables or a platform-specific secure store.
- Localization:
	- Locale files live under `lib/l10n` and localization delegates are configured in `lib/main.dart`.

---

## Build & Release

Android
- Debug:
	```bash
	flutter run
	```
- Release APK:
	```bash
	flutter build apk --release
	```
- App bundle (AAB):
	```bash
	flutter build appbundle --release
	```

iOS
- Archive & export via Xcode or using:
	```bash
	flutter build ipa
	```
- Ensure code signing & provisioning profiles are configured in Xcode.

Common tips
- Use `flutter build apk --split-per-abi` to reduce APK size.
- Remove or replace dev-only endpoints (ngrok URLs) prior to production release.

---

## Best Practices Used

- Clean Architecture and feature-first modularization
- Single Responsibility and SOLID principles observed across layers
- Repository pattern with data → domain → presentation separation
- Dependency injection using get_it for testability and modular composition
- Centralized API client, error mapping, and token handling
- Responsive UI via flutter_screenutil and shared reusable widgets
- Localization using Flutter's gen-l10n pipeline

---

## Future Improvements & Notes

- Replace temporary dev AI endpoint with a stable production AI service or an enterprise LLM provider.
- Add end-to-end tests, widget tests, and expand unit coverage for use cases and cubits.
- Add CI/CD (GitHub Actions / Codemagic / Fastlane) for automated builds and test runs.
- Harden security: rotate secrets, implement refresh token flow and automatic token refresh, secure API keys in CI.
- Offline support and caching for product lists and favorites.
- Accessibility improvements, ARIA-like semantics for better screen reader support.
- Performance profiling and lazy-loading improvements for large product lists.

---

## Contributing

Guidelines
- Open issues for bugs or feature requests.
- Follow the existing folder and architecture patterns when adding features.
- Add unit tests for domain logic and widget tests for new UI components where applicable.
- Run formatter:
	```bash
	flutter format .
	```
- Keep commits scoped and descriptive; use conventional commits where possible.

Suggested workflow
1. Fork repository
2. Create a new branch: feature/your-feature or fix/issue-#
3. Implement and add tests
4. Open a pull request describing changes and testing steps

---

## License

- Current repository does not contain a LICENSE file.
- Recommended: add a license file (e.g., MIT) in the repository root to make licensing explicit.
- Until a license is added, treat the code as "All rights reserved" or contact repository owner for permission.

---

## Maintainers / Authors

- No explicit maintainer metadata found in the repository. Check repository hosting (GitHub/GitLab) for contributors and owners.
- For immediate code-ownership questions, search commit history or contact project owner.

---

## Key Files Reference

- Dependency manifest: [pubspec.yaml](pubspec.yaml#L1)  
- App entrypoint: [lib/main.dart](lib/main.dart#L1)  
- DI configuration: [lib/core/utils/service_locator.dart](lib/core/utils/service_locator.dart#L1)  
- API endpoints: [lib/core/databases/api/end_points.dart](lib/core/databases/api/end_points.dart#L1)  
- Networking wrapper: [lib/core/databases/api/dio_consumer.dart](lib/core/databases/api/dio_consumer.dart#L1)  
- Auth interceptor & token handling: [lib/core/databases/api/auth_interceptor.dart](lib/core/databases/api/auth_interceptor.dart#L1) • [lib/core/databases/cache/token_storage_helper.dart](lib/core/databases/cache/token_storage_helper.dart#L1)  
- AI chat feature: [lib/feature/ai_chat](lib/feature/ai_chat/presentation/screens/ai_chat_screen.dart#L1)

-