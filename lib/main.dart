import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

import 'package:explore/scrollbehaivori.dart';
import 'package:explore/web/screens/home_page.dart';
import 'package:explore/web/utils/authentication.dart';
import 'package:explore/web/utils/theme_data.dart';
import 'package:flutter/material.dart';

int cartC = 0;

void main() {
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
    setState(() {});
    print(uid);
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunpower',
      theme: lightThemeData,
      scrollBehavior: MyCustomScrollBehavior(),
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: HomePage(),
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
