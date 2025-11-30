import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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

          // dark overlay
          Container(
            color: Colors.black.withOpacity(0.25),
          ),

          // ==========================
          // BACK BUTTON
          // ==========================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),

          // ==========================
          // CONTENT
          // ==========================
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 140),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 40),
                  decoration: const BoxDecoration(
                    color: Color(0xFF5C2A2A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 38,
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

                      const SizedBox(height: 20),

                      // ==========================
                      // CONFIRM PASSWORD
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
                              hintText: "Confirm Password",
                              filled: false,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // REGISTER BUTTON
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
                          onPressed: () {},
                          child: const Text(
                            "Regist",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
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
