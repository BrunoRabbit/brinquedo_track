typedef SetString = Future<void> Function(String key, String value);
typedef GetString = Future<String?> Function(String key);

typedef SetInt = Future<void> Function(String key, int value);
typedef GetInt = Future<int?> Function(String key);

typedef RemoveKey = Future<void> Function(String key);

abstract class BaseLocalStorage {
  SetString get setString;

  GetString get getString;

  SetInt get setInt;

  GetInt get getInt;

  RemoveKey get removeKey;

  Future<void> clear();
}
