import 'package:cuaca/models/registermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController {
  final AuthModel _authModel = AuthModel();

  Future<void> register(
      String email,
      String password,
      BuildContext context,
      ) async {
    User? registeredUser = await _authModel.registerUser(email, password);
    if (registeredUser != null) {
      print('Registrasi berhasil: ${registeredUser.email}');
      Navigator.pop(context); // Kembali ke halaman login
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registrasi Gagal'),
            content: Text('Terjadi kesalahan saat mendaftar.'),
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