import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen(this.camera);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool isDetecting = false;
  List<dynamic>? _recognitions;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    loadModel();
  }

  @override
  void dispose() {
    _controller.dispose();
    Tflite.close();
    super.dispose();
  }

  void _initializeCamera() async {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
    _controller.startImageStream((CameraImage image) {
      if (!isDetecting) {
        isDetecting = true;
        detectObjects(image);
      }
    });
  }

  void loadModel() async {
    await Tflite.loadModel(
      model: 'assets/yolov5s.tflite',
      labels: 'assets/coco_labels.txt',
    );
  }

  void detectObjects(CameraImage image) async {
    if (image.format.group == ImageFormatGroup.yuv420) {
      var recognitions = await Tflite.detectObjectOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        model: "YOLO",
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 0,
        imageStd: 255,
        numResultsPerClass: 1,
        threshold: 0.4,
      );

      setState(() {
        _recognitions = recognitions;
      });

      isDetecting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Detection'),
      ),
      body: Stack(
        children: [
          CameraPreview(_controller),
          _buildResults(),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_recognitions == null || _recognitions!.isEmpty) {
      return Container();
    }
    return Positioned(
      top: 20.0,
      left: 20.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _recognitions!.map<Widget>((res) {
          return Text(
            "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList(),
      ),
    );
  }
}