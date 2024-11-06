import 'package:flutter/material.dart';
import 'package:p3l_mobile/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? message = '';

  Future<void> _login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Username dan password harus diisi';
      });
      return;
    }

    // Panggil fungsi login dari API
    final result = await login(username, password);

    if (result['status']) {
      setState(() {
        message = 'Login berhasil! Token: ${result['token']}';
      });
      // Di sini, Anda bisa mengarahkan pengguna ke halaman lain setelah login berhasil
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        message = result['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            Text(
              message ?? '',
              style: TextStyle(
                  color:
                      message == 'Login berhasil!' ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
