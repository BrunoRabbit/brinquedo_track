import 'package:brinquedo_track/injector/base_injector.dart';
import 'package:brinquedo_track/storage/local_storage.dart';
import 'package:brinquedo_track/storage/local_storage_interface.dart';
import 'package:brinquedo_track/storage/secure_storage.dart';
import 'package:brinquedo_track/storage/secure_storage_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageInjector implements BaseInjector {
  const StorageInjector();

  @override
  Future<void> inject() async {
    final getIt = GetIt.instance;

    final preferences = await SharedPreferences.getInstance();

    GetIt.instance
      ..registerFactory<SharedPreferences>(
        () => preferences,
      )
      ..registerFactory<FlutterSecureStorage>(
        () => const FlutterSecureStorage(),
      )
      ..registerFactory<SecureStorageInterface>(
        () => SecureStorage(
          secureStorage: getIt.get(),
        ),
      )
      ..registerFactory<LocalStorageInterface>(
        () => LocalStorage(
          preferences: getIt.get(),
        ),
      );
  }
}
