import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String AccessToken = "access_token";
  static const String AppLanguageKey = "app_lang";

  static final LocalStorageService _instance = LocalStorageService._internal();
  static late SharedPreferences _preferences;

  static LocalStorageService get instance => _instance;
  LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Access Token
  String get accessToken => _getFromDisk(AccessToken);

  set accessToken(String value) => _saveToDisk(AccessToken, value);

// Language Code
  String? _languageCode;
  String? get languageCode => _languageCode ?? _getFromDisk(AppLanguageKey);

  set languageCode(String? value) {
    _languageCode = value;
    _saveToDisk(AppLanguageKey, value);
  }


  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value == "" ? null : value;
  }

  void _saveToDisk<T>(String key, content) {
    if(content == null){
      _preferences.remove(key);
    }
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
