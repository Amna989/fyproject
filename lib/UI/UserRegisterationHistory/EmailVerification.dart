import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/UI/WelcomeHome/home_screen.dart';
import '../Service/Database.dart';
import'../Widgets/CustomAnimation.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final String uid;

  const EmailVerificationScreen({Key? key, required this.email, required this.uid}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isVerified = false;
  bool isChecking = true;
  bool emailNotVerified = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerified();
  }

  Future<void> _checkEmailVerified() async {
    setState(() {
      isChecking = true;
    });

    User? user = FirebaseAuth.instance.currentUser;

    while (!isVerified) {
      await Future.delayed(const Duration(seconds: 3));
      await user?.reload();
      user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        setState(() {
          isVerified = true;
          isChecking = false;
        });

        await DatabaseMethods().updateUser(widget.uid, {"emailVerified": true});

        // Redirect to Home after successful verification
        Navigator.pushReplacement(
          context,
          CustomPageRoute(page: HomeScreen(fromLogin: false)),
        );

        break;
      }
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.sendEmailVerification();
        setState(() {
          emailNotVerified = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification email resent to ${widget.email}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to resend email: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: isChecking
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                'Checking email verification...',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isVerified
                    ? 'Email Verified! Redirecting...'
                    : 'Email not verified yet.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: resendVerificationEmail,
                child: Text('Resend Verification Email'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
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
