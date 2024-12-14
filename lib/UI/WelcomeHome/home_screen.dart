import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../UserRegisterationHistory/login_screen.dart';
import '../Chatbot/pneumobot_screen.dart'; // Import Pneumobot screen
import '../ImageProcessUI/imageupload_screen.dart';
import '../UserRegisterationHistory/userhistory_screen.dart';
import '../Widgets/CustomAnimation.dart';
import '../UserRegisterationHistory/user_profile.dart'; // Import User Profile screen

class HomeScreen extends StatefulWidget {
  final bool fromLogin; // Add a flag to check navigation source

  const HomeScreen({super.key, required this.fromLogin}); // Constructor to pass flag

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Firebase sign-out function
  void signOutUser() async {
    try {
      // Check if a user is signed in
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed out successfully')),
        );
        // Navigate to the LoginScreen after successful sign-out
        Navigator.pushReplacement(
          context,
          CustomPageRoute(page: const LoginScreen()),
        );
      } else {
        // If no user is signed in, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user is signed in.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }


  void showLoginPrompt() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You need to login to access this feature.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,// Set the background color to black for the app bar
        actions: [
          // Always show the menu button, but restrict access functionality if not logged in
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFFF1F6F6)),
            onSelected: (value) {
              if (value == 'View Profile') {
                if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.push(
                    context,
                    CustomPageRoute(page: const UserProfileScreen()), // Navigate to User Profile screen
                  );
                } else {
                  showLoginPrompt();
                }
              } else if (value == 'Sign Out') {
                signOutUser();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'View Profile',
                  child: Text('View Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'Sign Out',
                  child: Text('Sign Out'),
                ),
              ];
            },
          ),
        ],
      ),
      backgroundColor: Colors.black, // Set the background to black
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Container(
              width: double.infinity,
              height: 440,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Asset/images/body.jpeg'), // Image path
                  fit: BoxFit.cover, // Cover entire container
                ),
              ),
            ),
          ),
          // Overlay content (Text and buttons)
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const Text(
                    'Pneumonia Detector',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: Color(0xFFE3F2FD),
                    ),
                  ),
                  const SizedBox(height: 250),
                  const Text(
                    'Detect Pneumonia in seconds',
                    style: TextStyle(
                      color: Color(0xFFE3F2FD),
                      fontFamily: 'Poppinsmedium',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Using advanced AI technology, we can help you detect pneumonia from chest X-ray images.',
                    style: TextStyle(
                      color: Color(0xFFE3F2FD),
                      fontFamily: 'Poppinsmedium',
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // Buttons inside a Column
                  Column(
                    children: [
                      SizedBox(
                        width: 300, // Make button width responsive
                        child: ElevatedButton.icon(
                          onPressed: () {
                              Navigator.push(
                                context,
                                CustomPageRoute(page: const UploadImageScreen()), // Navigate to UploadImageScreen
                              );

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D2962),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          ),
                          icon: const Icon(Icons.upload, color: Colors.white),
                          label: const Text(
                            'Upload Image',
                            style: TextStyle(
                              fontFamily: 'Poppinsregular',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 300, // Make button width responsive
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (FirebaseAuth.instance.currentUser == null) {
                              showLoginPrompt(); // Show login prompt if not logged in
                            } else {
                              Navigator.push(
                                context,
                                CustomPageRoute(page: const HistoryScreen()), // Navigate to History screen
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D2962),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          ),
                          icon: const Icon(Icons.history, color: Colors.white),
                          label: const Text(
                            'History',
                            style: TextStyle(
                              fontFamily: 'Poppinsregular',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(page: const LoginScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xE3F2FDFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.login,
                                    color: Color(0xFF0D2962),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Log in',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF0D2962),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CustomPageRoute(page: const ChatBotScreen()),
                              );
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xE3F2FDFF),
                              child: Image.asset(
                                'Asset/images/chatbot.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
