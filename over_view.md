# RentalHub Project Overview

## What is this project?
RentalHub is a Flutter marketplace app for renting items and equipment. The main idea is to connect item owners with renters through a single experience that includes sign up and login, product browsing, search, favorites, reviews, listing creation, wallet features, subscriptions, profile management, and an AI assistant that helps users find the right items.

The project is built to scale and follows a clear layered structure, with full support for localization, theme switching, and state management through BLoC/Cubit.

## High-Level Picture
- The app is designed for end users who want to rent or list items for rent.
- The UI is built in Flutter with responsive behavior using ScreenUtil.
- State is managed with flutter_bloc.
- Navigation is handled with go_router.
- Data access is done through Dio with a unified API layer.
- Sensitive tokens are stored securely with flutter_secure_storage.
- Localization is supported through gen-l10n and ARB files.
- There is a separate AI chat endpoint apart from the main API.

## Core Technologies
- Flutter / Dart
- BLoC / Cubit
- get_it for dependency injection
- Dio for networking
- go_router for navigation
- flutter_screenutil for responsive layouts
- flutter_secure_storage for tokens
- shared_preferences for non-sensitive settings and data
- intl + gen-l10n for localization
- dartz for functional error handling and results
- cached_network_image, lottie, shimmer, svg, infinite_scroll_pagination for better UX

## Architecture
The project follows Clean Architecture with a feature-first organization.

Each feature usually contains:
- `data/` for data sources, models, and repository implementations
- `domain/` for entities, repository contracts, and use cases
- `presentation/` for cubits, states, screens, and widgets

This structure is clearly present in features such as:
- auth
- home
- product_details
- product_reviews
- favorites
- add_listing
- booking
- profile
- wallet
- subscription
- search
- ai_chat
- localization

## Data Flow
The typical flow in the project is:
UI / Screen
→ Cubit / BLoC
→ Use Case
→ Repository
→ Remote Data Source
→ Dio / API
→ Response parsing
→ Model
→ Entity

The final result comes back to the UI as clear states, with errors converted into Failure objects instead of being thrown directly into higher layers.

## Startup and Bootstrapping
`main.dart` does the following:
- Initializes Flutter bindings
- Sets up the service locator
- Loads the previously saved locale
- Injects ThemeCubit and LocaleCubit
- Starts MaterialApp.router
- Connects themes, languages, and routing
The app also uses ScreenUtil and wraps the app in SafeArea and GestureDetector so the keyboard closes when the user taps outside input fields.

## State Management and Dependency Injection
### BLoC / Cubit
The major features have their own Cubits, including:
- ThemeCubit
- LocaleCubit
- LoginCubit
- SignUpCubit
- ForgotPasswordCubit
- OtpCubit
- ProductCubit
- CategoryCubit
- FavoriteCubit
- ProductDetailsCubit
- ProductReviewCubit
- WalletCubit
- AddListingCubit
- AiChatCubit
- SearchCubit
- SubscriptionCubit
- SubscriptionBannerCubit
- UserProfileCubit### get_it
`service_locator.dart` wires together:
- API consumers
- auth interceptor
- cache helpers
- repositories
- use cases
- cubits

It also registers a dedicated client for the AI endpoint.

## Navigation and Screens
Navigation is configured in `router_generation_config.dart` using `go_router`, and it includes core screens such as:
- Splash
- Intro
- Login / Signup toggle
- Forgot password
- OTP verification
- Reset password
- Auth success
- Main screen
- Product details
- Product reviews
- Booking flow- User profile
- Settings
- Community
- Favorites
- Deals
- Wallet
- Add listing
- AI chat
- Search
- Subscription

Some screens also inject state automatically when opened, such as loading the user profile, product reviews, or subscriptions.

## Features in the Project
### 1) Authentication
- Sign in and sign up
- Forgot password
- OTP verification
- Reset password
- Secure token storage
- Automatic Authorization header injection through an interceptor
### 2) Home and Catalog
- Category listing
- Paginated product listing
- Product cards and discovery UI
- Product data fetched separately from the details page

### 3) Product Details
- Product information, images, and description
- Seller profile section
- Action buttons
- Reviews section

### 4) Search
- Direct text search
- Live suggestions
- Search result filtering
- Extra integration with an AI search endpoint

### 5) Favorites
- Add and remove favorite items
- Dedicated favorites screen
### 6) Add Listing
- Listing creation screen
- Components for uploads, price, condition, and helper fields
- The flow exists in practice, but the final backend/upload flow still appears to need full end-to-end review

### 7) Booking
- Booking flow exists across multiple screens
- The flow looks scaffolded and ready to expand

### 8) Reviews and Ratings
- Read product reviews
- Create / update / delete reviews
- Rating summary
- Helper UI for reviews and shimmer loading states

### 9) Wallet
- Balance display
- Transactions
- Withdraw requests
- Deposit / withdraw actions
- Supporting widgets for wallet states and empty views
### 10) Subscriptions
- Plan listing
- Subscription activation
- Upgrade banner
- Feature cards and CTA components

### 11) Profile and Settings
- View and edit personal data
- Change password
- Upload profile image
- Location form and personal info forms
- Settings screen

### 12) AI Chat
- Natural language chat interface
- Sends messages to a separate endpoint
- Returns text responses with product suggestions
- Custom widgets for messages and product cards
### 13) Localization and Theme
- Multi-language support via gen-l10n
- LocaleCubit for saving and restoring the locale
- ThemeCubit for switching between light and dark modes

## API and Backend Integration
Endpoints are centralized in `lib/core/databases/api/end_points.dart`.

### Base URLs
- `baseUrl`: main backend for the app
- `aiBaseUrl`: separate endpoint for AI chat/search

### Example Endpoints
- login / register / forgot password / validate otp
- categories / products
- product reviews
- favorites
- subscriptions
- wallet actions
- user profile operations
- AI chat endpoint### Important Notes
- The networking layer is unified through ApiConsumer / DioConsumer
- AuthInterceptor adds the Bearer token automatically
- Logging is available through Dio logger
- Errors are converted into exceptions and then Failures in higher layers

## Local Storage
- `flutter_secure_storage` for login tokens
- `shared_preferences` for non-sensitive settings such as locale
- `CacheHelper` and `TokenStorageHelper` are the main storage access layers

## UI and Design System
The project has a reusable UI system that includes:
- Primary and outline buttons
- Shared text fields
- Loading and shimmer widgets
- Filter components
- Card components for products, reviews, and wallet items
- SVG, Lottie, and network image support
There is also a clear focus on responsive layouts using ScreenUtil, with custom fonts such as:
- HindSiliguri
- InstrumentSans

## Top-Level Folder Structure
- `lib/core/` for shared setup: API, routing, styling, errors, utils, cache
- `lib/feature/` for all features
- `lib/l10n/` for localization files
- `assets/` for images, icons, and fonts

## What Looks Complete vs Scaffolded
### Reasonably Complete
- auth
- home/catalog
- product details
- favorites
- search
- reviews
- profile
- wallet
- subscription
- localization/theme
- AI chat### Still Scaffolded or Expanding
- Final booking flow
- End-to-end add listing flow
- Community / deals, where some screens exist but the logic is shallower than the core features
- A clear admin dashboard is not present in the current UI

## Technical Notes
- `main.dart` starts from the splash screen, not directly from the main screen.
- Some features depend on a ready backend with the same naming conventions used in repositories, use cases, and data sources.
- The project is well structured for extension because new features can follow the current pattern without breaking the architecture.

## Summary
RentalHub is a solid Flutter marketplace project focused on item rental experiences with clean architecture, clear routing, localization, organized state management, and a centralized API integration layer. It is better described as a codebase ready to grow than as a simple demo, because most shared foundations are already in place in a maintainable way.