import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home.dart';
import 'screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var login = prefs.getBool('login');
  print(login);
  runApp(
      MaterialApp(title: 'Nalabagam', home: login == true ? const Home() : Login()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nalabagam',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
