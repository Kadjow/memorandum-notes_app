import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_tracker/core/services/auth_service.dart';
import '../../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showSignUp = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _confirmController = TextEditingController();

  void _toggleForm() {
    setState(() => _showSignUp = !_showSignUp);
  }

  Future<void> _loginWithGoogle() async {
    final user = await sl<AuthService>().signInWithGoogle();
    if (user != null) {
      // Navegar para HomePage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Home')))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: 300,
          height: 400,
          child: Stack(
            children: [
              // Container 3D
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                transitionBuilder: (child, anim) {
                  final rotateAnim = Tween(begin: pi, end: 0.0).animate(anim);
                  return AnimatedBuilder(
                    animation: rotateAnim,
                    child: child,
                    builder: (context, child) {
                      final isUnder = (ValueKey(_showSignUp) != child?.key);
                      var tilt = (rotateAnim.value - pi / 2).abs() / (pi / 2);
                      tilt = tilt * (isUnder ? -0.003 : 0.003);
                      return Transform(
                        transform: Matrix4.rotationY(rotateAnim.value)..setEntry(3, 0, tilt),
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                  );
                },
                layoutBuilder: (widget, list) => Stack(children: [if (widget != null) widget, ...list]),
                child: _showSignUp ? _buildSignUp() : _buildLogin(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return Container(
      key: const ValueKey(false),
      padding: const EdgeInsets.all(24),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 16),
          TextField(
            controller: _usernameController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Username'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Password'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: _buttonStyle(),
            child: const Text('Login'),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _toggleForm,
            child: const Text(
              "Don't have an account? Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _loginWithGoogle,
            icon: Image.asset('assets/google_logo.png', height: 24),
            label: const Text('Login with Google'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              elevation: 6,
              shadowColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp() {
    return Container(
      key: const ValueKey(true),
      padding: const EdgeInsets.all(24),
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sign Up', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 16),
          TextField(
            controller: _firstNameController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Firstname'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _usernameController,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Username'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Password'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _confirmController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration('Confirm Password'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: _buttonStyle(),
            child: const Text('Sign Up'),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _toggleForm,
            child: const Text(
              'Already have an account? Sign In',
              style: TextStyle(color: Colors.white, fontSize: 12, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: const Color(0xFF212121),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        const BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 10),
        BoxShadow(color: Colors.white.withOpacity(0.6), offset: const Offset(-1, -1), blurRadius: 5),
      ],
    );
  }

  InputDecoration _inputDecoration(String placeholder) {
    return InputDecoration(
      hintText: placeholder,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: const Color(0xFF212121),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF212121), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: const Color(0xFF212121),
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 6,
      shadowColor: Colors.black,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}
