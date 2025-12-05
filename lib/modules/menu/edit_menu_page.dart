import 'dart:io';

import 'package:coffe_mobile_apps/services/menu_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/menu_item.dart';

class EditMenuPage extends StatefulWidget {
  final MenuItem menu;

  const EditMenuPage({super.key, required this.menu});

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final Color maroon = const Color(0xFF5C2A2A);
  final MenuService _menuService = MenuService.instance;

  late TextEditingController _nameC;
  late TextEditingController _descC;

  late List<String> _persediaan;
  late List<String> _mesin;
  late List<String> _proses;

  String? _imagePath;

  @override
  void initState() {
    super.initState();
    final m = widget.menu;
    _nameC = TextEditingController(text: m.name);
    _descC = TextEditingController(text: m.description);
    _persediaan = List.from(m.persediaan);
    _mesin = List.from(m.mesin);
    _proses = List.from(m.proses);
    _imagePath = m.imagePath;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imagePath = picked.path);
    }
  }

  Future<void> _save() async {
    if (_nameC.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama menu tidak boleh kosong')),
      );
      return;
    }

    final updated = MenuItem(
      id: widget.menu.id,
      name: _nameC.text.trim(),
      imagePath: _imagePath,
      description: _descC.text.trim(),
      persediaan: _persediaan,
      mesin: _mesin,
      proses: _proses,
    );

    await _menuService.updateMenu(updated);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      "Edit Menu",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Georgia',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Avatar + Ubah Gambar
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              width: 95,
                              height: 95,
                              color: Colors.white,
                              child:
                                  _imagePath != null && _imagePath!.isNotEmpty
                                      ? Image.file(
                                        File(_imagePath!),
                                        fit: BoxFit.cover,
                                      )
                                      : Image.asset(
                                        "assets/menu/espresso.png",
                                        fit: BoxFit.contain,
                                      ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Ubah Gambar",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Georgia',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),

                  _label("Ubah Nama Menu"),
                  const SizedBox(height: 6),
                  _textFieldBox(_nameC),
                  const SizedBox(height: 18),

                  _label("Ubah Deskripsi Menu"),
                  const SizedBox(height: 6),
                  _textAreaBox(_descC),
                  const SizedBox(height: 18),

                  _label("Ubah Persediaan yang dibutuhkan"),
                  const SizedBox(height: 6),
                  _editableTable(
                    items: _persediaan,
                    onChanged: (list) {
                      setState(() => _persediaan = list);
                    },
                  ),
                  const SizedBox(height: 18),

                  _label("Ubah Mesin yang digunakan"),
                  const SizedBox(height: 6),
                  _editableTable(
                    items: _mesin,
                    onChanged: (list) {
                      setState(() => _mesin = list);
                    },
                  ),
                  const SizedBox(height: 18),

                  _label("Ubah Proses Pembuatan"),
                  const SizedBox(height: 6),
                  _editableTable(
                    items: _proses,
                    onChanged: (list) {
                      setState(() => _proses = list);
                    },
                  ),
                ],
              ),
            ),

            // back
            Positioned(
              bottom: 23,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context, false),
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

            // simpan
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
                    onPressed: _save,
                    child: const Text(
                      "Simpan",
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

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Georgia',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _textFieldBox(TextEditingController c) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: c,
        style: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _textAreaBox(TextEditingController c) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: c,
        maxLines: 4,
        style: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _editableTable({
    required List<String> items,
    required ValueChanged<List<String>> onChanged,
  }) {
    final rows = items.isEmpty ? [''] : items;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ...List.generate(rows.length, (index) {
            final isOdd = index.isOdd;
            return InkWell(
              onTap: () async {
                final edited = await _editRowDialog(rows[index]);
                if (edited != null) {
                  final newList = List<String>.from(items);
                  if (items.isEmpty) {
                    newList
                      ..clear()
                      ..add(edited);
                  } else {
                    if (index < newList.length) {
                      newList[index] = edited;
                    } else {
                      newList.add(edited);
                    }
                  }
                  onChanged(newList);
                }
              },
              onLongPress: () {
                if (index < items.length) {
                  final newList = List<String>.from(items)..removeAt(index);
                  onChanged(newList);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      isOdd ? const Color(0xFFE7D8D8) : const Color(0xFFF7EFEF),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 22,
                      child: Text(
                        "${index + 1}.",
                        style: const TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        index < items.length ? items[index] : "Tambah teks...",
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 12,
                          fontStyle:
                              index < items.length
                                  ? FontStyle.normal
                                  : FontStyle.italic,
                          color:
                              index < items.length
                                  ? Colors.black
                                  : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          // tombol tambah baris
          TextButton(
            onPressed: () async {
              final text = await _editRowDialog('');
              if (text != null && text.trim().isNotEmpty) {
                final newList = List<String>.from(items)..add(text.trim());
                onChanged(newList);
              }
            },
            child: const Text(
              '+ Tambah baris',
              style: TextStyle(fontFamily: 'Georgia', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _editRowDialog(String initial) async {
    final c = TextEditingController(text: initial);
    return showDialog<String>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Edit'),
            content: TextField(controller: c, maxLines: 3),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, c.text.trim()),
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }
}
