import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WILD FREE',
          style: TextStyle(
            fontFamily: 'FarmFont', // Change to your farm-themed font
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF4CAF50), // Green color for agriculture
      ),
      body: _buildLoginForm(),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'WILD FREE LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _buildTextField("Email", _emailController),
                SizedBox(height: 10.0),
                _buildTextField("Password", _passwordController,
                    isPassword: true),
                SizedBox(height: 20.0),
                _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF4CAF50)), // Green color for agriculture
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _signInWithEmailAndPassword();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFF4CAF50), // Green color for agriculture
                        ),
                        child: Text('Login'),
                      ),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    // Navigate to sign-up page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: Color(0xFF4CAF50), // Green color for agriculture
                      fontWeight: FontWeight.bold,
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

  Widget _buildTextField(String labelText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        isDense: true,
      ),
      obscureText: isPassword,
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Show the "WILD FREE" text using SnackBar for 3 seconds
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'WILD FREE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Set text color to white
            ),
          ),
          backgroundColor:
              Color(0xFF4CAF50), // Green background color for agriculture
          duration: Duration(seconds: 3),
        ),
      );

      // Reset the login form and loading state
      _emailController.clear();
      _passwordController.clear();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildSignUpForm(context), // Pass context to the function
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    // Add context parameter
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create an Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                _buildTextField("Full Name", TextEditingController()),
                SizedBox(height: 10.0),
                _buildTextField("Email", TextEditingController()),
                SizedBox(height: 10.0),
                _buildTextField("Password", TextEditingController(),
                    isPassword: true),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Perform sign-up logic
                    // Navigate to profile page after sign up
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF4CAF50), // Green color for agriculture
                  ),
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        isDense: true,
      ),
      obscureText: isPassword,
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Your Profile!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF4CAF50), // Green color for agriculture
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
