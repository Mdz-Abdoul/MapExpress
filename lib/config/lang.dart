import 'package:flutter/material.dart';

class LangProvider with ChangeNotifier {
   String _lang ='fr';
   String _currentLang = 'fr';

  String getCurrentLang() {
    return _currentLang;
  }
  String? get language => _lang;
  void setLang(String lang) {
    _lang = lang;
    _currentLang = lang;
    notifyListeners();
  }
}

// class LangProvider extends ChangeNotifier {
//   String _currentLang = 'fr';

//   String getCurrentLang() {
//     return _currentLang;
//   }

//   void setLang(String lang) {
//     _currentLang = lang;
//     notifyListeners();
//   }
// }
