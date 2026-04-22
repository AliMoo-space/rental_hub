import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// ================= CORE =================
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/dio_consumer.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';

// ================= DATA SOURCES =================
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source_impl.dart';

import 'package:rental_hub/feature/auth/data/datasource/forgot_password_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/forgot_password_remote_data_source_impl.dart';

import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source_imp.dart';

// ================= REPOSITORIES =================
import 'package:rental_hub/feature/auth/domain/repo/login_repo.dart';
import 'package:rental_hub/feature/auth/data/repo/login_repo_impl.dart';

import 'package:rental_hub/feature/auth/domain/repo/forgot_password_repo.dart';
import 'package:rental_hub/feature/auth/data/repo/forgot_password_repo_impl.dart';

import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';
import 'package:rental_hub/feature/auth/data/repo/validate_otp_entity_imp.dart';

// ================= USE CASES =================
import 'package:rental_hub/feature/auth/domain/usecases/login_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/validate_otp_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/resend_otp_use_case.dart';

// ================= CUBITS =================
import 'package:rental_hub/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/otp_cubit.dart';
import 'package:rental_hub/feature/localization/data/repo/locale_repository_impl.dart';
import 'package:rental_hub/feature/localization/domain/repo/locale_repository.dart';
import 'package:rental_hub/feature/localization/domain/usecases/get_saved_locale_use_case.dart';
import 'package:rental_hub/feature/localization/domain/usecases/save_locale_use_case.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ================= INIT =================
  await CacheHelper.init();

  // ================= CORE =================
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));

  // =========================================================
  // ===================== LOCALIZATION =======================
  // =========================================================

  getIt.registerLazySingleton<LocaleRepository>(
    () => LocaleRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetSavedLocaleUseCase(getIt()));

  getIt.registerLazySingleton(() => SaveLocaleUseCase(getIt()));

  getIt.registerLazySingleton(() => LocaleCubit(getIt(), getIt()));

  // =========================================================
  // ======================= LOGIN ============================
  // =========================================================

  /// Data Source
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(apiConsumer: getIt(), cacheHelper: getIt()),
  );

  /// Repository
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(getIt()));

  /// Use Case
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));

  /// Cubit
  getIt.registerFactory(() => LoginCubit(getIt()));

  // =========================================================
  // ================== FORGOT PASSWORD =======================
  // =========================================================

  /// Data Source
  getIt.registerLazySingleton<ForgotPasswordRemoteDataSource>(
    () => ForgotPasswordRemoteDataSourceImpl(apiConsumer: getIt()),
  );

  /// Repository
  getIt.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordRepoImpl(getIt()),
  );

  /// Use Case
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));

  /// Cubit
  getIt.registerFactory(() => ForgotPasswordCubit(getIt()));

  // =========================================================
  // ========================= OTP ============================
  // =========================================================

  /// Data Source
  getIt.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSourceImpl(apiConsumer: getIt()),
  );

  /// Repository
  getIt.registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(getIt()));

  /// Use Cases
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt()));

  getIt.registerLazySingleton(() => ResendOtpUseCase(getIt()));

  /// Cubit (with parameter)
  getIt.registerFactoryParam<OtpCubit, String, void>(
    (email, _) => OtpCubit(
      email: email,
      verifyOtpUseCase: getIt(),
      resendOtpUseCase: getIt(),
    ),
  );
}
