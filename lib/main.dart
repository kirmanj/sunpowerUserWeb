import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/localization/AppLocal.dart';

import 'package:explore/scrollbehaivori.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/kurdish_material_localization.dart';
import 'services/local_storage_service.dart';
import 'services/settings_service_provider.dart';

int cartC = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.instance.init();
  if (LocalStorageService.instance.languageCode == null) {
    LocalStorageService.instance.languageCode = "en";
  }
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    await getUser();
    setState(() {
      uid = '';
    });
    print(uid);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (BuildContext context) {
        return SettingsServiceProvider();
      },
      child: Consumer<SettingsServiceProvider>(
        builder: (context,settings,child){
          return MaterialApp(
            title: 'Sunpower',
            theme: lightThemeData,
            scrollBehavior: MyCustomScrollBehavior(),
            darkTheme: darkThemeData,
            debugShowCheckedModeBanner: false,
            themeMode: EasyDynamicTheme.of(context).themeMode,
            home: HomePage(),
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              KurdishMaterialLocalizations.delegate,
              KurdishCupertinoLocalization.delegate,
            ],
            supportedLocales: Lang.values.map(
              (e) => Locale(e),
            ),
            builder: (context, child) {
              if (AppLocalizations.of(context).locale.languageCode == "ku") {
                child = Directionality(
                    textDirection: TextDirection.rtl, child: child!);
              }
              return child!;
            },
            locale: Locale(LocalStorageService.instance.languageCode!),
          );
        },
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SunPower',
//       theme: ThemeData(
//         highlightColor: Color.fromRGBO(230, 110, 43, 1),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
