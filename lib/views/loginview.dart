import 'package:cuaca/accountcontroller.dart';
import 'package:cuaca/controllers/registercontroller.dart';
import 'package:flutter/material.dart';
import 'package:cuaca/controllers/logincontroller.dart';
import 'package:cuaca/views/registerview.dart';

class LoginPage extends StatelessWidget {
  AccountController accountController = AccountController();
 // RegisterController registerController = RegisterController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurpleAccent, Colors.white70],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => LoginController.login(
                  context,
                  _emailController.text,
                  _passwordController.text,
                ),
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  RegisterController registerController = RegisterController(accountController);
                  // Create an instance of RegisterController
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage(registerController)),
                  );
                },
                child: Text('Belum punya akun? Daftar di sini'),
              ),
              SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
