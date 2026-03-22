import 'package:get_it/get_it.dart';
import 'package:rental_hub/core/networking/dio_helper.dart';
import 'package:rental_hub/core/utils/storage_helper.dart';

final getIt = GetIt.instance;
void setupServiseLocator() {
  //Dio Helper
  getIt.registerSingleton<DioHelper>(DioHelper());

  //Storage Helper
  getIt.registerLazySingleton(() => StorageHelper());

  //Repos
  // getIt.registerLazySingleton(
  //   () => AuthRepo(getIt()),
  // );
  // getIt.registerLazySingleton(
  //   () => HomeRepo(getIt()),
  // );
  // getIt.registerLazySingleton(
  //   () => AddProductRepo(getIt()),
  // );
  // getIt.registerLazySingleton(
  //   () => CartRepo(getIt()),
  // );

  //Cubit
  // getIt.registerFactory(
  //   () => AuthCubit(getIt()),
  // );
  // getIt.registerFactory(
  //   () => CategoryCubit(getIt()),
  // );
  // getIt.registerFactory(
  //   () => ProductCubit(getIt()),
  // );
  // getIt.registerFactory(
  //   () => AddProductCubit(getIt()),
  // );
  // getIt.registerFactory(
  //   () => CartCubit(getIt()),
  // );
}
