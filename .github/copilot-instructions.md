# Copilot Instructions

Purpose
- Provide clear repository-level guidance for Copilot and code-assist features so suggestions are consistent and robust across edge cases.

Scope
- Applicable to all Dart/Flutter source files under `lib/`, `test/`, and CI workflows in this repository.

Expectations
- Keep changes minimal and focused: prefer small, well-tested edits over large refactors.
- Follow existing project conventions: null-safety, non-nullable types, and layered architecture (feature/core separation).
- Preserve i18n/ARB usage where present; avoid hardcoding user-visible strings.

Semantic Coverage / Edge Cases
- When interacting with remote APIs, handle HTTP redirects (307/308), non-JSON responses, and missing fields gracefully.
- Validate external inputs and provide defensive parsing for optional fields.
- Include clear error messages and map network errors to user-friendly messages.

Testing & Validation
- Add or update unit tests for any modified logic; run `flutter test` locally.
- For async/network code, prefer injecting mock clients and verifying behavior for success, error, and redirect cases.

Communication
- If a suggested change could affect app behavior (authentication, payments, data migrations), add a short PR description explaining the impact and testing steps.

If unsure about a suggestion, ask for clarification rather than assuming intent.

