import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  final Color maroon = const Color(0xFF5C2A2A);
  final Color cardWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(26, 30, 26, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            "assets/images/user.png",
                            width: 95,
                            height: 95,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  const Text(
                    "Nama",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  _textFieldBox(value: "Johnny"),
                  const SizedBox(height: 20),

                  const Text(
                    "Jabatan",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  _textFieldBox(value: "Admin"),
                  const SizedBox(height: 20),

                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  _textFieldBox(value: "********", obscure: true),
                  const SizedBox(height: 30),

                  const Text(
                    "Pengguna Lain:",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Georgia',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  _otherUserTile(
                    avatar: "assets/images/user.png",
                    name: "Jake",
                    role: "Barista",
                  ),
                  const SizedBox(height: 10),

                  _otherUserTile(
                    avatar: "assets/images/user.png",
                    name: "Jay",
                    role: "Barista",
                  ),

                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Tambah",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Georgia',
                        ),
                      ),
                      Text(
                        "Pilih",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Georgia',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 26,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 160,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: maroon,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 23,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFieldBox({required String value, bool obscure = false}) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Color(0xFFE6E6E6), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: TextEditingController(text: value),
          obscureText: obscure,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 18,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: false,
          ),
        ),
      ),
    );
  }

  Widget _otherUserTile({
    required String avatar,
    required String name,
    required String role,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cardWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              avatar,
              width: 38,
              height: 38,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Georgia',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                role,
                style: const TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Georgia',
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: maroon,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.settings, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
