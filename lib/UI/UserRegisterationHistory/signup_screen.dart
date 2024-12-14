import 'package:flutter/material.dart';
import '../Service/auth.dart';
import '../Widgets/CustomTextField.dart';
import '../Widgets/CustomGooglebutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Service/Database.dart';
import'../UserRegisterationHistory/EmailVerification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthMethod _authMethod = AuthMethod(); // Instance of AuthMethod for Firebase auth

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  // For loading indication
  bool isLoading = false;

  Future<void> signUpWithEmailPassword() async {
    setState(() {
      isLoading = true;
    });

    if (!_formKey.currentState!.validate()) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Step 1: Create a new user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        print("User created with email: ${user.email}");

        // Step 2: Send email verification
        await user.sendEmailVerification();

        print("Verification email sent to: ${user.email}");

        // Step 3: Save user details to Firestore
        Map<String, dynamic> userInfoMap = {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password":password,
          "uid": user.uid,
          "emailVerified": false,
        };

        await DatabaseMethods().addUser(user.uid, userInfoMap);

        // Step 4: Show confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('A verification email has been sent. Please verify your email.')),
        );

        // Debugging: Check if context is still valid
        if (context.mounted) {
          print("Navigating to EmailVerificationScreen");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerificationScreen(email: email, uid: user.uid),
            ),
          );
        } else {
          print("Context is no longer valid.");
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });

      String errorMsg;
      if (e.code == 'email-already-in-use') {
        errorMsg = 'This email is already registered. Try logging in.';
      } else {
        errorMsg = e.message ?? 'Sign-Up failed.';
      }

      print("FirebaseAuthException: $errorMsg");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
  }


  // Function to sign in with Google
  Future<void> signUpWithGoogle() async {
    // Ensure no user is signed in
    await FirebaseAuth.instance.signOut();
    var userInfoMap = await _authMethod.signInWithGoogle(context);
    if (userInfoMap != null) {
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to home after successful Google sign-up
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(
            fontFamily: 'PoppinsMedium',
            color: Color(0xFFE3F2FD),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 5.0,
                color: Color(0xAA000000),
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey, // Attach the form key
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE3F2FD),

                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    hintText: 'First Name',
                    controller: firstNameController,
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Last Name',
                    controller: lastNameController,
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Last Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter Password',
                    controller: passwordController,
                    obscureText: true,
                    prefixIcon: Icons.lock,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 70),
                SizedBox(
                  width: 280,
                  child: ElevatedButton(
                    onPressed: signUpWithEmailPassword,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFFE3F2FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.how_to_reg,
                        color: Color(0xFF0D2962),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0D2962),
                        ),
                      ),
                    ],
                  ),
                  ),
                ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      '_______________ or _______________',
                      style: TextStyle(
                        color: Color(0xFFE3F2FD),
                        fontSize: 16,

                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 280,
                    child: CustomGoogleButton(
                      text: 'Sign Up with Google',
                      onPressed: signUpWithGoogle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
