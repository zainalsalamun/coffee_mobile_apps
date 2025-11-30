import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ==========================
          // BACKGROUND IMAGE
          // ==========================
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/caffe_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // overlay biar teks tetap jelas
          Container(
            color: Colors.black.withOpacity(0.25),
          ),

          // ==========================
          // CONTENT
          // ==========================
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 140),

                // ==========================
                // WELCOME TEXT
                // ==========================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Welcome\nBack!",
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      color: Colors.white,
                      fontSize: 42,
                      height: 1.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(1, 2),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // ==========================
                // ROUNDED CONTAINER
                // ==========================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 40),
                  decoration: const BoxDecoration(
                    color: Color(0xFF5C2A2A), // maroon
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Login Title
                      Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 35),

                      // ==========================
                      // USERNAME FIELD
                      // ==========================
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFC2A6A6),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: const TextField(
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              hintText: "Username",
                              filled: false,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ==========================
                      // PASSWORD FIELD
                      // ==========================
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFC2A6A6),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: const TextField(
                            obscureText: true,
                            style: TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              hintText: "Password",
                              filled: false,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ==========================
                      // LOGIN BUTTON
                      // ==========================
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3A1919),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            elevation: 6,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ==========================
                      // REGISTER TEXT
                      // ==========================
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/register'),
                          child: const Text(
                            "Don't have account? Regist",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
