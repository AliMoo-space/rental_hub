import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/dio_consumer.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/feature/auth/data/datasource/forgot_password_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/forgot_password_remote_data_source_impl.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source_impl.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source_imp.dart';
import 'package:rental_hub/feature/auth/data/repo/forgot_password_repo_impl.dart';
import 'package:rental_hub/feature/auth/data/repo/login_repo_impl.dart';
import 'package:rental_hub/feature/auth/data/repo/validate_otp_entity_imp.dart';
import 'package:rental_hub/feature/auth/domain/repo/forgot_password_repo.dart';
import 'package:rental_hub/feature/auth/domain/repo/login_repo.dart';
import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';
import 'package:rental_hub/feature/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/login_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/validate_otp_use_case.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/otp_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await CacheHelper.init();

  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: Dio()));

  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(apiConsumer: getIt(), cacheHelper: getIt()),
  );
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(getIt()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<ForgotPasswordRemoteDataSource>(
    () => ForgotPasswordRemoteDataSourceImpl(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordRepoImpl(getIt()),
  );
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));
  getIt.registerFactory(() => ForgotPasswordCubit(getIt()));

  getIt.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSourceImpl(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(getIt()));
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt()));
  getIt.registerLazySingleton(() => ResendOtpUseCase(getIt()));
  getIt.registerFactoryParam<OtpCubit, String, void>(
    (email, _) => OtpCubit(
      email: email,
      verifyOtpUseCase: getIt(),
      resendOtpUseCase: getIt(),
    ),
  );
}
