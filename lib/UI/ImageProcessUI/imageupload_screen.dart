import 'package:flutter/material.dart';
import 'package:fyp/UI/FeedbackHelp/help_screen.dart';
import 'package:fyp/UI/ImageProcessUI/selectedimage_screen.dart';
import 'package:fyp/UI/Widgets/CustomAnimation.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontFamily: 'Poppins',),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color:Colors.white), // Back button
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
         height:double.infinity,
         width: double.infinity,// Set background to black
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Background image section
              const SizedBox(
                width: 300,
                height: 80,
                child: Text(
                  'Upload X-ray Image',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight:FontWeight.bold,
                      fontFamily: 'Poppins'
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          
              SizedBox(
                height: 300, // 30% of screen height
                child: Image.asset(
                  'Asset/images/lungs.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
          
          
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 100,
                    child: Text(
                      'To get started, upload an existing image of the chest X-ray. ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Buttons
              Column(
                children: [
          
          
          
                  // "Upload from Gallery" Button
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRoute( page:const SelectedImageScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Upload from Gallery',
                        style: TextStyle(
                          fontFamily: 'PoppinsMedium',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // "Help" Button
                  SizedBox(
          
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                            context,
                           CustomPageRoute(page: const HelpScreen()),
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Help',
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
            ],
          ),
        ),
      ),
    );
  }
}
