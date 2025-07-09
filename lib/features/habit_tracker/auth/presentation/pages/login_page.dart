import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/core/services/auth_service.dart';
import 'package:habit_tracker/injection_container.dart';
import 'package:lottie/lottie.dart';

/// SVG do logo do Google
const String _googleSvg = '''
<svg version="1.1" width="24" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg">
  <path fill="#FBBB00" d="M113.47,309.408L95.648,375.94l-65.139,1.378C11.042,341.211,0,299.9,0,256
    c0-42.451,10.324-82.483,28.624-117.732l57.992,10.632l25.404,57.644
    c-5.317,15.501-8.215,32.141-8.215,49.456
    C103.821,274.792,107.225,292.797,113.47,309.408z"/>
  <path fill="#518EF8" d="M507.527,208.176C510.467,223.662,512,239.655,512,256
    c0,18.328-1.927,36.206-5.598,53.451
    c-12.462,58.683-45.025,109.925-90.134,146.187l-73.044-3.727
    l-10.338-64.535c29.932-17.554,53.324-45.025,65.646-77.911
    h-136.89V208.176h138.887z"/>
  <path fill="#28B446" d="M416.253,455.624C372.396,490.901,316.666,512,256,512
    c-97.491,0-182.252-54.491-225.491-134.681l82.961-67.91
    c21.619,57.698,77.278,98.771,142.53,98.771
    c28.047,0,54.323-7.582,76.87-20.818L416.253,455.624z"/>
  <path fill="#F14336" d="M419.404,58.936l-82.933,67.896
    c-23.335-14.586-50.919-23.012-80.471-23.012
    c-66.729,0-123.429,42.957-143.965,102.724l-83.397-68.276
    C157.06,0,256,0,256,0
    C318.115,0,375.068,22.126,419.404,58.936z"/>
</svg>
''';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _userFocus.addListener(() => setState(() {}));
    _passFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _userFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  Future<void> _loginWithGoogle() async {
    final user = await sl<AuthService>().signInWithGoogle();
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Home')),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Lottie.asset(
                'lib/assets/animations/animation_sky.json', 
                fit: BoxFit.cover,
                repeat: true,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Container(
                width: width,
                padding: const EdgeInsets.all(36),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 20, 24, 37).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      offset: const Offset(6, 6),
                      blurRadius: 12,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.05),
                      offset: const Offset(-6, -6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _FocusNeumorphicField(
                      hint: 'Username',
                      focusNode: _userFocus,
                    ),
                    const SizedBox(height: 24),
                    _FocusNeumorphicField(
                      hint: 'Password',
                      obscure: true,
                      focusNode: _passFocus,
                    ),
                    const SizedBox(height: 32),
                    _neumorphicButton(label: 'Login', onTap: () {}),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Don't have an account? Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _googleButton(onTap: _loginWithGoogle),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _googleButton({required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 6,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: const Offset(-2, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.string(_googleSvg, height: 24, width: 24),
          const SizedBox(width: 12),
          const Text('Login with Google', style: TextStyle(color: Colors.black)),
        ],
      ),
    ),
  );
}

Widget _neumorphicButton({
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: const Offset(3, 3),
            blurRadius: 6,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            offset: const Offset(-3, -3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class _FocusNeumorphicField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final FocusNode focusNode;

  const _FocusNeumorphicField({
    required this.hint,
    this.obscure = false,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFocus = focusNode.hasFocus;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
        boxShadow: hasFocus
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.15),
                  offset: const Offset(-2, -2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  offset: const Offset(2, 2),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  offset: const Offset(3, 3),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.05),
                  offset: const Offset(-3, -3),
                  blurRadius: 6,
                ),
              ],
      ),
      transform: hasFocus ? (Matrix4.identity()..scale(1.02)) : Matrix4.identity(),
      child: TextField(
        focusNode: focusNode,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
      ),
    );
  }
}
