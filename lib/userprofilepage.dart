import 'dart:io';
import 'package:cuaca/webview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  final File? profileImage;
  String? nama;
  final String? email;
  String? alamat;

  UserProfilePage({
    Key? key,
    this.profileImage,
    this.nama,
    this.email,
    this.alamat,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? _newProfileImage;
  String? _loggedInUserEmail;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          _loggedInUserEmail = user.email;
          widget.nama = user.displayName;
          widget.alamat = 'Belum Diatur';
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

  void _editNama() {
    showDialog(
      context: context,
      builder: (context) {
        String newName = widget.nama ?? '';
        return AlertDialog(
          title: Text('Ubah Nama'),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
            controller: TextEditingController(text: widget.nama),
            decoration: InputDecoration(hintText: 'Masukkan nama baru'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                setState(() {
                  widget.nama = newName;
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

  void _editAlamat() {
    showDialog(
      context: context,
      builder: (context) {
        String newAlamat = widget.alamat ?? '';
        return AlertDialog(
          title: Text('Ubah Alamat'),
          content: TextField(
            onChanged: (value) {
              newAlamat = value;
            },
            controller: TextEditingController(text: widget.alamat),
            decoration: InputDecoration(hintText: 'Masukkan alamat baru'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                setState(() {
                  widget.alamat = newAlamat;
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

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Ambil Foto'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Pilih dari Galeri'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              // WebView option
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Dari Web'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomWebViewDialog()),
                  );
                },
              ),
            ],
          ),
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
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
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
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePickerOptions();
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
                    child: (_newProfileImage == null && widget.profileImage == null)
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
              _buildEditableInfo(
                label: 'Nama',
                value: widget.nama ?? 'Belum diatur',
                onTap: _editNama,
              ),
              _buildEditableInfo(
                label: 'Alamat',
                value: widget.alamat ?? 'Belum diatur',
                onTap: _editAlamat,
              ),
              ListTile(
                title: Text(
                  'Email: ${_loggedInUserEmail ?? 'Belum diatur'}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableInfo({required String label, required String value, required VoidCallback onTap}) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label: $value',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onTap,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}