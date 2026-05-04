import 'dart:typed_data';

import 'package:constellation/widgets/address_renderer.dart';
import 'package:constellation/widgets/constellation_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multicamera/multicamera.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  late final Camera frontCamera;
  late final Camera backCamera;
  late Position? geotag;
  bool frontCameraActive = false;
  late Uint8List? frontPhoto;
  late Uint8List? backPhoto;

  @override
  void initState() {
    super.initState();
    frontCamera = Camera(direction: CameraDirection.front);
    backCamera = Camera(direction: CameraDirection.back);
    geotag = null;
    backPhoto = null;
    frontPhoto = null;
    frontCamera.initialize();
    backCamera.initialize();
  }

  Future<void> takePhoto() async {
    final backPhotoData = await backCamera.captureImage();

    setState(() {
      backPhoto = backPhotoData;
    });

    if (frontCameraActive) {
      final frontPhotoData = await frontCamera.captureImage();

      setState(() {
        frontPhoto = frontPhotoData;
      });
    }
  }

  Future<void> enableGeotag() async {
    if (geotag != null) {
      setState(() {
        geotag = null;
      });

      return;
    }

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final currentPos = await Geolocator.getCurrentPosition();

    setState(() {
      geotag = currentPos;
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConstellationAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Stack(
            children: [
              Center(
                child: Builder(
                  builder: (context) {
                    if (backPhoto != null) {
                      if (backPhoto case final data?) {
                        return Image.memory(data);
                      }
                    }

                    return CameraPreview(camera: backCamera);
                  },
                ),
              ),
              Positioned(
                top: 16,
                right: 0,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Builder(
                    builder: (context) {
                      if (frontCameraActive) {
                        if (frontPhoto != null) {
                          if (frontPhoto case final data?) {
                            return Image.memory(data);
                          }
                        }
                  
                        return CameraPreview(camera: frontCamera);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Builder(
              builder: (context) {
                if (geotag != null) {
                  return AddressRenderer(
                    position: geotag!,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  );
                } else {
                  return Container();
                }
              },
            ),
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
                IconButton(onPressed: takePhoto, icon: Icon(Icons.camera)),
                IconButton(
                  onPressed: enableGeotag,
                  icon: geotag != null
                      ? Icon(Icons.location_on)
                      : Icon(Icons.location_off),
                ),
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
