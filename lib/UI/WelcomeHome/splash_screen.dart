import 'package:flutter/material.dart';
import '../WelcomeHome/welcome_screen.dart';
import '../Widgets/CustomAnimation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String fullText = "Welcome";
  String displayedText = "";
  int charIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration for smoother animation
    );

    // Fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Slide-in animation
    _slideAnimation = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Show the text letter by letter with a delay
    Future.doWhile(() async {
      if (charIndex < fullText.length) {
        setState(() {
          displayedText += fullText[charIndex];
        });
        charIndex++;
        await Future.delayed(const Duration(milliseconds: 300)); // Suitable delay between letters
        return true;
      } else {
        return false;
      }
    }).then((_) {
      // After the text is fully displayed, navigate to the next screen
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          CustomPageRoute(page: const WelcomeScreen()), // Navigate to the next screen
        );
      });
    });

    // Start animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black, // Black background for contrast
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade and Slide effect on text
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  displayedText,
                  style: const TextStyle(
                    fontSize: 60, // Large text size for emphasis
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white, // White text color
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60), // Space between text and logo
            // Circular avatar for the logo
            CircleAvatar(
              radius: 90, // Larger size for the logo
              backgroundColor: Colors.transparent, // Transparent background
              child: ClipOval(
                child: Image.asset(
                  'Asset/images/logo1.jpeg',
                  fit: BoxFit.cover, // Ensure the image fits perfectly
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
