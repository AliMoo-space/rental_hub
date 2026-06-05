# Product Feature Audit Report

## 1. API Coverage Audit

Here is the status of the `/api/Product` endpoints defined in the Swagger collection versus what is implemented in the Flutter application.

| Endpoint | Method | Status | Notes |
|---|---|---|---|
| `/api/Product/settings/commission` | GET | **Missing** | No datasource, repository, usecase, or UI integration. |
| `/api/Product` | GET | **Partial** | Implemented for general feed pagination, but missing filters (CategoryId, SubcategoryId, MinPrice, MaxPrice, Condition, MinRating) in home page. Implemented in search feature with filters. |
| `/api/Product` | POST | **Implemented** | Connected in `AddListingRemoteDataSourceImpl.createProduct` with multipart form-data. |
| `/api/Product/my-products` | GET | **Missing** | No datasource, repository, usecase, or UI integration. |
| `/api/Product/{id}` | GET | **Implemented** | Connected in `ProductDetailsRemoteDataSourceImpl` to get full product details, but UI displays static info. |
| `/api/Product/{id}` | PUT | **Missing** | No edit product datasource, repository, usecase, or UI integration. |
| `/api/Product/{id}` | DELETE | **Missing** | No delete product datasource, repository, usecase, or UI integration. |
| `/api/Product/admin/{id}/details` | GET | **Missing** | Missing admin datasource/usecases/UI. |
| `/api/Product/admin/all-with-stats` | GET | **Missing** | Missing admin datasource/usecases/UI. |
| `/api/Product/admin/{id}/approve` | PUT | **Missing** | Missing admin datasource/usecases/UI. |
| `/api/Product/admin/{id}/reject` | PUT | **Missing** | Missing admin datasource/usecases/UI. |
| `/api/Product/{id}/suspend` | PUT | **Missing** | Missing datasource/usecases/UI for owner suspension. |
| `/api/Product/{id}/activate` | PUT | **Missing** | Missing datasource/usecases/UI for owner activation. |
| `/api/Product/Admin/stats/counts` | GET | **Missing** | Missing admin datasource/usecases/UI. |
| `/api/Product/stats/owner` | GET | **Missing** | Missing owner general stats datasource/usecases/UI. |
| `/api/Product/user/{userId}` | GET | **Missing** | Missing user profile products page datasource/usecases/UI. |
| `/api/Product/{productId}/transactions` | GET | **Missing** | Missing product transaction history datasource/usecases/UI. |
| `/api/Product/{productId}/rental-requests` | GET | **Missing** | Missing product rental requests datasource/usecases/UI. |
| `/api/Product/{productId}/stats` | GET | **Missing** | Missing single product stats datasource/usecases/UI. |

---

## 2. Architecture Audit

*   **Clean Architecture Compliance**:
    *   **Data Layer**: Missing models/request bodies for editing products, fetching transactions, stats, and rental requests.
    *   **Domain Layer**: Missing use cases for editing, deleting, suspending, activating, and fetching stats/transactions/requests for products.
    *   **Presentation Layer**: Missing Cubits and screens for owner product management (My Products, Product Stats, Transactions, and Rental Requests).
*   **Dependency Injection**:
    *   New datasources, repositories, use cases, and cubits will need to be registered in `lib/core/utils/service_locator.dart`.
*   **Routing**:
    *   Missing route registrations in `lib/core/routing/router_generation_config.dart` and route definitions in `lib/core/routing/app_routes.dart` for the new product screens.

---

## 3. UI Audit

*   **Product Details Screen (`product_details_screen.dart`)**:
    *   **Issue**: It only displays the passed `ProductEntity` (preview model) directly. It does not fetch full product details from the backend via the existing `ProductDetailsCubit`. If a user deep-links or navigates to `/product-details/:id` directly without passing `extra`, the route builder displays a "Missing product data" error instead of calling the cubit to fetch it from `/api/Product/{id}`.
*   **Product Creation Flow (`add_listing_screen.dart`)**:
    *   Works, but only handles creation. Needs to be reusable or extended to support editing.
*   **Product Edit Flow**:
    *   **Issue**: Completely missing. No screen, edit cubit, or repository call.
*   **Product Deletion Flow**:
    *   **Issue**: Completely missing. Needs UI triggers in the product list / details screens.
*   **My Products Screen**:
    *   **Issue**: Completely missing. A page listing current user's products is needed, allowing owners to view, edit, suspend, activate, delete, or check stats/rental requests/transactions of their items.
*   **Product Statistics Screens**:
    *   **Issue**: Completely missing. Needs dashboard widgets showcasing counts, owner stats, and individual product stats.
*   **Product Transactions Screens**:
    *   **Issue**: Completely missing. Needs screen showing historical rental transactions for a given product.
*   **Product Rental Requests Screens**:
    *   **Issue**: Completely missing. Needs screen showing rental requests for a product.

---

## 4. Bug Detection

1.  **Broken Navigation on Deep Link**: Navigating to `productDetailsScreen` via route name without `extra` results in an error screen since it does not fall back to fetching details by ID.
2.  **Missing Loading/Error/Success States in Details**: The `ProductDetailsScreen` does not show a loading shim or handle API failure states since it bypasses the cubit entirely.
3.  **Missing Localization**: Add product/listing and management strings are partially missing or hardcoded.
4.  **Suspension / Activation UI & logic**: There's currently no way for a user to suspend/activate their products.

---

## 5. Proposed Files for Modification / Creation

### Feature: `add_listing` (extending to support editing)
*   [MODIFY] [add_listing_screen.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/presentation/screens/add_listing_screen.dart) - Add support for edit mode (handling passed product details, loading initial values, updating via PUT).
*   [MODIFY] [add_listing_cubit.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/presentation/cubit/add_listing_cubit.dart) - Add `updateListing` and state handling.
*   [MODIFY] [add_listing_remote_data_source.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/data/datasource/add_listing_remote_data_source.dart) - Add `updateProduct` API call.
*   [MODIFY] [add_listing_repo_impl.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/data/repo/add_listing_repo_impl.dart) & [add_listing_repo.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/domain/repo/add_listing_repo.dart) - Interface & implementation update.
*   [NEW] [update_listing_use_case.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/domain/usecases/update_listing_use_case.dart) - Add new usecase.

### Feature: `product_details` (connecting details cubit)
*   [MODIFY] [product_details_screen.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/product_details/presentation/screens/product_details_screen.dart) - Wrap with `BlocBuilder` to fetch details from cubit, handle loading shimmers and error states.
*   [MODIFY] [router_generation_config.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/routing/router_generation_config.dart) - Initialize `ProductDetailsCubit` in GoRoute builder for details screen, resolving by ID.

### New Feature: `my_products` (owner management console)
To modularize code cleanly, we will build a dedicated feature for user-owned products management, tracking stats, transactions, and rental requests:
*   [NEW] `lib/feature/my_products/data/models/` (OwnerStatsModel, RentalRequestModel, ProductTransactionModel)
*   [NEW] `lib/feature/my_products/data/datasource/my_products_remote_data_source.dart`
*   [NEW] `lib/feature/my_products/data/repo/my_products_repo_impl.dart`
*   [NEW] `lib/feature/my_products/domain/repo/my_products_repo.dart`
*   [NEW] `lib/feature/my_products/domain/usecases/` (GetMyProducts, DeleteProduct, SuspendProduct, ActivateProduct, GetOwnerStats, GetProductStats, GetProductTransactions, GetProductRentalRequests)
*   [NEW] `lib/feature/my_products/presentation/cubit/` (MyProductsCubit & ProductManagementCubit)
*   [NEW] `lib/feature/my_products/presentation/screens/` (MyProductsScreen, OwnerStatsScreen, ProductTransactionsScreen, ProductRentalRequestsScreen)

### Core Changes
*   [MODIFY] [end_points.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/databases/api/end_points.dart) - Add endpoints for My Products, edit, delete, activate, suspend, stats, transactions, and requests.
*   [MODIFY] [app_routes.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/routing/app_routes.dart) - Add route constants for the new screens.
*   [MODIFY] [router_generation_config.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/routing/router_generation_config.dart) - Register routing for new screens.
*   [MODIFY] [service_locator.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/utils/service_locator.dart) - Register DI mappings.
*   [MODIFY] [app_ar.arb](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/l10n/app_ar.arb) & [app_en.arb](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/l10n/app_en.arb) - Add l10n strings.
