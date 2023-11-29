// register_controller.dart
import 'package:cuaca/accountcontroller.dart';
import 'package:cuaca/models/registermodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController {
  final AccountController _accountController;
  final AuthModel _authModel = AuthModel();

  RegisterController(this._accountController);

  Future<void> register(
      String email,
      String password,
      String name,
      BuildContext context,
      ) async {
    User? registeredUser = await _authModel.registerUser(email, password);

    if (registeredUser != null) {
      print('Registration successful: ${registeredUser.email}');

      // Create account in Appwrite
      try {
        await _accountController.createAccount({
          'email': email,
          'password': password,
          'name': name,
          // Add other fields as necessary for Appwrite account creation
        });
        print('Appwrite account created successfully.');
      } catch (error) {
        print('Error creating Appwrite account: $error');
        // Handle Appwrite account creation errors
      }

      Navigator.pop(context); // Navigate back to the login page
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('An error occurred during registration.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}