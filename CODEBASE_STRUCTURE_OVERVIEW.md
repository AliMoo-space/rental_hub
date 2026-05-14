# Rental Hub Flutter App - Comprehensive Codebase Structure Overview

## Project Architecture Summary
The project follows **Clean Architecture** with **BLoC/Cubit** for state management, organized by feature modules. Each major feature has a complete data/domain/presentation layer structure.

---

## 1. ALL EXISTING SCREENS AND THEIR PATHS

### Authentication Feature (`lib/feature/auth/`)
- **Login Screen**: `lib/feature/auth/presentation/screens/login_screen.dart`
- **Signup Screen**: `lib/feature/auth/presentation/screens/signup_screen.dart`
- **Forgot Password Screen**: `lib/feature/auth/presentation/screens/forgot_password_screen.dart`
- **OTP Verification Screen**: `lib/feature/auth/presentation/screens/otp_verification_screen.dart`
- **Reset Password Screen**: `lib/feature/auth/presentation/screens/reset_password_screen.dart`
- **Auth Success Screen**: `lib/feature/auth/presentation/screens/auth_success_screen.dart`

### Home Feature (`lib/feature/home/`)
- **Home Screen**: `lib/feature/home/presentation/screens/home_screen.dart`

### Navigation & Main (`lib/feature/main/`)
- **Main Screen** (Bottom Tab Navigation): `lib/feature/main/main_screen.dart`

### Deals Feature (`lib/feature/deals/`)
- **Deals Screen**: `lib/feature/deals/presentation/screens/deals_screen.dart`

### Favorites Feature (`lib/feature/favorites/`)
- **Favorites Screen**: `lib/feature/favorites/presentation/screens/favorites_screen.dart`

### Wallet Feature (`lib/feature/wallet/`)
- **Wallet Screen**: `lib/feature/wallet/presentation/screens/wallet_screen.dart`

### Profile Feature (`lib/feature/profile/`)
- **Profile Screen**: `lib/feature/profile/presentation/screens/profile_screen.dart`

### Add Listing Feature (`lib/feature/add_listing/`)
- **Add Listing Screen**: `lib/feature/add_listing/presentation/screens/add_listing_screen.dart`

### Intro Feature (`lib/feature/intro/`)
- **Intro Screen**: `lib/feature/intro/intro_screen.dart`

### Splash Screen (`lib/feature/splash/`)
- **Splash View**: `lib/feature/splash/splash_view.dart`

### Community Feature (`lib/feature/community/`)
- **Community Screen**: `lib/feature/community/presentation/screens/community_screen.dart`

### Theme Feature (`lib/feature/theme/`)
- No dedicated screen, only state management

### Localization Feature (`lib/feature/localization/`)
- No dedicated screen, only state management

---

## 2. ALL CUSTOM WIDGETS IN REUSABLE COMPONENTS

### Core Widgets Library (`lib/core/widgets/`)
**Base/Reusable Components:**
- `primary_button_widget.dart` - Main action button with loading state & icon support
- `primary_outline_button_widget.dart` - Secondary outlined button
- `custom_text_field.dart` - Standard text input field with validation
- `spacing_widgets.dart` - Size boxes and spacing helpers
- `loading_widget.dart` - Loading indicators
- `theme_toggle_button.dart` - Dark/light theme switcher
- `filter_header_widget.dart` - Filter UI header component
- `snack_bar_widget.dart` - Custom snack bar notifications

### Feature-Specific Widgets

#### Home Feature Widgets (`lib/feature/home/presentation/widgets/`)
- `home_header_widget.dart` - App bar with logo and notifications
- `home_search_section_widget.dart` - Search UI component
- `home_categories_widget.dart` - Category selection/display
- `home_recommended_items_list_widget.dart` - Scrollable list of items
- `home_recommended_item_card_widget.dart` - Individual item card
- `home_item_rating_widget.dart` - Star rating display component

#### Auth Feature Widgets (`lib/feature/auth/presentation/widgets/`)
- `animated_auth_toggle.dart` - Animated login/signup toggle
- `social_login_widget.dart` - Google/Facebook login buttons
- `otp_pin_code_field_widget.dart` - 6-digit OTP input field
- `terms_widget.dart` - Terms & conditions display

#### Add Listing Feature Widgets (`lib/feature/add_listing/presentation/widgets/`)
- `condition_toggle_button.dart` - New/Used condition selector
- `dashed_upload_box.dart` - Image upload area with dashed border
- `labeled_text_field.dart` - Text field with label
- `listing_card.dart` - Preview card for listing
- `picker_field.dart` - Date/category picker field
- `price_field.dart` - Price input with formatting

#### Deals Feature Widgets (`lib/feature/deals/presentation/widgets/`)
- `deals_widgets.dart` - Various deal display components
- `deals_filter_chip.dart` - Filter chips for deals
- `deals_compact_item_tile.dart` - Compact listing tile

#### Profile Feature Widgets (`lib/feature/profile/presentation/widgets/`)
- `app_drawer.dart` - Drawer navigation menu

#### Wallet Feature Widgets (`lib/feature/wallet/presentation/widgets/`)
- `balance_item_card.dart` - Balance/transaction card

#### Favorites Feature Widgets (`lib/feature/favorites/presentation/widgets/`)
- `favorites_sheets.dart` - Bottom sheets for favorites

#### Intro Feature Widgets (`lib/feature/intro/widgets/`)
- `refactor.dart` - Intro page components

---

## 3. THEME SYSTEM FILES AND STYLING APPROACH

### Theme System Architecture (`lib/core/styling/`)

**Core Theme Files:**
- **`theme_data.dart`** - Defines `AppThemes.lightTheme` with Material3 design tokens, including:
  - Color scheme configuration
  - Text theme with typography hierarchy
  - Button themes
  - Custom page transitions using `GoTransitions`
  - Support for light/dark mode foundation

- **`app_colors.dart`** - Centralized color palette containing:
  - **Primary Colors**: `primaryColor` (0xff6A72F5), `primarySoftColor`, `primaryDarkColor`
  - **Semantic Colors**: `textPrimaryColor`, `textSecondaryColor`, `textMutedColor`
  - **Surface Colors**: `surfaceColor`, `backgroundColor`, `borderColor`
  - **Utility Colors**: `successColor`, `errorColor`, `warningColor`
  - **Navigation Colors**: `bottomNavigationActiveColor`, `bottomNavigationInactiveColor`
  - **Decorative Palette**: Array of colors for UI elements

- **`app_fonts.dart`** - Typography configuration:
  - Main font: `Urbanist`
  - Alt font: `HindSiliguri` 
  - Code font: `InstrumentSans`

- **`app_styles.dart`** - Text style hierarchy using `flutter_screenutil` for responsive sizing:
  - **Display Styles**: `displayLarge`, `displayMedium` (36px, 32px)
  - **Heading Styles**: `headlineMedium`, `headlineSmall` (24px)
  - **Body Styles**: `bodyLarge`, `bodyMedium`, `bodySmall`
  - **Label Styles**: `labelSmall`, `buttonLabel`
  - Uses `_style()` helper method for consistent configuration
  - All text sizes use `.sp` for screen responsiveness

- **`app_shadows.dart`** - Shadow effects for elevated components

- **`app_assets.dart`** - Asset paths management:
  - Icons path: `assets/icons/` (SVG)
  - Images path: `assets/images/` (PNG)
  - Lottie animations: `assets/lottie/` (JSON)
  - Predefined constants for 20+ icons (logo, bell, heart, location, etc.)

### Styling Approach
- **Responsive Design**: Uses `flutter_screenutil` for device-agnostic sizing
- **Design System**: Material3 with custom extensions
- **Color Semantics**: Semantic naming (primary, secondary, error, success, warning)
- **Typography Hierarchy**: Clear separation of display, heading, body, and label text
- **Theme Management**: Centralized through `AppThemes` class

---

## 4. UTILITY/HELPER FILES AND EXTENSIONS

### Utilities (`lib/core/utils/`)
- **`service_locator.dart`** - GetIt dependency injection setup for all services, cubits, and repositories
- **`validation_utils.dart`** - Input validation helpers:
  - Email validation with regex
  - OTP validation (6 digits, digits-only check)
  - Normalization methods
- **`response_parser.dart`** - API response parsing logic
- **`snack_bar_widget.dart`** - Reusable snack bar notifications

### Extensions (`lib/core/extensions/`)
- **`localization_extension.dart`** - BuildContext extension for easy access to `AppLocalizations`
  - Allows: `context.l10n` to access localized strings

### Error Handling (`lib/core/errors/`)
- **`error_handling.dart`** - Error handling utilities
- **`error_model.dart`** - Structured error response model:
  - Parses API error responses
  - Provides `firstErrorMessage` getter
  - Supports multi-field validation errors
- **`failure.dart`** - Domain layer failure entities

### Connection & Networking (`lib/core/connection/`)
- **`network_info.dart`** - Network connectivity checking

### Databases & APIs (`lib/core/databases/`)
**API Layer** (`api/`):
- `api_consumer.dart` - Abstract API interface
- `dio_consumer.dart` - Dio HTTP client implementation
- `end_points.dart` - API endpoint definitions

**Cache Layer** (`cache/`):
- `cache_helper.dart` - Local data caching using SharedPreferences

---

## 5. COMMON & BASE WIDGETS USED ACROSS PROJECT

### Commonly Reused Widgets
1. **PrimaryButtonWidget** - Used across auth, home, add_listing, deals screens
2. **CustomTextField** - Input fields in auth, add_listing, deals screens
3. **LoadingWidget** - Loading states throughout app
4. **PrimaryOutlineButtonWidget** - Secondary actions
5. **HomeHeaderWidget** - AppBar in main navigation areas
6. **Filter components** - Deals, Home screens

### UI Component Pattern
All widgets follow this structure:
```
WidgetName {
  - Required parameters (content)
  - Optional parameters (styling/callbacks)
  - Constructor with documentation
  - Widget hierarchy
}
```

### State Management Pattern
- **BLoC/Cubit** used for:
  - Authentication (`LoginCubit`, `ForgotPasswordCubit`, `OtpCubit`)
  - Theme (`ThemeCubit`)
  - Localization (`LocaleCubit`)
  - Home data (`CategoryCubit`, `ProductCubit`)
  - Wallet (`WalletCubit` implied)
  - Add Listing (`AddListingCubit` implied)

---

## 6. CURRENT NAMING CONVENTIONS AND FOLDER ORGANIZATION

### File Naming Conventions
- **Screens**: `{feature_name}_screen.dart` (e.g., `home_screen.dart`)
- **Widgets**: `{context}_widget.dart` (e.g., `primary_button_widget.dart`)
- **Cubits**: `{entity}_cubit.dart` (e.g., `login_cubit.dart`)
- **States**: `{entity}_state.dart` (e.g., `login_state.dart`)
- **Models**: `{entity}_model.dart` (e.g., `login_model.dart`)
- **Entities**: `{entity}_entity.dart` (e.g., `login_entity.dart`)
- **Use Cases**: `{action}_use_case.dart` (e.g., `login_use_case.dart`)
- **Repositories**: `{entity}_repo.dart` or `{entity}_repo_impl.dart`
- **Data Sources**: `{entity}_remote_data_source.dart` or `{entity}_remote_data_source_impl.dart`

### Folder Organization Pattern

```
feature/{feature_name}/
├── data/
│   ├── datasource/
│   │   ├── {entity}_remote_data_source.dart
│   │   ├── {entity}_remote_data_source_impl.dart
│   │   └── {entity}_local_data_source.dart
│   ├── models/
│   │   └── {entity}_model.dart
│   └── repo/
│       └── {entity}_repo_impl.dart
├── domain/
│   ├── entities/
│   │   └── {entity}_entity.dart
│   ├── repo/
│   │   └── {entity}_repo.dart
│   └── usecases/
│       └── {action}_use_case.dart
└── presentation/
    ├── cubit/
    │   ├── {entity}_cubit.dart
    │   └── {entity}_state.dart
    ├── screens/
    │   └── {feature}_screen.dart
    └── widgets/
        └── {descriptive}_widget.dart
```

### Feature Organization
- **Features with full Clean Architecture**: `home`, `auth`, `wallet`, `add_listing`, `localization`
- **Features with presentation only**: `deals`, `favorites`, `profile`, `community`, `splash`, `intro`
- **Special features**: `theme` (state management only), `main` (navigation)

### Core Organization
```
core/
├── connection/        # Network connectivity
├── databases/         # API & cache layers
│   ├── api/          # HTTP client setup
│   └── cache/        # Local storage
├── errors/           # Error models & failure classes
├── extensions/       # Dart extensions
├── localization/     # Locale cubit
├── routing/          # Navigation setup
├── styling/          # Design tokens & theme
├── utils/            # Helpers & utilities
└── widgets/          # Reusable UI components
```

### L10n & Localization
- **Location**: `lib/l10n/`
- **Generated files**: `lib/l10n/generated/app_localizations.dart`
- **ARB files**: `lib/l10n/app_*.arb` (for translations)

### App Entry Point
- **Main file**: `lib/main.dart`
  - Initializes service locator
  - Sets up locale and theme cubits
  - Configures responsive design with `ScreenUtilInit`
  - Applies GoRouter for navigation

---

## 7. KEY TECHNOLOGIES & DEPENDENCIES

### State Management
- `flutter_bloc` - BLoC/Cubit pattern
- `get_it` - Service locator/Dependency injection

### Networking & Data
- `dio` - HTTP client
- `shared_preferences` - Local caching

### Navigation
- `go_router` - Route configuration
- `go_transitions` - Custom page transitions

### UI & Styling
- `flutter_screenutil` - Responsive design
- `flutter_svg` - SVG rendering
- `go_transitions` - Custom animations

### Localization
- `flutter_localizations` - Multi-language support
- Generated `AppLocalizations` classes

### Database
- Implied Firebase integration (based on project structure hints)

---

## 8. CLEAN ARCHITECTURE LAYERS

### Presentation Layer
- Screens (UI pages)
- Widgets (reusable components)
- Cubits (state management)
- States (state classes)

### Domain Layer
- Entities (business objects)
- Repositories (abstract)
- Use Cases (business logic)

### Data Layer
- Remote Data Sources (API calls)
- Local Data Sources (cache)
- Repository Implementations
- Models (API responses)

---

## 9. KEY PATTERNS & CONVENTIONS

### Error Handling
- Structured `ErrorModel` with field-level validation
- Domain `Failure` classes
- Error model includes `statusCode`, `message`, and `errors` map

### Routing
- Centralized in `RouterGenerationConfig`
- Named routes via `AppRoutes` constants
- Initial route: Splash screen
- BLoC providers injected per route where needed

### Localization
- Extension-based access: `context.l10n.{key}`
- Locale persistence via `CacheHelper`
- Cubit-based state management for locale switching

### Theming
- Light theme configured (dark mode foundation prepared)
- Material3 design system
- Responsive typography and sizing
- Centralized color palette

### Responsive Design
- Uses `flutter_screenutil` with design size of `402x889`
- Minimal text adaptation
- All spacing and font sizes use `.sp` and `.w/.h` modifiers

