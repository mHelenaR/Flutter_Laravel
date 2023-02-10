import 'package:flutter/material.dart';
import 'package:login_auth_breeze/screens/Dashboard.dart';
import 'package:login_auth_breeze/screens/Login.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// [php artisan serve --host=10.1.15.11 --port=8000]
///
/// Comando para alterar o servidor do laravel;
/// Coloque o mesmo IP no arquivo [vite.config.js];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isLoggedIn = false;

  // Loga direto na conta do usuario
  SharedPreferences.getInstance().then((prefs) {
    if (prefs.get('token') != null) {
      isLoggedIn = true;
    }
    runApp(MyApp(isLoggedIn));
  });
  runApp(MyApp(isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Flutter',
      home: !isLoggedIn ? LoginScreen() : Dashboard(),
    );
  }
}
