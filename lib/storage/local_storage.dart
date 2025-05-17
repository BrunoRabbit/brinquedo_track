import 'package:brinquedo_track/storage/base_local_storage.dart';
import 'package:brinquedo_track/storage/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements LocalStorageInterface {
  final SharedPreferences preferences;

  const LocalStorage({
    required this.preferences,
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
  GetString get getString => (key) async => preferences.getString(key);

  @override
  // TODO: implement removeKey
  RemoveKey get removeKey => (key) async => preferences.remove(key);

  @override
  // TODO: implement setInt
  SetInt get setInt => throw UnimplementedError();

  @override
  SetString get setString => (key, value) async => preferences.setString(key, value);
}
