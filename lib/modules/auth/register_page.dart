import 'package:flutter/material.dart';
import 'package:coffe_mobile_apps/services/auth_services.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _usernameC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();
  final TextEditingController _confirmC = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                const Color(0xFF522A2A).withOpacity(0.55),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/caffe_bg.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Back Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 10),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),

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

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 40),
              decoration: const BoxDecoration(
                color: Color(0xFF4E2020),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

                        // USERNAME
                        _field(hint: "Username", controller: _usernameC),

                        const SizedBox(height: 20),

                        // PASSWORD
                        _field(
                          hint: "Password",
                          controller: _passwordC,
                          obscure: true,
                        ),

                        const SizedBox(height: 20),

                        // CONFIRM PASSWORD
                        _field(
                          hint: "Confirm Password",
                          controller: _confirmC,
                          obscure: true,
                        ),

                        const SizedBox(height: 30),

                        // BUTTON
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
                            onPressed: () async {
                              if (_passwordC.text != _confirmC.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Password dan Confirm Password tidak sama",
                                    ),
                                  ),
                                );
                                return;
                              }

                              final user = await _auth.register(
                                _usernameC.text.trim(),
                                _passwordC.text.trim(),
                                role: "user",
                              );

                              if (user == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Username sudah digunakan"),
                                  ),
                                );
                                return;
                              }

                              Navigator.pushReplacementNamed(context, '/home');
                            },
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFC2A6A6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 18,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Georgia',
          ),
        ),
      ),
    );
  }
}
