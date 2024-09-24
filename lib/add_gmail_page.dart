import 'package:flutter/material.dart';

class AddGmailPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _showInput(controller, placeholder, isPassword, icon) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: placeholder,
        prefixIcon: Icon(icon, color: Colors.brown),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Gmail',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 40),
            _showInput(
              _nameController,
              'Nama Akun Gmail',
              false,
              Icons.person,
            ),
            const SizedBox(height: 20),
            _showInput(
              _gmailController,
              'Gmail',
              false,
              Icons.email,
            ),
            const SizedBox(height: 20),
            _showInput(
              _passwordController,
              'Password',
              false,
              Icons.lock,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_nameController.text.isNotEmpty && _gmailController.text.isNotEmpty) {
                    final newGmail = {
                      'name': _nameController.text,
                      'gmail': _gmailController.text,
                      'password': _passwordController.text,
                    };
                    Navigator.pop(context, newGmail);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
