import 'package:flutter_playground/core/database/app_database.dart';
import 'package:flutter_playground/features/barcode/data/entity/barcode_history_entity.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BarcodeRepository {
  final AppDatabase _database;

  BarcodeRepository(this._database);

  Future<void> saveBarcode(Barcode barcode) async {
    final entity = BarcodeHistoryEntity(
      rawValue: barcode.rawValue ?? '',
      format: barcode.format,
    );
    await entity.save(_database);
  }

  Future<List<BarcodeHistoryEntity>> getAllBarcodes({bool sortByNewest = true}) async {
    return await BarcodeHistoryEntity.queryAll(_database, sortByNewest: sortByNewest);
  }

  Future<void> toggleFavorite(String id) async {
    final barcode = await BarcodeHistoryEntity.queryById(_database, id);
    if (barcode != null) {
      await barcode.toggleFavorite(_database);
    }
  }

  Future<void> updateNote(String id, String note) async {
    final barcode = await BarcodeHistoryEntity.queryById(_database, id);
    if (barcode != null) {
      await barcode.updateNote(_database, note);
    }
  }

  Future<void> deleteAllBarcodes() async {
    await BarcodeHistoryEntity.deleteAll(_database);
  }
}