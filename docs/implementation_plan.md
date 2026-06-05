# Implementation Plan - Product Feature Audit & Production-Readiness

This plan addresses all requirements to complete the API connection, architecture layers, and UI flows for the Product feature in the Rental Hub application.

## User Review Required

> [!IMPORTANT]
> Since "My Products", "Product Statistics", "Product Transactions", "Product Rental Requests", and "Edit Product" do not have existing UI components in the codebase, we will create clean, responsive UI screens that adhere to the project's design system (`AppColors`, `AppStyles`, `ScreenUtil` scaling, localization, and glassmorphic micro-animations).

---

## Open Questions

> [!NOTE]
> None. We will proceed with implementing standard, elegant UI designs using existing project widgets (e.g., custom buttons, text fields) and ensure high-fidelity screens.

---

## Proposed Changes

### Core Network & Routes

#### [MODIFY] [end_points.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/databases/api/end_points.dart)
- Add new endpoints:
  - `static const String productCommission = '/api/Product/settings/commission';`
  - `static const String myProducts = '/api/Product/my-products';`
  - `static String deleteProduct(int id) => '/api/Product/$id';`
  - `static String suspendProduct(int id) => '/api/Product/$id/suspend';`
  - `static String activateProduct(int id) => '/api/Product/$id/activate';`
  - `static const String ownerStats = '/api/Product/stats/owner';`
  - `static String productUserList(String userId) => '/api/Product/user/$userId';`
  - `static String productTransactions(int productId) => '/api/Product/$productId/transactions';`
  - `static String productRentalRequests(int productId) => '/api/Product/$productId/rental-requests';`
  - `static String productStats(int productId) => '/api/Product/$productId/stats';`

#### [MODIFY] [app_routes.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/routing/app_routes.dart)
- Define route names/paths for:
  - My Products screen (`/myProductsScreen`)
  - Product Stats screen (`/productStatsScreen/:productId`)
  - Product Transactions screen (`/productTransactionsScreen/:productId`)
  - Product Rental Requests screen (`/productRentalRequestsScreen/:productId`)
  - Owner Dashboard / Stats screen (`/ownerStatsScreen`)

---

### Add Listing Feature (Edit Product Support)

#### [MODIFY] [add_listing_screen.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/presentation/screens/add_listing_screen.dart)
- Modify `AddListingScreen` to accept an optional `ProductEntity? productToEdit` parameter.
- If editing, populate controllers and picker states with the existing product properties.
- Update the submit action to perform a `PUT /api/Product/{id}` using the new `UpdateListingUseCase` instead of a `POST`.

#### [NEW] [update_product_request.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/data/models/update_product_request.dart)
- Create update request class compiling data into `FormData` with parameters:
  - CategoryId, SubcategoryId, LocationArea, Condition, ProductType, Brand, RentalGuarantee, Name, Description, BasePricePerDay, TermsConditions, City, governorate, NewImages, DeletedImageIds, and PrimaryImageId.

#### [MODIFY] [add_listing_remote_data_source.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/data/datasource/add_listing_remote_data_source.dart)
- Add `Future<String> updateProduct(int id, UpdateProductRequest request)` to interface and class.

#### [MODIFY] [add_listing_repo.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/domain/repo/add_listing_repo.dart) & [add_listing_repo_impl.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/data/repo/add_listing_repo_impl.dart)
- Add `updateListing` contract and implementation.

#### [NEW] [update_listing_use_case.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/domain/usecases/update_listing_use_case.dart)
- Implement edit usecase mapping requests to repository.

#### [MODIFY] [add_listing_cubit.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/add_listing/presentation/cubit/add_listing_cubit.dart)
- Add `updateListing` method which handles states and delegates to `UpdateListingUseCase`.

---

### Product Details Feature (Robust Deep Linking)

#### [MODIFY] [product_details_screen.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/product_details/presentation/screens/product_details_screen.dart)
- Modify `ProductDetailsScreen` constructor to accept a `productId` parameter instead of (or in addition to) the preview `ProductEntity`.
- Wrap the UI builder in a `BlocBuilder<ProductDetailsCubit, ProductDetailsState>`.
- In `initState`, trigger `fetchProductDetails(productId)`.
- Render a premium loading shimmer state during fetching, error handling fallback, and populate fields using the fetched `ProductDetailsEntity`.
- Add "Edit", "Suspend", "Activate", and "Delete" actions in the details screen if the product belongs to the current logged-in user.

---

### New Feature: My Products Management Slice

To fulfill My Products, Stats, Transactions, and Rental Requests cleanly without cluttering the main homepage flow:

#### [NEW] [my_products_remote_data_source.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/data/datasource/my_products_remote_data_source.dart)
- Remote datasource endpoints:
  - `getMyProducts(int page)` -> `/api/Product/my-products`
  - `deleteProduct(int id)` -> `DELETE /api/Product/{id}`
  - `suspendProduct(int id)` -> `PUT /api/Product/{id}/suspend`
  - `activateProduct(int id)` -> `PUT /api/Product/{id}/activate`
  - `getOwnerStats()` -> `/api/Product/stats/owner`
  - `getProductStats(int id)` -> `/api/Product/{id}/stats`
  - `getProductTransactions(int id)` -> `/api/Product/{id}/transactions`
  - `getProductRentalRequests(int id)` -> `/api/Product/{id}/rental-requests`

#### [NEW] [my_products_repo.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/repo/my_products_repo.dart) & [my_products_repo_impl.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/data/repo/my_products_repo_impl.dart)
- Define Contracts & implementations.

#### [NEW] Usecase Files:
- [getMyProducts](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/get_my_products.dart)
- [deleteProduct](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/delete_product.dart)
- [suspendProduct](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/suspend_product.dart)
- [activateProduct](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/activate_product.dart)
- [getOwnerStats](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/get_owner_stats.dart)
- [getProductStats](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/get_product_stats.dart)
- [getProductTransactions](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/get_product_transactions.dart)
- [getProductRentalRequests](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/domain/usecases/get_product_rental_requests.dart)

#### [NEW] Models and Entities:
- Owner Stats model & entity
- Product Stats model & entity
- Product Transaction model & entity
- Product Rental Request model & entity

#### [NEW] [my_products_cubit.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/presentation/cubit/my_products_cubit.dart)
- Manages the pagination feed of my products list, deletion, suspension, and activation.

#### [NEW] [owner_stats_cubit.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/feature/my_products/presentation/cubit/owner_stats_cubit.dart)
- Manages loading statistics, transactions, and rental requests.

#### [NEW] UI Screens under `lib/feature/my_products/presentation/screens/`:
- **`my_products_screen.dart`**: Shows a list of products with quick actions (edit, delete, suspend/activate, stats, transactions, requests).
- **`owner_stats_screen.dart`**: General statistics of the owner.
- **`product_transactions_screen.dart`**: Transaction logs/history of a specific product.
- **`product_rental_requests_screen.dart`**: List of requests for a specific product.

---

### App Wiring (DI, Routing, Localization)

#### [MODIFY] [service_locator.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/utils/service_locator.dart)
- Register `MyProductsRemoteDataSource`, `MyProductsRepo`, and all corresponding use cases.
- Register `MyProductsCubit`, `OwnerStatsCubit` and the new `UpdateListingUseCase` in DI setup.

#### [MODIFY] [router_generation_config.dart](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/core/routing/router_generation_config.dart)
- Add route configurations:
  - `myProductsScreen` (with `MyProductsCubit` injection).
  - `ownerStatsScreen` (with `OwnerStatsCubit` injection).
  - `productTransactionsScreen` (with ID mapping).
  - `productRentalRequestsScreen` (with ID mapping).
- Update details route mapping to initialize `ProductDetailsCubit` using the ID.

#### [MODIFY] [app_en.arb](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/l10n/app_en.arb) & [app_ar.arb](file:///Users/alimohamed/Desktop/الكليه/rental_hub-1/lib/l10n/app_ar.arb)
- Add required localized strings (e.g., "Edit Product", "Delete Product", "Suspend", "Activate", "Rental History", "Rental Requests", "Owner Dashboard").

---

## Verification Plan

### Automated Tests
- Run code analysis to check for static issues:
  `flutter analyze`
- Run build runner if needed, or localization command to generate classes:
  `flutter gen-l10n`

### Manual Verification
- We will build the layout and verify correct API mapping and screen transitions.
