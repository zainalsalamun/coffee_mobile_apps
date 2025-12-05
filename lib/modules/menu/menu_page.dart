import 'dart:io';

import 'package:coffe_mobile_apps/services/menu_services.dart';
import 'package:flutter/material.dart';

import '../../models/menu_item.dart';
import 'add_menu_page.dart';
import 'detail_menu_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _searchC = TextEditingController();
  final MenuService _menuService = MenuService.instance;

  List<MenuItem> _allMenus = [];
  List<MenuItem> _filteredMenus = [];

  bool _selectMode = false;
  final List<int> _selectedIds = [];

  @override
  void initState() {
    super.initState();
    _loadMenus();
  }

  void _loadMenus() {
    final menus = _menuService.getAll();
    setState(() {
      _allMenus = menus;
      _applyFilter();
    });
  }

  void _applyFilter() {
    final q = _searchC.text.toLowerCase();
    if (q.isEmpty) {
      _filteredMenus = List.from(_allMenus);
    } else {
      _filteredMenus =
          _allMenus.where((m) => m.name.toLowerCase().contains(q)).toList();
    }
  }

  void _toggleSelectMode() {
    setState(() {
      if (_selectMode) {
        // keluar dari mode pilih
        _selectMode = false;
        _selectedIds.clear();
      } else {
        _selectMode = true;
        _selectedIds.clear();
      }
    });
  }

  Future<void> _deleteSelected() async {
    if (_selectedIds.isEmpty) {
      // kalau ga ada yang kepilih, dianggap batal
      _toggleSelectMode();
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Hapus Menu'),
            content: const Text('Yakin ingin menghapus menu yang dipilih?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await _menuService.deleteMenus(_selectedIds);
      _toggleSelectMode();
      _loadMenus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maroon = const Color(0xFF5C2A2A);

    final String rightLabel;
    if (_selectMode && _selectedIds.isNotEmpty) {
      rightLabel = 'Hapus';
    } else if (_selectMode) {
      rightLabel = 'Batalkan';
    } else {
      rightLabel = 'Pilih';
    }

    return Scaffold(
      body: Stack(
        children: [
          // BG
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_coffee_menu.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.10)),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),

                // Back + Search
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
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: TextField(
                            controller: _searchC,
                            onChanged: (_) {
                              setState(() => _applyFilter());
                            },
                            style: const TextStyle(
                              fontFamily: 'Georgia',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              prefixIcon: Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.white,
                              ),
                              hintText: "Cari...",
                              hintStyle: TextStyle(
                                fontFamily: 'Georgia',
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

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

                // GRID
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
                      itemCount: _filteredMenus.length,
                      itemBuilder: (context, index) {
                        final item = _filteredMenus[index];
                        final isSelected = _selectedIds.contains(item.id);

                        return GestureDetector(
                          onTap: () async {
                            if (_selectMode) {
                              setState(() {
                                if (isSelected) {
                                  _selectedIds.remove(item.id);
                                } else {
                                  _selectedIds.add(item.id);
                                }
                              });
                            } else {
                              final changed = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailMenuPage(menu: item),
                                ),
                              );
                              if (changed == true) _loadMenus();
                            }
                          },
                          child: _menuItem(
                            item,
                            maroon: maroon,
                            selectMode: _selectMode,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Bottom row: Tambah / Pilih-Hapus-Batalkan
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final added = await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddMenuPage(),
                            ),
                          );
                          if (added == true) _loadMenus();
                        },
                        child: const Text(
                          "Tambah",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Georgia',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_selectMode && _selectedIds.isNotEmpty) {
                            _deleteSelected();
                          } else if (_selectMode && _selectedIds.isEmpty) {
                            _toggleSelectMode();
                          } else {
                            _toggleSelectMode();
                          }
                        },
                        child: Text(
                          rightLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Georgia',
                            fontSize: 15,
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

  Widget _menuItem(
    MenuItem item, {
    required Color maroon,
    required bool selectMode,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          // konten utama
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.imagePath != null && item.imagePath!.isNotEmpty)
                  Image.file(
                    File(item.imagePath!),
                    width: 82,
                    height: 82,
                    fit: BoxFit.contain,
                  )
                else
                  Image.asset(
                    "assets/menu/espresso.png", // default (bebas)
                    width: 82,
                    height: 82,
                    fit: BoxFit.contain,
                  ),
                const SizedBox(height: 10),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // kotak merah / putih di pojok kiri atas saat selectMode
          if (selectMode)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black, width: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
