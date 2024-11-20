import 'package:get_it/get_it.dart';

import '../features/home/data/datasource/remote/home_remote_datasource.dart';
import '../features/home/data/datasource/remote/home_remote_datasource_impl.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/use_cases/home_use_case.dart';
import '../shared/local/secure_storage/secure_storage.dart';
import '../shared/local/secure_storage/secure_storage_impl.dart';
import '../shared/network/dio_network_service.dart';
import '../shared/network/network_service.dart';

final injector = GetIt.instance;

Future<void> initSingletons() async {
  //Services
  // injector.registerLazySingleton<LocalDb>(() => InitDbImpl());
  injector.registerLazySingleton<NetworkService>(() => DioNetworkService());
  injector.registerLazySingleton<SecureStorage>(
      () => SecureStorageImplementation());

  //initiating db
  // await injector<LocalDb>().initDb();
}

void provideDataSources() {
  injector.registerFactory<HomeRemoteDataSource>(() =>
      HomeRemoteDataSourceImpl(networkService: injector.get<NetworkService>()));
}

void provideRepositories() {
  injector.registerFactory<HomeRepository>(() => HomeRepositoryImpl(
      homeRemoteDataSource: injector.get<HomeRemoteDataSource>()));
}

void provideUseCases() {
  injector.registerFactory<HomeUseCase>(
      () => HomeUseCase(homeRepository: injector.get<HomeRepository>()));
}
