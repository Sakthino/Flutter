import 'package:firebase_database/firebase_database.dart';

class LogsService {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  Future<void> addLog(String log) async {
    try {
      final int timestamp = DateTime.now().millisecondsSinceEpoch;
      await _database
          .child('logs')
          .push()
          .set({'log': log, 'timestamp': timestamp});
    } catch (e) {
      print('Error adding log: $e');
    }
  }
}
