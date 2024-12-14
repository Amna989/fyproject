import 'package:flutter/material.dart';
import 'package:fyp/UI/ImageProcessUI/Result_screen.dart';
import 'package:fyp/UI/Widgets/CustomAnimation.dart';

class SelectedImageScreen extends StatelessWidget {
  const SelectedImageScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const  SizedBox(
                  child: Text(
                    'Selected Image ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: Color(0xFFE3F2FD),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: 320,
                  height: 270,
                  decoration: BoxDecoration(
                    color: Color(0xE3F2FDFF),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Selected Image Appears Here',
                      style: TextStyle(
                        fontFamily: 'Poppinsregular',
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),

                // Styled "Done" Button
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                       CustomPageRoute(page: const  ResultScreen()), // Navigate to UserHistoryScreen
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
                      'Done',
                      style: TextStyle(
                        fontFamily: 'PoppinsMedium',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Styled "Choose Another" Button
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Placeholder action for "Choose Another"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xE3F2FDFF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Choose Another',
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
      ),
    );
  }
}
