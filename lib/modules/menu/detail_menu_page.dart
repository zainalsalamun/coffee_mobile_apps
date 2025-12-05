import 'dart:io';

import 'package:coffe_mobile_apps/modules/menu/edit_menu_page.dart';
import 'package:coffe_mobile_apps/services/menu_services.dart';
import 'package:flutter/material.dart';
import '../../models/menu_item.dart';

class DetailMenuPage extends StatefulWidget {
  final MenuItem menu;

  const DetailMenuPage({super.key, required this.menu});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  final Color maroon = const Color(0xFF5C2A2A);
  final MenuService _menuService = MenuService.instance;

  late MenuItem _menu;

  @override
  void initState() {
    super.initState();
    _menu = widget.menu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==== HEADER BARU (SAMA PERSIS DESAIN)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE BULAT
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child:
                            _menu.imagePath != null &&
                                    _menu.imagePath!.isNotEmpty
                                ? Image.file(
                                  File(_menu.imagePath!),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                                : Image.asset(
                                  "assets/menu/espresso.png",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                      ),

                      const SizedBox(width: 16),

                      // BOX PUTIH (NAMA + DESKRIPSI)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _menu.name,
                                style: const TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _menu.description.isNotEmpty
                                    ? _menu.description
                                    : "-",
                                style: const TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 12.5,
                                  height: 1.4,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  // ===== SECTIONS
                  _sectionTitle("Persediaan yang dibutuhkan"),
                  _listTable(_menu.persediaan),

                  const SizedBox(height: 22),

                  _sectionTitle("Mesin yang digunakan"),
                  _listTable(_menu.mesin),

                  const SizedBox(height: 22),

                  _sectionTitle("Proses Pembuatan"),
                  _listTable(_menu.proses),
                ],
              ),
            ),

            // BACK BUTTON
            Positioned(
              bottom: 23,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context, true),
                child: Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),

            // EDIT BUTTON
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
                    ),
                    onPressed: () async {
                      final updated = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditMenuPage(menu: _menu),
                        ),
                      );
                      if (updated == true) {
                        final all = _menuService.getAll();
                        final latest = all.firstWhere(
                          (m) => m.id == _menu.id,
                          orElse: () => _menu,
                        );
                        setState(() => _menu = latest);
                      }
                    },
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
          ],
        ),
      ),
    );
  }

  // === TITLE TEXT ===
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // === TABLE ===
  Widget _listTable(List<String> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          return Container(
            decoration: BoxDecoration(
              color:
                  index.isOdd
                      ? const Color(0xFFE7D8D8) // warna row ganjil (pink muda)
                      : const Color(0xFFF7EFEF), // warna row genap (abu muda)
              borderRadius:
                  index == 0
                      ? const BorderRadius.vertical(top: Radius.circular(18))
                      : BorderRadius.zero,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOMOR
                Text(
                  "${index + 1}.",
                  style: const TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // sesuai desain
                  ),
                ),

                const SizedBox(width: 14),

                // TEKS ISI
                Expanded(
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 13,
                      color: Color(0xFF333333), // abu gelap, nyaman dibaca
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
