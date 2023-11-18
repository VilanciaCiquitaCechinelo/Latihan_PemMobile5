import 'dart:io';
import 'package:cuaca/webview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  final File? profileImage;
  String? nama;
  final String? email;

  UserProfilePage({Key? key, this.profileImage, this.nama = 'Vilancia Ciquita Cechinelo', this.email = 'ochin@gmail.com'})
      : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? _newProfileImage;
  String? _loggedInUserEmail;
  TextEditingController _namaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
    _namaController.text = widget.nama ?? '';
  }

  Future<void> _getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          _loggedInUserEmail = user.email;
        });
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _newProfileImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _showWebViewDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => CustomWebViewDialog(),
    );
  }

  void _editNama() {
    _namaController.text = widget.nama ?? '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ubah Nama'),
          content: TextField(
            controller: _namaController,
            decoration: InputDecoration(hintText: 'Masukkan nama baru'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                setState(() {
                  widget.nama = _namaController.text;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata Pengguna'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editNama,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurpleAccent, Colors.white70],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Pilih Sumber Gambar'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Galeri'),
                            onTap: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Kamera'),
                            onTap: () {
                              _pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.web),
                            title: Text('Dari Web'),
                            onTap: () {
                              Navigator.pop(context);
                              _showWebViewDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _newProfileImage != null
                        ? FileImage(_newProfileImage!)
                        : (widget.profileImage != null
                        ? FileImage(widget.profileImage!)
                        : null),
                    child: (_newProfileImage == null &&
                        widget.profileImage == null)
                        ? Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.deepPurpleAccent,
                    )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Biodata Pengguna
              Text(
                'Nama: ${widget.nama ?? 'Vilancia Ciquita Cechinelo'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Email: ${_loggedInUserEmail ?? 'ochin@gmail.com'}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}