import 'package:hive/hive.dart';
import '../models/stock_item.dart';
import 'hive_service.dart';

class StockService {
  final Box<StockItem> _box = Hive.box<StockItem>(HiveService.stockBoxName);

  List<StockItem> getAll() => _box.values.toList();

  Future<void> addStock({
    required String name,
    required String imagePath,
    required int quantity,
  }) async {
    final newId =
        (_box.values.map((e) => e.id).fold<int>(0, (p, c) => c > p ? c : p)) +
        1;

    final item = StockItem(
      id: newId,
      name: name,
      imagePath: imagePath,
      quantity: quantity,
    );

    await _box.add(item);
  }

  Future<void> updateStock(StockItem item) async {
    final key = _box.keys.firstWhere((k) => _box.get(k)!.id == item.id);
    await _box.put(key, item);
  }

  Future<void> deleteStock(int id) async {
    final key = _box.keys.firstWhere((k) => _box.get(k)!.id == id);
    await _box.delete(key);
  }
}
