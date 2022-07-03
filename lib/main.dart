import 'package:flutter/material.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

final lightTheme = ThemeData(
  fontFamily: 'Lato',
  textTheme: const TextTheme(
    headline5: TextStyle(fontSize: 24),
  ),
);

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Lato',
    textTheme: const TextTheme(
      headline5: TextStyle(fontSize: 24),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // for iOS, you have to set the string of the CFBundleName key in Info.plist
      title: 'Flutter UI Widgets',
      theme: lightTheme.copyWith(
        colorScheme: lightTheme.colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.green[600],
        ),
      ),
      darkTheme: darkTheme,
      home: const MainPage(),
    );
  }
}
