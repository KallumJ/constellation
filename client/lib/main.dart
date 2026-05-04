import 'package:constellation/screens/new_post_screen.dart';
import 'package:constellation/widgets/constellation_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: ConstellationApp(),
      title: "Constellation",
    ),
  );
}

class ConstellationApp extends StatelessWidget {
  const ConstellationApp({super.key});

  void handleNewPostPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPostScreen()),
    );
  }

  void handleFriendsPressed() {
    print("Test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ConstellationAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "New Post"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Friends"),
        ],
        onTap: (index) {
          if (index == 0) {
            handleNewPostPressed(context);
          } else if (index == 1) {
            handleFriendsPressed();
          }
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Text(
              "Imagine there was posts here lol",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
