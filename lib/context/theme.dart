import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends ChangeNotifier {
  bool _dark = false;
  String _mapStyle = 'google_bright';
  late SharedPreferences _prefs;

  bool get dark => _dark;
  String get mapStyle => _mapStyle;

  ThemeModel() {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _dark = _prefs.getBool('dark') ?? false;
    _mapStyle = _prefs.getString('MAP_STYLE') ?? 'google_bright'; // Cargar estilo de mapa
    notifyListeners();
  }

  void toggleTheme() {
    _dark = !_dark;
    _prefs.setBool('dark', _dark);
    notifyListeners();
  }

  void updateMapStyle(String style) {
    _mapStyle = style;
    notifyListeners();
  }

  Future<void> setMapStyle(String style) async {
    _mapStyle = style;
    await _prefs.setString('MAP_STYLE', style);
    notifyListeners();
  }
}
