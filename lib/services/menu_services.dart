import 'package:hive/hive.dart';

import '../models/menu_item.dart';
import 'hive_service.dart';

class MenuService {
  MenuService._();
  static final MenuService instance = MenuService._();

  Box<MenuItem> get _box => Hive.box<MenuItem>(HiveService.menuBoxName);

  List<MenuItem> getAll() {
    return _box.values.toList();
  }

  int getNextId() {
    if (_box.isEmpty) return 1;
    final ids = _box.values.map((e) => e.id).toList()..sort();
    return ids.last + 1;
  }

  Future<void> addMenu(MenuItem item) async {
    await _box.add(item);
  }

  Future<void> updateMenu(MenuItem item) async {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k)?.id == item.id,
      orElse: () => null,
    );
    if (key != null) {
      await _box.put(key, item);
    }
  }

  Future<void> deleteMenus(List<int> ids) async {
    final keysToDelete = _box.keys.where((k) => ids.contains(_box.get(k)?.id));
    await _box.deleteAll(keysToDelete);
  }
}
