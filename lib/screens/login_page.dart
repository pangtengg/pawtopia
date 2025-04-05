import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLoginForm = true;
  String _errorMessage = '';

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Toggle between login and signup forms
  void toggleForm() {
    setState(() {
      _isLoginForm = !_isLoginForm;
      _errorMessage = '';
    });
  }

  // Handle login/signup process
  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        UserCredential userCredential;

        if (_isLoginForm) {
          // Login with email and password
          userCredential = await _auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
        } else {
          // Create a new account
          userCredential = await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
        }

        // Navigate to home page on successful login/signup
        if (userCredential.user != null && mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred. Please try again.';

        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The email address is already in use.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'The password is too weak.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is invalid.';
        }

        setState(() {
          _errorMessage = errorMessage;
        });
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD0CFF8), Color(0xFFC4E1FB)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'app_logo',
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 180,
                      width: 180,
                    ),
                  ),
                  const SizedBox(height: 48.0),

                  // Email field
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email, color: Color.fromARGB(255, 185, 8, 8)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Password field
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(255, 185, 8, 8)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        labelStyle: TextStyle(color: Colors.grey[700]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!_isLoginForm && value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Error message
                  if (_errorMessage.isNotEmpty)
                    AnimatedOpacity(
                      opacity: _errorMessage.isNotEmpty ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  SizedBox(height: _errorMessage.isNotEmpty ? 16.0 : 0),

                  // Login/Signup button
                  ElevatedButton(
                    onPressed: _isLoading ? null : submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 185, 8, 8),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 3,
                      shadowColor: Color.fromARGB(255, 185, 8, 8).withOpacity(0.5),
                      disabledBackgroundColor: Color.fromARGB(255, 185, 8, 8).withOpacity(0.5),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            _isLoginForm ? 'LOGIN' : 'SIGN UP',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16.0),

                  // Forgot password button
                  if (_isLoginForm)
                    TextButton(
                      onPressed: () {
                        if (_emailController.text.isNotEmpty) {
                          _auth.sendPasswordResetEmail(
                            email: _emailController.text.trim(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password reset email sent'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter your email first'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF05257C),
                      ),
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                  // Toggle login/signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLoginForm
                            ? 'Don\'t have an account?'
                            : 'Already have an account?',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      TextButton(
                        onPressed: toggleForm,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF05257C),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        child: Text(
                          _isLoginForm ? 'Sign up' : 'Login',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Skip login button with improved styling
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF05257C)),
                        foregroundColor: const Color(0xFF05257C),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        'Skip Login (Demo)',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
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