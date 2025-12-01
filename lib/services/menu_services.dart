import 'package:hive/hive.dart';
import '../models/menu_item.dart';
import 'hive_service.dart';

class MenuService {
  final Box<MenuItem> _box = Hive.box<MenuItem>(HiveService.menuBoxName);

  // Ambil semua data
  List<MenuItem> getAll() => _box.values.toList();

  // Tambah Menu
  Future<void> addMenu({
    required String name,
    required String imagePath,
    required double price,
  }) async {
    final newId =
        (_box.values.map((e) => e.id).fold<int>(0, (p, c) => c > p ? c : p)) +
        1;

    final item = MenuItem(
      id: newId,
      name: name,
      imagePath: imagePath,
      price: price,
    );

    await _box.add(item);
  }

  // Edit Menu
  Future<void> updateMenu(MenuItem item) async {
    final key = _box.keys.firstWhere((k) => _box.get(k)!.id == item.id);
    await _box.put(key, item);
  }

  // Hapus Menu
  Future<void> deleteMenu(int id) async {
    final key = _box.keys.firstWhere((k) => _box.get(k)!.id == id);
    await _box.delete(key);
  }
}
