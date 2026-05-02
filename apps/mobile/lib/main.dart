import 'package:constellation/screens/new_image_post_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConstellationApp(),
    ),
  );
}

class ConstellationApp extends StatelessWidget {
  const ConstellationApp({super.key});

  void handleNewPostPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewImagePostScreen()),
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
