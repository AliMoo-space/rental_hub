# Project Architecture — Rental Hub

This document describes the actual architecture, conventions, and major features of the Rental Hub Flutter project as implemented in the repository.

> Generated from a code inspection of the repository file layout and core implementations (lib/, core/, and feature/ slices).

---

## A) Project Overview

- Simple summary: Rental Hub is a marketplace/mobile app for listing, browsing, booking, reviewing and managing rentals.
- Main purpose: provide users the ability to browse rental products, manage listings, communicate (AI-assisted chat), handle bookings and payments, and manage their profile and preferences.

---

## B) Tech Stack

- Flutter: standard Flutter project (null-safety, current SDK constraints via `pubspec.yaml`).
- State management: `flutter_bloc` (Cubit) — features use `Cubit` classes for state logic (e.g., `ProductCubit`, `AiChatCubit`, `WalletCubit`).
- Networking: `dio` with a project-specific abstraction `ApiConsumer` and a concrete implementation `DioConsumer` (see `lib/core/databases/api/api_consumer.dart` and `lib/core/databases/api/dio_consumer.dart`).
- Dependency injection: `get_it` with a single service locator in `lib/core/utils/service_locator.dart`.
- Routing: `go_router` with route constants in `lib/core/routing/app_routes.dart` and router setup in `lib/core/routing/router_generation_config.dart`.
- Localization: ARB-based generated `AppLocalizations` (see `lib/l10n/`) and `context.l10n` helper (see `lib/core/extensions/localization_extension.dart`).
- UI scaling / responsive: `flutter_screenutil` (design size: 402×889; usage of `.w`, `.h`, `.sp`).

---

## C) Core Architecture

This project follows a feature-based Clean Architecture layout. The canonical flow is:

UI (screens/widgets) → Cubit (presentation) → UseCase (domain) → Repository (domain impl) → Datasource (data layer) → ApiConsumer (network) → Remote API

Key responsibilities:
- Presentation: `lib/feature/<feature>/presentation/` — Cubits, Screens, Widgets.
- Domain: `lib/feature/<feature>/domain/` — Entities, repository contracts (interfaces), and use cases.
- Data: `lib/feature/<feature>/data/` — Datasources, models, and repository implementations.

Shared core utilities live under `lib/core/` (routing, styling, errors, api, cache, widgets, utils).

---

## D) Features List (extracted from repository)

The repository contains the following feature folders (real existing folders under `lib/feature/`):

- `auth` — login, signup, OTP, forgot/reset flows
- `ai_chat` — AI-backed chat feature (dedicated AI API client)
- `add_listing` — add listing screens and logic
- `booking` — booking flows and screens
- `community` — community requests/offers (endpoints present)
- `deals` — deals screens
- `favorites` — favorites management
- `home` — categories and products listing
- `intro` — intro / onboarding screens
- `localization` — locale persistence and cubit
- `main` — main app shell / navigation
- `messages` — messaging screens (exists as folder)
- `product_details` — product detail screen and related widgets
- `product_reviews` — product reviews CRUD and ratings
- `profile` — user profile screens and upload/change-password
- `search` — product search and AI search slices
- `splash` — splash screen
- `subscription` — subscription plans and purchase flows
- `theme` — theme cubit and toggling
- `wallet` — wallet, deposit, withdraw requests and transactions

(Each of the above follows the feature/data/domain/presentation splitting pattern where applicable.)

---

## E) Feature Relationships

- `auth` is foundational — `TokenStorageHelper`, `AuthInterceptor`, and login tokens are referenced across features (profile, wallet, favorites, protected endpoints).
- `home` provides products and categories consumed by `product_details`, `product_reviews`, `favorites`, and `search`.
- `product_details` links to `product_reviews` for displaying and loading reviews.
- `ai_chat` uses a dedicated ApiConsumer instance configured with `EndPoints.aiBaseUrl` and is registered separately in `service_locator` (instanceName: 'ai').
- `profile` (user data) is used by `main`, `intro`, `home` widgets (avatar display, drawer), and edit flows.
- `wallet` is used by payment/checkout flows and subscription purchase actions.
- `favorites` interacts with `home` products to toggle favorites; these operations use repository/usecase patterns.

Note: Relationships are based on observed imports and service registrations; there is no global event bus — interactions are explicit via use cases and repositories.

---

## F) Data Flow Examples

Below are concrete flows observed in code (files referenced):

### 1) Create Product Review

Files: `lib/feature/product_reviews/presentation/cubit/product_review_cubit.dart`, `lib/feature/product_reviews/domain/usecases/create_product_review_usecase.dart`, `lib/feature/product_reviews/data/datasources/product_review_remote_data_source.dart`

Flow:
1. User action in a `product_reviews` screen triggers `ProductReviewCubit.createReview(...)`.
2. Cubit calls `CreateProductReviewUseCase`.
3. Use case calls `ProductReviewRepository` implementation.
4. Repository calls `ProductReviewRemoteDataSourceImpl.createProductReview()`.
5. Remote datasource uses `apiConsumer.post(...)` with `EndPoints.productReviewsEndpoint`.
6. Response is parsed via `ResponseParser.extractDataPayload(...)` and mapped to model/entity.
7. Cubit receives success/failure and emits new state accordingly.

### 2) AI Chat Flow

Files: `lib/feature/ai_chat/presentation/cubit/ai_chat_cubit.dart`, `lib/feature/ai_chat/domain/usecases/send_message_use_case.dart`, `lib/feature/ai_chat/data/datasource/ai_remote_data_source.dart`

Flow:
1. User sends a message from `AiChatScreen` which invokes `AiChatCubit.sendMessage(...)`.
2. Cubit calls `SendMessageUseCase`.
3. Use case calls `AiChatRepo` implementation.
4. Repo calls `AiRemoteDataSourceImpl.sendMessage(...)` which uses `apiConsumer.post(...)` to `EndPoints.aiBaseUrl + EndPoints.aichatEndpoint`.
5. Response payload is parsed with `ResponseParser.extractDataPayload(...)` and converted to `AiChatModel`.
6. Cubit updates state to include the assistant response.

### 3) Add Listing / Create Listing (Add Listing Flow)

Files: `lib/feature/add_listing/presentation/cubit/add_listing_cubit.dart`, `lib/feature/add_listing/domain/usecases/add_listing_use_case.dart`, `lib/feature/add_listing/data/datasource/add_listing_remote_data_source.dart`

Flow:
1. User fills listing form and submits from `AddListingScreen`.
2. `AddListingCubit` orchestrates validation and calls `AddListingUseCase`.
3. Use case calls the `AddListingRepo` which delegates to `AddListingRemoteDataSource`.
4. Datasource uses `apiConsumer.post(..., isFormData: true)` for images/multipart data.
5. API response is parsed and returned; cubit emits success or error states.

---

## G) Architectural Decisions (observed)

- State management: The codebase standardizes on `Cubit` for presentation logic. It favors explicit state classes (some features use sealed-state classes, others use single immutable data states with `copyWith`). The current rules prefer following the nearest existing pattern in the feature.

- Networking constraints: A single `ApiConsumer` abstraction is used across the app to centralize error handling and options. `DioConsumer` wraps Dio and standardizes base settings, header defaults, timeouts, pretty logging, and maps Dio exceptions to the internal `ServerException` hierarchy.

- Repository pattern: Repositories return `Either<Failure, T>` (from `dartz`) — this is ubiquitous across features. Repositories translate `ServerException` into `Failure` objects consumed by use cases and cubits.

- Error handling: The project centralizes HTTP/transport error mapping in `lib/core/errors/error_handling.dart`. There is also an `AuthInterceptor` to attach tokens from `TokenStorageHelper`.

- AI endpoints: A dedicated `ApiConsumer` instance (named instance `ai`) is registered for AI-specific base URL usage.

---

## H) Important Project Rules (enforced by repo and recommended for contributors / AI agents)

- No direct API calls from UI: UI should only call Cubit methods.
- No business logic in UI: Business rules live in use cases / repositories / cubits.
- Use Cubit for state management (match existing feature pattern when editing existing code).
- Reuse existing components (widgets, styles, helpers) in `lib/core/` before creating new ones.
- Follow the feature structure strictly: `data/`, `domain/`, `presentation/` within each feature.
- Register new dependencies in `lib/core/utils/service_locator.dart` (bottom-up: core → datasources → repos → use cases → cubits).
- Use `EndPoints` constants for API paths and `ResponseParser` for envelope parsing.
- For AI or alternate base URLs, register named `ApiConsumer` instances rather than modifying global base config.

---

## I) Locations of key files (examples)

- `lib/core/utils/service_locator.dart` — DI registrations
- `lib/core/databases/api/api_consumer.dart` — ApiConsumer abstraction
- `lib/core/databases/api/dio_consumer.dart` — Dio implementation
- `lib/core/databases/api/end_points.dart` — API endpoints/constants
- `lib/core/errors/error_handling.dart` — error mapping and exceptions
- `lib/core/extensions/localization_extension.dart` — `context.l10n` helper
- `lib/core/widgets/` — shared UI components
- Feature examples: `lib/feature/home/`, `lib/feature/auth/`, `lib/feature/ai_chat/`, `lib/feature/product_reviews/`, `lib/feature/wallet/` etc.

---

## J) Notes and Observed Inconsistencies

- Naming: Some older code uses `Imp` vs `Impl` suffixes for implementations; when editing existing features preserve the local suffix.
- State style: Mix of sealed-state classes, abstract-state classes, and `copyWith`-style data states. Match nearest feature style when adding or changing code.
- Parsing: Models use defensive parsing rather than code-generation. Consider keeping that approach unless the feature already uses generated models.
- Tests: There are a few unit/widget tests under `test/` but coverage is limited; new behavior should include focused tests.

---

## K) Where this file was created

The file was created at: `docs/project_architecture.md` (repository root `docs/` directory).

---

## Summary of detected project structure

- Feature-based Clean Architecture with `data/`, `domain/`, `presentation/` splits.
- GetIt service locator for DI (`lib/core/utils/service_locator.dart`).
- `ApiConsumer` abstraction with `DioConsumer` implementation (`lib/core/databases/api/`).
- Cubit-based state management (`flutter_bloc`).
- GoRouter-based routing with `AppRoutes` and `RouterGenerationConfig`.
- ARB localization and `context.l10n` helper.
- Responsive UI via `flutter_screenutil`.

If you want, I can now:
- Add cross-reference links from specific feature READMEs to this `docs/project_architecture.md` file.
- Create a short checklist that CI or PR templates can run to ensure new code follows these rules.

---

(End of document)
