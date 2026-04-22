---
name: flutter-language-toggle-clean-architecture
description: >-
  Implement instant Arabic/English language switching in Flutter apps using
  Clean Architecture, GoRouter, generated AppLocalizations, and persistent
  locale storage. Use when adding a language toggle, RTL/LTR support, or
  locale persistence.
---

# Purpose

Use this skill when the app needs a reusable, scalable localization workflow
that supports:

- A language toggle in the UI, such as on an intro screen.
- Instant locale changes without restarting the app.
- Persistent language preference across app restarts.
- Automatic RTL for Arabic and LTR for English.
- Clean Architecture separation between presentation, domain, and data.

# Prerequisites

Before making changes, confirm the app already has or will have:

1. `flutter_localizations` enabled and generated localization support.
2. ARB files for each supported language, typically `app_en.arb` and `app_ar.arb`.
3. A top-level app widget that can rebuild `MaterialApp.router` when locale changes.
4. A local storage mechanism such as `SharedPreferences` or an existing cache helper.

In this workspace, prefer the existing localization files under `lib/l10n/` and
the cache helper in `lib/core/databases/cache/cache_helper.dart`.

# Workflow

## 1. Inspect the current localization setup

Verify the generated localization entry point and supported locales:

- `lib/l10n/app_localizations.dart`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ar.arb`

Check that `AppLocalizations.supportedLocales` includes both `Locale('en')`
and `Locale('ar')`, and that the app uses the generated delegates.

## 2. Define the locale feature in Clean Architecture

Keep the feature split across layers:

- Domain: locale repository contract and use cases for reading and saving the selected locale.
- Data: `SharedPreferences` or cache-helper implementation.
- Presentation: a reactive state holder such as a `Cubit`, `Bloc`, or equivalent notifier that exposes the active locale and toggle action.

The presentation layer must own the UI rebuild trigger. Do not store locale state only in the screen widget if the language must update the whole app.

## 3. Load the saved locale at startup

On app launch:

- Read the stored locale code, if any.
- Fall back to the device locale or English if nothing is saved.
- Expose the locale before building `MaterialApp.router`.

The app should not wait for a manual refresh. The selected locale must be available as soon as the root app widget builds.

## 4. Wire `MaterialApp.router` to the locale state

Configure the root app with:

- `locale`
- `supportedLocales`
- `localizationsDelegates`
- `routerConfig`

The root widget should listen to locale state changes and rebuild `MaterialApp.router` whenever the user switches languages. This is what makes the change apply across all screens immediately.

## 5. Add the language toggle in `IntroScreen`

Place a small toggle icon or button in the intro screen, preferably near the top right or top left depending on the current direction.

When tapped, it should:

- Toggle between Arabic and English.
- Save the new locale locally.
- Trigger an app-wide rebuild.

Use `AppLocalizations.of(context)` for the button labels if text is shown. If an icon is used, make sure it still reads clearly in both directions.

## 6. Add or update translation keys

Keep keys simple and reusable. Recommended examples:

- `welcome`
- `next`
- `skip`
- `language`
- `arabic`
- `english`

Update both ARB files together so the generated `AppLocalizations` stays in sync.

## 7. Respect RTL/LTR automatically

Do not hardcode left/right layout assumptions when the locale can change.

Prefer directional widgets and properties where possible:

- `EdgeInsetsDirectional`
- `AlignmentDirectional`
- `TextAlign.start`
- `Directionality` inherited from the selected locale

If a widget still looks incorrect in Arabic, check for a hardcoded left/right alignment before adding any manual override.

# Implementation Checks

Before finishing, verify all of the following:

1. Tapping the intro-screen toggle switches Arabic and English instantly.
2. The whole app rebuilds, not just the intro screen.
3. The selected language persists after a cold restart.
4. Arabic uses RTL and English uses LTR automatically.
5. All user-facing strings come from `AppLocalizations`, not hardcoded text.
6. The generated localization files remain consistent with the ARB keys.

# Recommended App Wiring

Use this structure as the default mental model:

- `data/`: shared-preferences-backed locale storage.
- `domain/`: locale repository interface and save/load use cases.
- `presentation/`: locale controller or cubit.
- `app/` or root widget: listens to locale state and passes `locale` into `MaterialApp.router`.

# Example Translation Keys

Suggested ARB entries:

```json
{
  "welcome": "Welcome to RentalHub",
  "next": "Next",
  "skip": "Skip",
  "language": "Language",
  "english": "English",
  "arabic": "Arabic"
}
```

# Example Intro Toggle

Keep the UI simple and scalable:

```dart
IconButton(
  icon: const Icon(Icons.language),
  onPressed: () {
    context.read<LocaleCubit>().toggleLanguage();
  },
)
```

If the app uses another state-management approach, keep the behavior the same: toggle locale, save it, rebuild the root app widget.

# Completion Criteria

Only consider the task complete when:

- The language toggle is visible in `IntroScreen`.
- The selected locale is restored on restart.
- `MaterialApp.router` is configured with locale-aware localization delegates.
- The app uses `AppLocalizations` everywhere instead of fixed strings.
- Arabic screens render with RTL without extra manual fixes.
