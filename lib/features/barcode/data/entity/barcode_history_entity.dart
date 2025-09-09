import 'package:drift/drift.dart';
import 'package:flutter_playground/core/database/app_database.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:uuid/uuid.dart';

class BarcodeHistoryEntity extends DataClass {
  final String id;
  final String rawValue;
  final BarcodeFormat format;
  final DateTime scanTime;
  final String? note;
  final bool isFavorite;
  final String? location;
  final String? imagePath;

  BarcodeHistoryEntity({
    String? id,
    required this.rawValue,
    required this.format,
    DateTime? scanTime,
    this.note,
    this.isFavorite = false,
    this.location,
    this.imagePath,
  })  : id = id ?? const Uuid().v4(),
        scanTime = scanTime ?? DateTime.now();

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    return {
      'id': id,
      'rawValue': rawValue,
      'format': format.index,
      'scanTime': scanTime.toIso8601String(),
      'note': note,
      'isFavorite': isFavorite,
      'location': location,
      'imagePath': imagePath,
    };
  }

  BarcodeHistoryTableCompanion toCompanion() {
    return BarcodeHistoryTableCompanion(
      id: Value(id),
      rawValue: Value(rawValue),
      format: Value(format),
      scanTime: Value(scanTime),
      note: Value(note),
      isFavorite: Value(isFavorite),
      location: Value(location),
      imagePath: Value(imagePath),
    );
  }

  Future<void> save(AppDatabase db) async {
    await db.into(db.barcodeHistoryTable).insertOnConflictUpdate(toCompanion());
  }

  Future<void> delete(AppDatabase db) async {
    await (db.delete(db.barcodeHistoryTable)..where((t) => t.id.equals(id))).go();
  }

  static Future<List<BarcodeHistoryEntity>> queryAll(AppDatabase db, {bool sortByNewest = true}) async {
    final query = db.select(db.barcodeHistoryTable)
      ..orderBy([
            (t) => OrderingTerm(
          expression: t.scanTime,
          mode: sortByNewest ? OrderingMode.desc : OrderingMode.asc,
        )
      ]);

    return await query.get();
  }

  static Future<List<BarcodeHistoryEntity>> queryByFormat(AppDatabase db, BarcodeFormat format) async {
    final query = db.select(db.barcodeHistoryTable)
      ..where((t) => t.format.equals(format.index))
      ..orderBy([(t) => OrderingTerm(expression: t.scanTime, mode: OrderingMode.desc)]);

    return await query.get();
  }

  static Future<List<BarcodeHistoryEntity>> queryFavorites(AppDatabase db) async {
    final query = db.select(db.barcodeHistoryTable)
      ..where((t) => t.isFavorite.equals(true))
      ..orderBy([(t) => OrderingTerm(expression: t.scanTime, mode: OrderingMode.desc)]);

    return await query.get();
  }

  static Future<List<BarcodeHistoryEntity>> search(AppDatabase db, String queryText) async {
    final query = db.select(db.barcodeHistoryTable)
      ..where((t) => t.rawValue.like('%$queryText%') | t.note.like('%$queryText%'))
      ..orderBy([(t) => OrderingTerm(expression: t.scanTime, mode: OrderingMode.desc)]);

    return await query.get();
  }

  static Future<BarcodeHistoryEntity?> queryById(AppDatabase db, String id) async {
    return await (db.select(db.barcodeHistoryTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> toggleFavorite(AppDatabase db) async {
    final updated = BarcodeHistoryEntity(
      id: id,
      rawValue: rawValue,
      format: format,
      scanTime: scanTime,
      note: note,
      isFavorite: !isFavorite,
      location: location,
      imagePath: imagePath,
    );

    await updated.save(db);
  }

  Future<void> updateNote(AppDatabase db, String newNote) async {
    final updated = BarcodeHistoryEntity(
      id: id,
      rawValue: rawValue,
      format: format,
      scanTime: scanTime,
      note: newNote,
      isFavorite: isFavorite,
      location: location,
      imagePath: imagePath,
    );

    await updated.save(db);
  }

  static Future<void> deleteAll(AppDatabase db) async {
    await db.delete(db.barcodeHistoryTable).go();
  }
}