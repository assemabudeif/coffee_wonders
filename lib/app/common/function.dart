import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../resources/language_manager.dart';
import '../services/shared_prefrences/cache_helper.dart';

class SharedFunction {
  static void changeLanguage(context) {
    changeAppLanguage();
    Phoenix.rebirth(context);
  }

  static void changeAppMode(context) {
    if (CacheHelper.getData(key: SharedKey.isDark)== true) {
      CacheHelper.setData(key: SharedKey.isDark, value: false);
    } else {
      CacheHelper.setData(key: SharedKey.isDark, value: true);
    }
    Phoenix.rebirth(context);
  }
}
