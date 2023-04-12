import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/localization/AppLocal.dart';

import 'package:explore/scrollbehaivori.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/kurdish_material_localization.dart';
import 'services/local_storage_service.dart';
import 'services/settings_service_provider.dart';

int cartC = 0;
int role = 0;

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
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (BuildContext context) {
        return SettingsServiceProvider();
      },
      child: Consumer<SettingsServiceProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'HL SUNGLASS',
            theme: lightThemeData,
            scrollBehavior: MyCustomScrollBehavior(),
            darkTheme: darkThemeData,
            debugShowCheckedModeBanner: false,
            themeMode: EasyDynamicTheme.of(context).themeMode,
            home: FutureBuilder(
                future: _fApp,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.hasError);
                    return Container(
                      child: Center(
                        child: Text(snapshot.hasError.toString()),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return HomePage();
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
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
