/// https://github.com/Ephenodrom/Flutter-Global-Config/blob/master/lib/global_configuration.dart

enum Env { MOCK, DEV, PROD }

class Config {
  static const env = 'env';
  static const appName = 'appName';
  static const baseUrl = 'baseUrl';

  static Config _singleton = Config._internal();

  factory Config() => _singleton;

  Config._internal();

  Map<String, dynamic> _appConfig = Map<String, dynamic>();

  Config loadFromMap(Map<String, dynamic> map) {
    _appConfig.addAll(map);
    return _singleton;
  }

  /// Reads a value of any type
  dynamic get(String key) => _appConfig[key];

  /// Reads a value of bool, throw exception if its not bool.
  bool getBool(String key) => _appConfig[key];

  /// Reads a value of int, throw exception if its not int.
  int getInt(String key) => _appConfig[key];

  /// Reads a value of double, throw exception if its not double.
  double getDouble(String key) => _appConfig[key];

  /// Reads a value of string, throw exception if its not string.
  String getString(String key) => _appConfig[key];

  // Write a value, throw exception if it's not the correct type
  void set(key, value) => value.runtimeType != _appConfig[key].runtimeType ? throw('Wrong typing') : _appConfig.update(key, (dynamic) => value);

  /// Add any type of map.
  add(Map<String, dynamic> map) => _appConfig.addAll(map);
}