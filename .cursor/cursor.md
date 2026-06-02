# Rental Hub Copilot Instructions

These instructions apply to the whole repository and should be treated as the canonical project rules for GitHub Copilot and other AI agents.

## What This Codebase Is

* This is a Flutter app built around feature-based Clean Architecture.
* Shared cross-cutting code lives in `lib/core/`.
* App features live in `lib/feature/<feature_name>/` and usually split into `data/`, `domain/`, and `presentation/`.
* State management is Bloc/Cubit-based.
* Dependency injection is handled with GetIt in `lib/core/utils/service_locator.dart`.
* Networking is handled through Dio via a custom `ApiConsumer` abstraction.
* Routing is managed with GoRouter.
* Responsive UI uses Flutter ScreenUtil.
* Localization is ARB-based with generated AppLocalizations and `context.l10n`.

---

## AI Agent Rules

* Follow the existing project structure exactly before inventing anything new.
* Reuse existing widgets, utilities, models, and helpers before creating new ones.
* Do not introduce a new architecture pattern, state management library, or networking abstraction.
* Respect Clean Architecture boundaries between presentation, domain, and data.
* Inspect related files in the same feature before changing code.
* Match the surrounding naming, formatting, and error-handling style.
* Minimize unnecessary edits and avoid broad refactors when a local change is enough.
* Keep code production-ready, defensive, and compatible with the current app behavior.

---

## Before Writing Any Code

Always follow this workflow:

1. Read all related files first.
2. Understand the existing implementation.
3. Identify affected layers.
4. Explain the implementation plan before coding.
5. Reuse existing patterns.
6. Implement the change.
7. Verify dependency injection registrations.
8. Verify routing configuration.
9. Verify localization keys.
10. Verify no Clean Architecture boundaries were violated.

Never start coding immediately without understanding the existing feature.

---

## Architecture Rules

* Keep the current feature-first Clean Architecture layout.
* Presentation code must not depend directly on concrete data sources or Dio.
* Domain code must stay free of UI and framework concerns.
* Data code owns API calls, persistence, and model parsing.
* Use repositories as the boundary between domain and data.
* Keep use cases focused on one action or query.
* Do not move logic upward into widgets when it belongs in a Cubit, repository, or use case.

### Current Feature Shape

* `data/` contains datasources, models, and repository implementations.
* `domain/` contains entities, repository contracts, and use cases.
* `presentation/` contains cubits, screens, and reusable widgets.
* Some features are presentation-only or partial, but new code should still follow the nearest existing slice.

---

## Folder Structure Rules

* Add shared app-wide utilities to `lib/core/` only when they are truly reusable.
* Add feature-specific code under `lib/feature/<feature_name>/`.
* Keep files grouped by layer and responsibility.
* Keep generated localization files under `lib/l10n/` and do not hand-edit generated output.
* Use `lib/core/widgets/` for reusable UI components that apply across multiple features.
* Use `lib/core/styling/` for theme, colors, fonts, shadows, assets, and styles.
* Use `lib/core/databases/` for API and cache infrastructure.
* Use `lib/core/errors/` for exception and failure mapping.

---

## Clean Architecture Boundaries

* Presentation may call Cubits and read entities, but it should not call remote APIs directly.
* Cubits should coordinate user actions and domain use cases, not parse raw JSON.
* Use cases should depend on repository abstractions, not implementations.
* Repository implementations should convert exceptions into Failure values or domain entities.
* Datasources should talk to ApiConsumer or local storage helpers and return parsed data models.
* Models should map raw response data into strongly typed entities with defensive parsing.

---

## Bloc / Cubit Rules

* Use Cubit for feature state unless the existing feature already uses a different Bloc pattern.
* Keep Cubit methods small and action-oriented.
* Emit loading, success, and error states consistently with the surrounding feature.
* Prefer the existing state style used in the target feature instead of introducing a new pattern.
* Do not mix multiple state styles inside the same feature.
* Dispose controllers, listeners, subscriptions, and paging resources in `close()`.
* Keep optimistic UI updates and rollback logic inside the Cubit.
* Avoid putting business logic inside widgets.

---

## Repository Pattern Rules

* Repository interfaces belong in `domain/`.
* Repository implementations belong in `data/repositories/` or the existing feature structure.
* Return `Either<Failure, T>` for domain-facing operations.
* Translate ServerException and data layer exceptions into Failure objects.
* Preserve the existing repository naming style inside the feature.
* Do not introduce another repository naming convention.

---

## DTO, Entity, and Model Rules

* Entities live in `domain/entities/`.
* Models live in `data/models/`.
* DTOs and request objects stay in the data layer.
* Do not expose Models directly to presentation.
* Do not expose DTOs to presentation.
* Use defensive parsing for all external data.
* Safely parse strings, numbers, booleans, enums, and dates.
* Handle missing and nullable fields gracefully.
* Prefer nullable types (e.g., `String?`) for missing/optional fields to leverage Dart's null-safety and force explicit handling in callers. Avoid silently substituting hardcoded fallback literals (e.g., `""`, `0`) unless the domain specification explicitly requires that fallback.
* Keep parsing helpers close to the model when appropriate.

---

## API Integration Rules

* Use ApiConsumer for all HTTP calls.
* Use DioConsumer as the concrete implementation.
* Use EndPoints constants instead of raw API strings.
* Use ResponseParser when the backend wraps payloads.
* Handle malformed responses safely.
* Validate response structure before parsing.
* Support nullable fields.
* Handle empty arrays and empty objects.
* Handle non-JSON responses safely.
* Never trust backend response types.
* Use multipart/form-data only when required.
* Do not bypass authentication interceptors unless necessary.
* Keep AI service requests on their dedicated API client when applicable.

---

## Dependency Injection Rules

* Register dependencies in `lib/core/utils/service_locator.dart`.
* Register in this order:

  1. Core Services
  2. Datasources
  3. Repositories
  4. Use Cases
  5. Cubits
* Use `registerLazySingleton()` for shared dependencies.
* Use `registerFactory()` for Cubits and screen-scoped objects.
* Reuse existing GetIt patterns.
* Do not introduce another dependency injection framework.

---

## UI Layer Rules

* Keep screens inside `presentation/screens/`.
* Keep reusable widgets inside `presentation/widgets/`.
* Reuse widgets from `lib/core/widgets/` before creating new ones.
* Use ScreenUtil sizing helpers (`.w`, `.h`, `.sp`).
* Use AppColors, AppStyles, AppFonts, and AppAssets.
* Use localization through `context.l10n`.
* Do not hardcode user-facing strings.
* Move business logic out of widgets.
* Keep widgets focused on rendering and user interaction.

---

## Flutter Community Best Practices

* Prefer composition over inheritance.
* Avoid unnecessary widget rebuilds.
* Extract reusable widgets when duplication appears.
* Use const constructors whenever possible.
* Keep widget trees shallow and readable.
* Avoid business logic inside widgets.
* Avoid BuildContext usage after async gaps.
* Use mounted checks when required.
* Prefer immutable states and objects.
* Avoid large God widgets.
* Prefer small focused widgets.

---

## Naming Conventions

* Use snake_case for file names.
* Use PascalCase for classes and widgets.
* Use the `Screen` suffix for screens.
* Use the `Widget` suffix when appropriate.
* Use the `Cubit` suffix for Cubits.
* Use action-oriented names for UseCases.
* Use existing route naming conventions.
* Keep feature folder names consistent.
* Follow local naming conventions when they already exist.
* When creating new implementation classes inside a feature (datasources, repositories, etc.), follow the feature-local implementation suffix already in use in that folder. Do not introduce a different suffix that widens an existing inconsistency.

---

## Code Style Conventions

* Keep null safety strict.
* Prefer non-nullable types whenever possible.
* Use const constructors where possible.
* Keep classes focused on a single clear responsibility and generally under 300 lines of code; extract complex logic into helpers or use cases.
* Prefer explicit types when readability improves.
* Use Equatable where the surrounding feature already uses it.
* Preserve existing import style.
* Avoid unnecessary comments.
* Avoid unrelated formatting changes.
* Avoid unrelated refactors.

---

## Error Handling Conventions

* Map remote failures to Failure objects.
* Handle Dio exceptions through the existing error layer.
* Use friendly user-facing error messages.
* Preserve existing network fallback behavior.
* Do not silently swallow errors.
* Validate backend responses before usage.
* Separate transport failures from business failures whenever possible.
* Map native platform and plugin errors (e.g., `PlatformException`) via a platform-specific exception handler in `lib/core/errors/`, and wrap them into `Failure` objects consumed by repositories and use cases.

---

## Feature Creation Workflow

Always follow this order:

1. Analyze the feature.
2. Review similar existing features.
3. Create or update Entities.
4. Create Repository Contracts.
5. Create Models.
6. Create Datasources.
7. Create Repository Implementations.
8. Create Use Cases.
9. Create Cubits and States.
10. Create UI Screens and Widgets.
11. Register dependencies.
12. Register routes.
13. Add localization keys.
14. Verify architecture boundaries.
15. Add tests if needed.

If a feature introduces a brand new technical requirement or paradigm with no local precedent (for example: WebSockets, background services, native Platform Channels, or other platform-specific integrations), follow these rules before coding:

- Default to global Clean Architecture rules (UI → Cubit → UseCase → Repository → Datasource → ApiConsumer) for the proposed solution.
- Outline the proposed folder structure, dependencies, and DI registration in a short design note and get reviewer sign-off before generating code.


---

## Code Review Checklist

Before considering a task complete verify:

* Clean Architecture is respected.
* Existing patterns were reused.
* Existing widgets were reused.
* Existing helpers were reused.
* Dependency injection is registered.
* Routes are registered.
* Localization keys are added.
* Loading states exist.
* Error states exist.
* Success states exist.
* Empty states exist.
* Memory leaks are avoided.
* No unnecessary rebuilds exist.
* API parsing is defensive.
* Null safety is respected.

---

## Refactoring Rules

* Keep refactors local and incremental.
* Do not rename large portions of the codebase unnecessarily.
* Do not introduce a new architecture style.
* Preserve behavior during refactors.
* Update tests when behavior changes.
* Prefer extracting small helpers.
* Avoid framework-wide cleanup when solving a local problem.

---

## Testing Rules

* Run flutter analyze whenever possible.
* Run flutter test for logic changes.
* Add unit tests for repositories, use cases, Cubits, and parsers.
* Add widget tests for important UI interactions.
* Use mocks and fakes instead of real network calls.
* Keep tests focused on changed behavior.
* Do not introduce flaky tests.

---

## Forbidden Actions

Do NOT:

* Introduce MVVM, MVC, Riverpod, Provider, GetX, MobX, Redux, or another architecture/state pattern.
* Create duplicate widgets.
* Create duplicate repositories.
* Create duplicate use cases.
* Create duplicate helpers.
* Hardcode API URLs.
* Hardcode localized strings.
* Bypass ApiConsumer.
* Bypass dependency injection.
* Modify unrelated files.
* Refactor unrelated features.
* Replace existing patterns without a strong reason.

---

## Final Task Completion Checklist

Before finishing any task:

* Verify code compiles.
* Verify architecture boundaries are respected.
* Verify dependency injection registrations.
* Verify routing configuration.
* Verify localization.
* Verify state handling.
* Verify error handling.
* Verify loading states.
* Verify null safety.
* Verify no unnecessary code was introduced.
* Verify no duplicated code was introduced.
* Verify the implementation follows existing project conventions.

If a rule conflicts with a verified existing implementation inside the same feature, preserve the local pattern for edits to existing files and keep changes minimal.

Cascade of precedence:

- Apply global rules unconditionally for entirely new files, new entities, or when introducing a new feature-level artifact.
- For edits to existing files, preserve local patterns and conventions to avoid widening inconsistencies; prefer minimal, focused changes.

---

## API Source of Truth (IMPORTANT)

- The file `docs/api/api_collection.json` is the SINGLE SOURCE OF TRUTH for all API endpoints.
- All API-related implementation MUST be derived from this file.
- No endpoint should be guessed or hardcoded.

Strict rules:

- Always read `docs/api/api_collection.json` before implementing any API feature.
- Do not use endpoints that are not defined in the JSON file.
- Do not hardcode URLs anywhere in the project.
- All request and response structures must come from the JSON file.
- API integration must follow Clean Architecture layers strictly (UI → Cubit → UseCase → Repository → Datasource → ApiConsumer).

Mandatory workflow before any API implementation:

1. Read `docs/api/api_collection.json`
2. Find the required endpoint in the file
3. Extract request and response schema from the endpoint definition
4. Map the schema to the app layers:
  - DTO / data model (in `data/models/`)
  - Repository method (in `domain/` contract and `data/` implementation)
  - UseCase (in `domain/usecases/`)
  - Cubit (in `presentation/cubit/`)
5. Then implement the feature following the normal feature workflow.

IMPORTANT RULES (must follow):

- Do not remove existing instructions.
- Do not break existing Copilot rules.
- Only extend this file; preserve all current sections and formatting.
- Keep formatting consistent with the current file and repository conventions.


## UI from Design Rules (Screenshot to Code)

When a user provides a UI screenshot or design image:

### Responsibilities:
- Analyze the design carefully (layout, spacing, colors, components)
- Recreate the UI in Flutter as closely as possible
- Use existing project widgets from `lib/core/widgets/` before creating new ones
- Follow the current design system (`AppColors`, `AppStyles`, `ScreenUtil`)
- Ensure responsiveness for all screen sizes

### Architecture Rules:
- UI must be placed inside `presentation/screens` or `presentation/widgets`
- No business logic inside UI
- UI must only communicate with Cubits

### Refactor Rules:
- If existing widgets can replace duplicated UI → reuse them
- Extract reusable components into `core/widgets` only if used in multiple places
- Keep widgets small and single responsibility

### Important:
- Do NOT invent a new design system
- Do NOT ignore existing UI patterns in the project
- Do NOT hardcode colors or spacing values
- Always match existing app style
After generating UI:
- Perform automatic refactor pass
- Remove duplication
- Split large widgets
- Extract reusable components