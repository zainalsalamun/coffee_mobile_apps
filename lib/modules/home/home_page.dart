import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Color maroon = const Color(0xFF5C2A2A);
  final Color maroonDark = const Color(0xFF4A2020);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            children: [
              // ===========================
              // HEADER BAR
              // ===========================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: maroon,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                  child: Row(
                    children: [
                      // Avatar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          'assets/images/user.png', // <-- ganti foto profil
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Name + Role
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Johnny",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Georgia',
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Admin",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Settings Icon
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.settings, color: Colors.white, size: 22),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===========================
              // CARD - MENU
              // ===========================
              _menuCard(
                icon: Icons.coffee,
                label: "Menu",
                bgColor: maroonDark,
                onTap: () {
                  Navigator.pushNamed(context, '/menu');
                },

              ),

              const SizedBox(height: 14),

              // ===========================
              // CARD IMAGE (BUT FIRST COFFEE)
              // ===========================
              _imageCard("assets/images/but_first_coffee.png"),

              const SizedBox(height: 14),

              // ===========================
              // CARD - Peralatan dan Mesin
              // ===========================
              _menuCard(
                icon: Icons.kitchen,
                label: "Peralatan dan Mesin",
                bgColor: maroonDark,
                onTap: () {
                    Navigator.pushNamed(context, '/equipment');
                },
              ),

              const SizedBox(height: 14),

              // ===========================
              // CARD INFO TEXT
              // ===========================
              _infoTextCard(),

              const SizedBox(height: 14),

              // ===========================
              // CARD - Persediaan
              // ===========================
              _menuCard(
                icon: Icons.inventory_2,
                label: "Persediaan",
                bgColor: maroonDark,
                onTap: () {
                  Navigator.pushNamed(context, '/persediaan');
                },
              ),

              const SizedBox(height: 14),

              // ===========================
              // CARD IMAGE BAWAH
              // ===========================
              _imageCard("assets/images/coffe_cup.png"),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================
  // WIDGET MENU CARD
  // ===========================
  Widget _menuCard({
    required IconData icon,
    required String label,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Georgia',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  // ===========================
  // WIDGET IMAGE CARD
  // ===========================
  Widget _imageCard(String path) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.edit, size: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================
  // WIDGET TEXT INFO CARD
  // ===========================
  Widget _infoTextCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF5C2A2A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Column(
            children: const [
              Text(
                "Informasi tentang peralatan di kedai\nkopi selalu tersedia",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Georgia',
                ),
              ),
              SizedBox(height: 12),
              Divider(color: Colors.white38, thickness: 1),
            ],
          ),

          // Icon Edit
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(Icons.edit, size: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
