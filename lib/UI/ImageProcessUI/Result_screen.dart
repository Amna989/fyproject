import 'package:flutter/material.dart';
import 'package:fyp/UI/FeedbackHelp/feedback_screen.dart';
import 'package:fyp/UI/Widgets/CustomAnimation.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF010713),
        elevation: 0,
        title: const Text(
          '',
        ),

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
          image: DecorationImage(
            image: AssetImage('Asset/images/welcome.jpg'), // Path to the image
            fit: BoxFit.cover, // Covers the entire screen
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox( height: 10,),
            const  SizedBox(
              child: Text(
                'Result',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  color: Color(0xFFE3F2FD),
                ),
              ),
              ),
             const SizedBox( height: 100,),
                SizedBox(
                width: 300,
                height: 200,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color:Color(0xE3F2FDFF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Result: Positive',
                        style: TextStyle(
                          fontFamily: 'PoppinsMedium',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Type: Viral Pneumonia',
                        style: TextStyle(
                          fontFamily: 'PoppinsMedium',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70),

              // Buttons with "Choose Another" styling
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Action for Generate Report
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xE3F2FDFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Generate Report',
                    style: TextStyle(
                      fontFamily: 'PoppinsMedium',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Spacing between buttons
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                            Navigator.push(
                            context,
                            CustomPageRoute(page:const  FeedbackScreen()), // Navigate to UserHistoryScreen
                              );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xE3F2FDFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Feedback',
                    style: TextStyle(
                      fontFamily: 'PoppinsMedium',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17,
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
