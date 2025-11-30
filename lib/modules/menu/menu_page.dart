import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

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
              'assets/images/bg_coffee_menu.png', // ganti sesuai aset
              fit: BoxFit.cover,
            ),
          ),

          Container(color: Colors.black.withOpacity(0.10)),

          // ==========================
          // CONTENT
          // ==========================
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),

                // ==========================
                // BACK BUTTON + SEARCH BAR
                // ==========================
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // =============== SEARCH BAR FIX ===============
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: const TextField(
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: false,
                                isCollapsed: true,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Colors.black54,
                                ),
                                hintText: "Cari...",
                                hintStyle: TextStyle(
                                  fontFamily: 'Georgia',
                                  color: Colors.black54,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // TITLE
                const Text(
                  "Menu",
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // ==========================
                // GRID MENU
                // ==========================
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.88,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                      ),
                      itemCount: menuList.length,
                      itemBuilder: (context, index) {
                        final item = menuList[index];
                        return _menuItem(item['image'], item['name']);
                      },
                    ),
                  ),
                ),

                // ==========================
                // BOTTOM ACTIONS
                // ==========================
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Tambah",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Georgia',
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Pilih",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Georgia',
                          fontSize: 15,
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

  // ==========================
  // MENU ITEM CARD
  // ==========================
  Widget _menuItem(String img, String name) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            width: 82,
            height: 82,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================
// MENU DATA LIST
// ==========================
final List<Map<String, dynamic>> menuList = [
  {"image": "assets/menu/espresso.png", "name": "Espresso"},
  {"image": "assets/menu/americano.png", "name": "Americano"},
  {"image": "assets/menu/cappuccino.png", "name": "Cappuccino"},
  {"image": "assets/menu/caramel_latte.png", "name": "Caramel Latte"},
  {"image": "assets/menu/mochaccino.png", "name": "Mochaccino"},
  {"image": "assets/menu/hot_chocolate.png", "name": "Hot Chocolate"},
  {"image": "assets/menu/aren_latte.png", "name": "Aren Latte"},
  {"image": "assets/menu/honey_milk_latte.png", "name": "Honey Milk Latte"},
];
