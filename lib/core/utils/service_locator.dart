import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/dio_consumer.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source_impl.dart';
import 'package:rental_hub/feature/auth/data/repo/login_repo_impl.dart';
import 'package:rental_hub/feature/auth/domain/repo/login_repo.dart';
import 'package:rental_hub/feature/auth/domain/usecases/login_use_case.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/login_cubit.dart';

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
}
