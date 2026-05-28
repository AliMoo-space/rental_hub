import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rental_hub/core/databases/api/auth_interceptor.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/dio_consumer.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/feature/favorites/data/datasource/favorite_remote_data_source.dart';
import 'package:rental_hub/feature/favorites/data/repo/favorite_repo_imp.dart';
import 'package:rental_hub/feature/favorites/domain/repo/favorite_repo.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/add_to_favorite_usecase.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/remove_favorite_use_case.dart';
import 'package:rental_hub/feature/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:rental_hub/feature/add_listing/data/datasource/add_listing_remote_data_source.dart';
import 'package:rental_hub/feature/add_listing/data/repo/add_listing_repo_impl.dart';
import 'package:rental_hub/feature/add_listing/domain/repo/add_listing_repo.dart';
import 'package:rental_hub/feature/add_listing/domain/usecases/add_listing_use_case.dart';
import 'package:rental_hub/feature/add_listing/presentation/cubit/add_listing_cubit.dart';
import 'package:rental_hub/feature/home/data/datasource/product_remote_data_source.dart';
import 'package:rental_hub/feature/localization/data/repo/locale_repository_impl.dart';
import 'package:rental_hub/feature/localization/domain/repo/locale_repository.dart';
import 'package:rental_hub/feature/localization/domain/usecases/get_saved_locale_use_case.dart';
import 'package:rental_hub/feature/localization/domain/usecases/save_locale_use_case.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';
import 'package:rental_hub/feature/subscription/data/datasource/subscription_remote_data_source.dart';
import 'package:rental_hub/feature/subscription/data/repo/subscription_repo_impl.dart';
import 'package:rental_hub/feature/subscription/domain/repo/subscription_repo.dart';
import 'package:rental_hub/feature/subscription/domain/usecases/get_subscriptions_usecase.dart';
import 'package:rental_hub/feature/subscription/domain/usecases/subscribe_to_plan_use_case.dart';
import 'package:rental_hub/feature/subscription/domain/usecases/get_subscription_active_use_case.dart';
import 'package:rental_hub/feature/subscription/presentation/cubit/subscription_banner_cubit.dart';
import 'package:rental_hub/feature/subscription/presentation/cubit/subscription_cubit.dart';
import 'package:rental_hub/feature/product_details/data/datasource/product_details_remote_data_source.dart';
import 'package:rental_hub/feature/product_details/data/repo/product_details_repo_impl.dart';
import 'package:rental_hub/feature/product_details/domain/repo/product_details_repo.dart';
import 'package:rental_hub/feature/product_details/domain/usecases/product_details_use_case.dart';
import 'package:rental_hub/feature/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:rental_hub/feature/product_reviews/data/datasources/product_review_remote_data_source.dart';
import 'package:rental_hub/feature/product_reviews/data/repositories/product_review_repository_impl.dart';
import 'package:rental_hub/feature/product_reviews/domain/repositories/product_review_repository.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/create_product_review_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/delete_product_review_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/get_product_rating_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/get_product_reviews_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/update_product_review_usecase.dart';
import 'package:rental_hub/feature/product_reviews/presentation/cubit/product_review_cubit.dart';
import 'package:rental_hub/feature/theme/presentation/cubit/theme_cubit.dart';
import 'package:rental_hub/feature/ai_chat/data/datasource/ai_remote_data_source.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/feature/ai_chat/data/repo/ai_chat_repo_impl.dart';
import 'package:rental_hub/feature/ai_chat/domain/repo/ai_chat_repo.dart';
import 'package:rental_hub/feature/ai_chat/domain/usecases/send_message_use_case.dart';
import 'package:rental_hub/feature/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:rental_hub/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source_impl.dart';
import 'package:rental_hub/feature/auth/data/repo/auth_repository_impl.dart';
import 'package:rental_hub/feature/auth/data/datasource/forgot_password_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/forgot_password_remote_data_source_impl.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source_imp.dart';
import 'package:rental_hub/feature/auth/domain/repo/auth_repository.dart';
import 'package:rental_hub/feature/auth/domain/repo/login_repo.dart';
import 'package:rental_hub/feature/auth/data/repo/login_repo_impl.dart';
import 'package:rental_hub/feature/auth/domain/repo/forgot_password_repo.dart';
import 'package:rental_hub/feature/auth/data/repo/forgot_password_repo_impl.dart';
import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';
import 'package:rental_hub/feature/auth/data/repo/validate_otp_entity_imp.dart';
import 'package:rental_hub/feature/auth/domain/usecases/login_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/sign_up_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/validate_otp_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/otp_cubit.dart';
import 'package:rental_hub/feature/home/data/datasource/category_remote_data_source.dart';
import 'package:rental_hub/feature/home/data/datasource/product_remote_data_source_imp.dart';
import 'package:rental_hub/feature/home/data/repo/category_repo_impl.dart';
import 'package:rental_hub/feature/home/data/repo/product_repo_impl.dart';
import 'package:rental_hub/feature/home/domain/repo/category_repo.dart';
import 'package:rental_hub/feature/home/domain/repo/product_repo.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_category.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_products.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_subcategories_usecase.dart';
import 'package:rental_hub/feature/home/presentation/cubit/category_cubit.dart';
import 'package:rental_hub/feature/home/presentation/cubit/product_cubit.dart';
import 'package:rental_hub/feature/wallet/data/datasource/wallet_remote_data_source.dart';
import 'package:rental_hub/feature/wallet/data/repo/wallet_repo_impl.dart';
import 'package:rental_hub/feature/wallet/domain/repo/wallet_repo.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/deposit_wallet_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/get_wallet_balance_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/get_wallet_transactions_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/get_withdraw_requests_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/request_wallet_withdraw_use_case.dart';
import 'package:rental_hub/feature/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:rental_hub/feature/profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:rental_hub/feature/search/data/datasources/ai_search_remote_data_source.dart';
import 'package:rental_hub/feature/search/data/datasources/search_remote_data_source.dart';
import 'package:rental_hub/feature/search/data/repositories/search_repository_impl.dart';
import 'package:rental_hub/feature/search/domain/repositories/search_repository.dart';
import 'package:rental_hub/feature/search/domain/usecases/live_search_usecase.dart';
import 'package:rental_hub/feature/search/domain/usecases/search_products_usecase.dart';
import 'package:rental_hub/feature/search/presentation/cubit/search_cubit.dart';
import 'package:rental_hub/feature/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:rental_hub/feature/profile/domain/repositories/user_profile_repository.dart';
import 'package:rental_hub/feature/profile/domain/usecases/change_password_usecase.dart';
import 'package:rental_hub/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:rental_hub/feature/profile/domain/usecases/update_profile_usecase.dart';
import 'package:rental_hub/feature/profile/domain/usecases/upload_image_usecase.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ================= INIT =================
  await CacheHelper.init();

  // ================= CORE =================
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton<TokenStorageHelper>(
    () => TokenStorageHelper(getIt<CacheHelper>()),
  );
  getIt.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(getIt<TokenStorageHelper>()),
  );
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: Dio(), authInterceptor: getIt<AuthInterceptor>()),
  );

  // Dedicated ApiConsumer for AI endpoints (separate Dio instance)
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: Dio(BaseOptions(baseUrl: EndPoints.aiBaseUrl)),
      authInterceptor: getIt<AuthInterceptor>(),
    ),
    instanceName: 'ai',
  );

  // ===================== LOCALIZATION =======================

  getIt.registerLazySingleton<LocaleRepository>(
    () => LocaleRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetSavedLocaleUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveLocaleUseCase(getIt()));
  getIt.registerLazySingleton(() => LocaleCubit(getIt(), getIt()));

  // ======================= REPOSITORIES =====================

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(getIt()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordRepoImpl(getIt()),
  );

  getIt.registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(getIt()));

  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImp(getIt()),
  );

  getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(getIt()));
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(getIt()));
  getIt.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoImp(favoriteRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<SubscriptionRepo>(
    () => SubscriptionRepoImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ProductDetailsRepo>(
    () => ProductDetailsRepoImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductReviewRepository>(
    () => ProductReviewRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<WalletRepo>(() => WalletRepoImpl(getIt()));
  getIt.registerLazySingleton<AddListingRepo>(
    () => AddListingRepoImpl(getIt()),
  );
  getIt.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(getIt()),
  );

  // ======================= USE CASES ========================

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => ResendOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCategory(categoryRepo: getIt()));
  getIt.registerLazySingleton(
    () => GetSubcategoriesUseCase(categoryRepo: getIt()),
  );
  getIt.registerLazySingleton(() => GetProducts(productRepo: getIt()));
  getIt.registerLazySingleton(
    () => AddToFavoriteUseCase(favoriteRepo: getIt()),
  );
  getIt.registerLazySingleton(
    () => RemoveFavoriteUseCase(favoriteRepo: getIt()),
  );

  getIt.registerLazySingleton(() => GetSubscriptionsUseCase(getIt()));
  getIt.registerLazySingleton(() => SubscribeToPlanUseCase(getIt()));
  getIt.registerLazySingleton(() => GetSubscriptionActiveUseCase(getIt()));
  getIt.registerFactory(() => SubscriptionBannerCubit(getIt()));
  getIt.registerLazySingleton(() => ProductDetailsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductReviewsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProductRatingUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateProductReviewUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProductReviewUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteProductReviewUseCase(getIt()));
  getIt.registerLazySingleton(() => AddListingUseCase(getIt()));
  getIt.registerLazySingleton(() => GetWalletBalanceUseCase(getIt()));
  getIt.registerLazySingleton(() => GetWalletTransactionsUseCase(getIt()));
  getIt.registerLazySingleton(() => DepositWalletUseCase(getIt()));
  getIt.registerLazySingleton(() => RequestWalletWithdrawUseCase(getIt()));
  getIt.registerLazySingleton(() => GetWithdrawRequestsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadImageUseCase(getIt()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(getIt()));

  // ======================= AI CHAT ========================
  getIt.registerLazySingleton<AiRemoteDataSource>(
    () => AiRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<AiChatRepo>(() => AiChatRepoImpl(getIt()));

  getIt.registerLazySingleton(() => SendMessageUseCase(getIt()));

  // ======================= SEARCH FEATURE ==================
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<AiSearchRemoteDataSource>(
    () => AiSearchRemoteDataSourceImpl(getIt<ApiConsumer>(instanceName: 'ai')),
  );

  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton(() => LiveSearchUseCase(getIt()));
  getIt.registerLazySingleton(() => SearchProductsUseCase(getIt()));

  getIt.registerFactory(() => SearchCubit(getIt(), getIt()));

  // ===================== DATA SOURCES =======================

  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      apiConsumer: getIt(),
      tokenStorageHelper: getIt(),
    ),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<ForgotPasswordRemoteDataSource>(
    () => ForgotPasswordRemoteDataSourceImpl(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSourceImpl(apiConsumer: getIt()),
  );

  getIt.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImp(getIt()),
  );

  getIt.registerLazySingleton<SubscriptionRemoteDataSource>(
    () => SubscriptionRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<ProductDetailsRemoteDataSource>(
    () => ProductDetailsRemoteDataSourceImpl(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<ProductReviewRemoteDataSource>(
    () => ProductReviewRemoteDataSourceImpl(
      apiConsumer: getIt(),
      tokenStorageHelper: getIt(),
    ),
  );
  getIt.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<AddListingRemoteDataSource>(
    () => AddListingRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(getIt()),
  );

  // ========================= CUBITS =========================

  getIt.registerLazySingleton(() => ThemeCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => SignUpCubit(getIt()));
  getIt.registerFactory(() => ForgotPasswordCubit(getIt()));
  getIt.registerFactory(() => CategoryCubit(getIt()));
  getIt.registerFactory(() => ProductCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory<FavoriteCubit>(
    () => FavoriteCubit(getFavorites: getIt()),
  );
  getIt.registerFactory(() => SubscriptionCubit(getIt(), getIt()));
  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(getIt()),
  );
  getIt.registerFactory(
    () => ProductReviewCubit(
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory(() => AiChatCubit(getIt()));
  getIt.registerFactory(
    () => WalletCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton(
    () => UserProfileCubit(getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerFactory(() => AddListingCubit(getIt(), getIt(), getIt()));
  getIt.registerFactoryParam<OtpCubit, String, void>(
    (email, _) => OtpCubit(
      email: email,
      verifyOtpUseCase: getIt(),
      resendOtpUseCase: getIt(),
    ),
  );
}
