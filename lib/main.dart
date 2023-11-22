import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/bloc_observer.dart';
import 'app/my_app.dart';
import 'app/resources/language_manager.dart';
import 'app/services/dio_helper/egypt_dio_helper.dart';
import 'app/services/dio_helper/saudi_dio_helper.dart';
import 'app/services/shared_prefrences/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SaudiDioHelper.init();
  EgyptDioHelper.init();
  await CacheHelper.init();
  Bloc.observer = AppBlocObserver();
  // await DBHelper.instance.createDataBase();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        ARABIC_LOCAL,
        ENGLISH_LOCAL,
      ],
      path: asstesLocalePath,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
