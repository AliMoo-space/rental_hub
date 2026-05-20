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
import 'package:rental_hub/feature/subscription/presentation/cubit/subscription_cubit.dart';
import 'package:rental_hub/feature/product_details/data/datasource/product_details_remote_data_source.dart';
import 'package:rental_hub/feature/product_details/data/repo/product_details_repo_impl.dart';
import 'package:rental_hub/feature/product_details/domain/repo/product_details_repo.dart';
import 'package:rental_hub/feature/product_details/domain/usecases/product_details_use_case.dart';
import 'package:rental_hub/feature/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:rental_hub/feature/theme/presentation/cubit/theme_cubit.dart';
import 'package:rental_hub/feature/ai_chat/data/datasource/ai_remote_data_source.dart';
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
import 'package:rental_hub/feature/home/presentation/cubit/category_cubit.dart';
import 'package:rental_hub/feature/home/presentation/cubit/product_cubit.dart';

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

  // ======================= USE CASES ========================

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => ResendOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCategory(categoryRepo: getIt()));
  getIt.registerLazySingleton(() => GetProducts(productRepo: getIt()));
  getIt.registerLazySingleton(
    () => AddToFavoriteUseCase(favoriteRepo: getIt()),
  );
  getIt.registerLazySingleton(
    () => RemoveFavoriteUseCase(favoriteRepo: getIt()),
  );

  getIt.registerLazySingleton(() => GetSubscriptionsUseCase(getIt()));
  getIt.registerLazySingleton(() => ProductDetailsUseCase(getIt()));

  // ======================= AI CHAT ========================
  getIt.registerLazySingleton<AiRemoteDataSource>(
    () => AiRemoteDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<AiChatRepo>(() => AiChatRepoImpl(getIt()));

  getIt.registerLazySingleton(() => SendMessageUseCase(getIt()));

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
  getIt.registerFactory(() => SubscriptionCubit(getIt()));
  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(getIt()),
  );
  getIt.registerFactory(() => AiChatCubit(getIt()));
  getIt.registerFactoryParam<OtpCubit, String, void>(
    (email, _) => OtpCubit(
      email: email,
      verifyOtpUseCase: getIt(),
      resendOtpUseCase: getIt(),
    ),
  );
}
