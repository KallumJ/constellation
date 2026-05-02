import 'package:flutter/material.dart';
import 'package:multicamera/multicamera.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  late final Camera frontCamera;
  late final Camera backCamera;
  bool frontCameraActive = false;

  @override
  void initState() {
    super.initState();
    frontCamera = Camera(direction: CameraDirection.front);
    backCamera = Camera(direction: CameraDirection.back);
    frontCamera.initialize();
    backCamera.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Stack(
            children: [
              Center(child: CameraPreview(camera: backCamera)),
              Positioned(
                top: 16,
                right: 0,
                child: Builder(
                  builder: (context) {
                    if (frontCameraActive) {
                      return SizedBox(
                        width: 150,
                        height: 150,
                        child: CameraPreview(camera: frontCamera)
                        );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      frontCameraActive = !frontCameraActive;
                    });
                  },
                  icon: frontCameraActive
                      ? Icon(Icons.collections)
                      : Icon(Icons.filter),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.camera)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    frontCamera.dispose();
    backCamera.dispose();
    super.dispose();
  }
}
