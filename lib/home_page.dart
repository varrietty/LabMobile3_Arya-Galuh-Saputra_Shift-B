import 'package:flutter/material.dart';
import 'package:managmail/add_gmail_page.dart';
import 'package:managmail/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> gmailList = [];

  @override
  void initState() {
    super.initState();
    _loadGmail();
  }

  void _loadGmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? storedGmail = prefs.getStringList('gmail');

    setState(() {
      gmailList = storedGmail?.map((item) {
        final parts = item.split('|');
        return {
          'name': parts[0],
          'gmail': parts.length > 1 ? parts[1] : '',
          'password': parts.length > 2 ? parts[2] : '',
        };
      }).toList() ?? [];
    });
  }

  void _addGmail(Map<String, String> gmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    gmailList.add(gmail);
    await prefs.setStringList('gmail', gmailList.map((c) => '${c['name']}|${c['gmail']}|${c['password']}').toList());
    _loadGmail();
  }

  void _deleteGmail(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    gmailList.removeAt(index);
    await prefs.setStringList('gmail', gmailList.map((c) => '${c['name']}|${c['gmail']}|${c['password']}').toList());
    _loadGmail();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Gmail',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Semua daftar gmail Anda',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: gmailList.length,
                itemBuilder: (context, index) {
                  final gmail = gmailList[index];
                  return Card(
                    color: Colors.grey[100],
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 0,
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.brown),
                      title: Text(
                        gmail['name'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      subtitle: Text(
                        '${gmail['gmail'] ?? ''}${(gmail['password']?.isNotEmpty ?? false) ? '\n${gmail['password']}' : ''}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.brown),
                        onPressed: () => _deleteGmail(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const Sidemenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () async {
          final newGmail = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddGmailPage()),
          );
          if (newGmail != null) {
            _addGmail(newGmail);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}