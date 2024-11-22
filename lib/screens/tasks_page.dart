import 'package:camera/camera.dart'; // Import camera package
import 'package:flutter/material.dart';

import 'camera_screen.dart'; // Import the CameraScreen

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _openCamera(context); // Call function to open camera
        },
        child: Text('Start Task'),
      ),
    );
  }

  void _openCamera(BuildContext context) async {
    try {
      // Retrieve the list of available cameras
      final cameras = await availableCameras();

      // Open the first available camera
      final camera = cameras.first;

      // Navigate to the camera screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen(camera)),
      );
    } catch (e) {
      print('Error opening camera: $e');
    }
  }
}
