import 'package:flutter/material.dart';

// ======================================================================
//  REUSABLE SEARCH BAR
// ======================================================================
class AppSearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    required this.hint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: Colors.black54,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Georgia',
            color: Colors.black54,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

// ======================================================================
//  REUSABLE ITEM CARD
// ======================================================================
class AppItemCard extends StatelessWidget {
  final String image;
  final String name;

  const AppItemCard({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================================
//  MAIN PAGE — EQUIPMENT PAGE
// ======================================================================
class EquipmentPage extends StatelessWidget {
  const EquipmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/bg_coffee_menu.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.black.withOpacity(0.1)),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),

                // ===== BACK + SEARCH BAR =====
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

                      // Search bar reusable
                      const Expanded(
                        child: AppSearchBar(hint: "Cari..."),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Peralatan dan Mesin",
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // ===== GRID LIST =====
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: equipmentList.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.88,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                      ),
                      itemBuilder: (context, index) {
                        final item = equipmentList[index];
                        return AppItemCard(
                          image: item["image"],
                          name: item["name"],
                        );
                      },
                    ),
                  ),
                ),

                // ===== TOMBOL TAMBAH & PILIH =====
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
}

// ======================================================================
//  LIST DATA
// ======================================================================
final List<Map<String, dynamic>> equipmentList = [
  {
    "image": "assets/equip/manual_espresso.png",
    "name": "Manual Espresso\nMachine"
  },
  {
    "image": "assets/equip/manual_espresso2.png",
    "name": "Manual Espresso\nMachine"
  },
  {"image": "assets/equip/grinder.png", "name": "Grinder"},
  {"image": "assets/equip/milk_frother.png", "name": "Milk Frother"},
  {"image": "assets/equip/tamper.png", "name": "Tamper"},
  {"image": "assets/equip/coffee_scoop.png", "name": "Coffee Scoop"},
  {"image": "assets/equip/milk_pitcher.png", "name": "Milk Pitcher"},
  {"image": "assets/equip/digital_scale.png", "name": "Digital Scale"},
];
