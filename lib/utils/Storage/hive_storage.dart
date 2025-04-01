import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class THiveStorage {
  late final Box _box;

  /// SINGLETON INSTANCE
  static THiveStorage? _instance;

  THiveStorage._internal(this._box);

  factory THiveStorage.instance() {
    if (_instance == null) {
      throw Exception("Call init() before accessing instance.");
    }
    return _instance!;
  }

  /// INITIALIZE STORAGE BEFORE USE
  static Future<void> init(String boxName) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    final box = await Hive.openBox(boxName);
    _instance = THiveStorage._internal(box);
  }

  // Generic method to save data
  Future<void> saveData<T>(String key, T value) async {
    await _box.put(key, value);
  }

  // Generic method to read data
  T? readData<T>(String key) {
    return _box.get(key);
  }

  // Generic method to update data
  Future<void> updateData<T>(String key, T value) async {
    await _box.put(key, value);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _box.delete(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async {
    await _box.clear();
  }
}
