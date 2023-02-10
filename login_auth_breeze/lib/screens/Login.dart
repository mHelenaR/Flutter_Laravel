import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:login_auth_breeze/screens/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _loginKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: _validators,
                      controller: _loginController,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      validator: _validators,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: "Senha",
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _tryToLogin(context, "10.1.15.11");
                      },
                      child: Text("Login"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  String? _validators(value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  void _tryToLogin(BuildContext context, String hostServe) {
    void _showBar(BuildContext context, String text) {
      final snackBar = SnackBar(content: Text(text));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (_loginKey.currentState!.validate()) {
      _showBar(context, "Carregando...");
      var url = Uri.parse('http://$hostServe:8000/api/autenticate');
      http.post(url, body: {
        "email": _loginController.text,
        "password": _passwordController.text,
      }).then((value) {
        print(value.body);
        var response = jsonDecode(value.body);
        if (response['success'] && response['token'] != null) {
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('token', response['token']);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (builder) => Dashboard()));

            print('object');
          });
        } else {
          _showBar(context, "Usuário ou senha incorretos.");
        }
      });
    }
  }
}
