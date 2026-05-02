import 'package:camera/camera.dart';
import 'package:constellation/screens/new_image_post_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
final cameras = await availableCameras();

  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ConstellationApp(cameras: cameras),
    ),
  );
}

class ConstellationApp extends StatelessWidget {
  const ConstellationApp({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  void handleNewPostPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewImagePostScreen(cameras: cameras)),
    );
  }

  void handleFriendsPressed() {
    print("Test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                IconButton(
                  onPressed: () => handleNewPostPressed(context),
                  icon: Icon(Icons.add),
                ),
                Spacer(),
                IconButton(
                  onPressed: handleFriendsPressed,
                  icon: Icon(Icons.people),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
