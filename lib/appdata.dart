
import 'package:quizflip/inout.dart';

int version = 202401251632;


final Map<String, dynamic> defaultAppdata = {
  'version'   : version,
  'theme'     : 'RED',
  'themeMode' : 'SYSTEM',
};

Map<String, dynamic> _appdata = {};
Map<String, dynamic> get appdata => _appdata;
set appdata(Map<String, dynamic> data) {
  // TODO: App version check.
  try {
    _appdata = {
      'version'   : data['version']   ?? defaultAppdata['version'],
      'theme'     : data['theme']     ?? defaultAppdata['theme'],
      'themeMode' : data['themeMode'] ?? defaultAppdata['themeMode'],
    };
  } catch (e) {
    _appdata = Map.from(defaultAppdata);
  }
  saveAppdata();
}// set appdata