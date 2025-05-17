import 'package:brinquedo_track/storage/base_local_storage.dart';
import 'package:brinquedo_track/storage/secure_storage_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage implements SecureStorageInterface {
  final FlutterSecureStorage secureStorage;

  const SecureStorage({
    required this.secureStorage,
  });

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  // TODO: implement getInt
  GetInt get getInt => throw UnimplementedError();

  @override
  GetString get getString => (key) async => secureStorage.read(key: key);

  @override
  RemoveKey get removeKey => (key) => secureStorage.delete(key: key);

  @override
  // TODO: implement setInt
  SetInt get setInt => throw UnimplementedError();

  @override
  SetString get setString =>
      (key, value) async => secureStorage.write(key: key, value: value);
}
