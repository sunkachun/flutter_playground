import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart' hide Table;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_playground/features/barcode/data/entity/barcode_history_entity.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../features/barcode/data/entity/barcode_history_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
    tables: [
      BarcodeHistoryTable,
    ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'barcode_database.sqlite'));
    debugPrint('Database file path: ${file.path}');
    return NativeDatabase(file);
  });
}