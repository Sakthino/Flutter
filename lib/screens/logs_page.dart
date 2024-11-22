import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LogsPage());
}

class LogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Database Display',
      home: DatabaseDisplay(),
    );
  }
}

class DatabaseDisplay extends StatefulWidget {
  @override
  _DatabaseDisplayState createState() => _DatabaseDisplayState();
}

class _DatabaseDisplayState extends State<DatabaseDisplay> {
  // ignore: deprecated_member_use
  final DatabaseReference _database =
      // ignore: deprecated_member_use
      FirebaseDatabase.instance.reference().child('titles');
  String _databaseOutput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Database Display'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchDatabaseValues,
              child: Text('Fetch Database Values'),
            ),
            SizedBox(height: 20),
            Text(
              _databaseOutput,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchDatabaseValues() async {
    try {
      // Retrieving data from "/name" node
      DataSnapshot nameSnapshot = await _database.child('name').get();
      dynamic nameData = nameSnapshot.value;

      // Retrieving data from "/videos" node
      DataSnapshot videosSnapshot = await _database.child('videos').get();
      dynamic videosData = videosSnapshot.value;

      // Retrieving data from "/language" node
      DataSnapshot languageSnapshot = await _database.child('language').get();
      dynamic languageData = languageSnapshot.value;

      // Retrieving data from "/subscribed" node
      DataSnapshot subscribedSnapshot =
          await _database.child('subscribed').get();
      dynamic subscribedData = subscribedSnapshot.value;

      // Retrieving data from "/titles" node
      DataSnapshot titlesSnapshot =
          (await _database.child('titles').once()) as DataSnapshot;
      Map<dynamic, dynamic>? titlesData = titlesSnapshot.value as Map?;

      // Retrieving data from "/title_count" node
      DataSnapshot titleCountSnapshot =
          await _database.child('title_count').get();
      dynamic titleCountData = titleCountSnapshot.value;

      setState(() {
        _databaseOutput = 'Name: $nameData\n';
        _databaseOutput += 'Videos: $videosData\n';
        _databaseOutput += 'Language: $languageData\n';
        _databaseOutput += 'Subscribed: $subscribedData\n';
        _databaseOutput += 'Titles: ${titlesData.toString()}\n';
        _databaseOutput += 'Title Count: $titleCountData\n';
      });
    } catch (error) {
      setState(() {
        _databaseOutput = 'Error fetching data: $error';
      });
    }
  }
}
