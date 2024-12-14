import 'package:flutter/material.dart';
import '../Widgets/CustomAnimation.dart';
import'../WelcomeHome/home_screen.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,  // Ensures that the keyboard does not overlap the content
      appBar: AppBar(
        backgroundColor: const Color(0xFF010713),
        elevation: 0,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF010713),
              Color(0xFF0D2962),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,  // Aligns content from top
            children: [

              const Text(
                'Feedback',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  color: Color(0xFFE3F2FD),
                ),
              ),
              const SizedBox(height: 40),

              // Email TextField with customized styling
              SizedBox(
                width: 300,
                child: TextField(
                  style: const TextStyle(color: Color(0xFFB0BEC5)),  // Set color for entered text
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email, color: Color(0xFFB0BEC5)),
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(color: Color(0xFFB0BEC5)),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Comments/Suggestions TextField with customized styling
              SizedBox(
                width: 300,
                height: 300,
                child: TextField(
                  maxLines: 8, // Increased height by adding more lines
                  style: const TextStyle(color: Color(0xFFB0BEC5)),
                  decoration: InputDecoration(
                    hintText: 'Comments/Suggestions',
                    hintStyle: const TextStyle(color: Color(0xFFB0BEC5)),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Submit Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Action for submit button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xE3F2FDFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Poppinsmedium',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(page: const  HomeScreen(fromLogin: false)), // Navigate to UserHistoryScreen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xE3F2FDFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: 'PoppinsMedium',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
