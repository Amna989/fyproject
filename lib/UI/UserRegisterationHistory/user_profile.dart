import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/CustomAnimation.dart';
import 'userhistory_screen.dart';
import '../FeedbackHelp/feedback_screen.dart';
import '../UserRegisterationHistory/forgetpasssword.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  User? user;
  bool isLoading = true;
  bool isPasswordVisible = false;
  bool isGoogleUser = false;

  String? googleUserName;
  String? googleUserEmail;
  String? googleUserImageUrl;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;

    if (user != null) {
      isGoogleUser = user!.providerData.any((info) => info.providerId == "google.com");
      _fetchUserData();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUserData() async {
    try {
      if (isGoogleUser) {
        setState(() {
          googleUserName = user?.displayName;
          googleUserEmail = user?.email;
          googleUserImageUrl = user?.photoURL;
          isLoading = false;
        });
      } else {
        DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user!.uid).get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

          setState(() {
            _emailController.text = user!.email ?? '';
            if (data['firstName'] != null) _firstNameController.text = data['firstName'];
            if (data['lastName'] != null) _lastNameController.text = data['lastName'];
            if (data['password'] != null) _passwordController.text = data['password'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (isGoogleUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile editing is not allowed for Google users.')),
      );
      return;
    }

    try {
      await _firestore.collection('Users').doc(user!.uid).update({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        // Optionally update the password field if required
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: $e')),
      );
    }
  }

  Widget _buildProfileField(String label, TextEditingController controller, bool readOnly, {bool obscureText = false, VoidCallback? onSuffixTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xFFB0BEC5)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFB0BEC5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: onSuffixTap != null
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: onSuffixTap,
          )
              : null,
        ),
      ),
    );
  }

  Widget _buildNavigationTile(String title, IconData icon, Widget screen) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: const Color(0xFFB0BEC5),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFFB0BEC5)),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color(0xFFB0BEC5),
      ),
      onTap: () {
        Navigator.push(context, CustomPageRoute(page: screen));
      },
    );
  }

  Widget _buildGoogleUserHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(googleUserImageUrl ?? ''),
        ),
        const SizedBox(height: 10),
        Text(
          googleUserName ?? '',
          style: const TextStyle(
            color: Color(0xFFE3F2FD),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          googleUserEmail ?? '',
          style: const TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Color(0xFFE3F2FD))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE3F2FD)),
          onPressed: () => Navigator.pop(context),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              if (isGoogleUser) _buildGoogleUserHeader(),
              if (!isGoogleUser) ...[
                _buildProfileField('First Name', _firstNameController, false),
                _buildProfileField('Last Name', _lastNameController, false),
                _buildProfileField('Email', _emailController, true),
                _buildProfileField(
                  'Password',
                  _passwordController,
                  true,
                  obscureText: !isPasswordVisible,
                  onSuffixTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CustomPageRoute(page: const ForgotPasswordScreen()),
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFE3F2FD),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xE3F2FDFF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
              _buildNavigationTile('History', Icons.history, const HistoryScreen()),
              _buildNavigationTile('Feedback', Icons.feedback_outlined, const FeedbackScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
