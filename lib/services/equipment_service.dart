import 'package:hive/hive.dart';
import '../models/equipment_item.dart';
import 'hive_service.dart';

class EquipmentService {
  final Box<EquipmentItem> _box = Hive.box<EquipmentItem>(
    HiveService.equipmentBoxName,
  );

  List<EquipmentItem> getAll() => _box.values.toList();

  Future<void> addEquipment({
    required String name,
    required String imagePath,
  }) async {
    final newId =
        (_box.values.map((e) => e.id).fold<int>(0, (p, c) => c > p ? c : p)) +
        1;

    final item = EquipmentItem(id: newId, name: name, imagePath: imagePath);

    await _box.add(item);
  }

  Future<void> updateEquipment(EquipmentItem item) async {
    final key = _box.keys.firstWhere((k) => _box.get(k)!.id == item.id);
    await _box.put(key, item);
  }

  Future<void> deleteEquipment(int id) async {
    final key = _box.keys.firstWhere((k) => _box.get(k)!.id == id);
    await _box.delete(key);
  }
}
