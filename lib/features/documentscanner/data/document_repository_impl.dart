import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_playground/core/database/app_database.dart';
import 'package:flutter_playground/features/documentscanner/domain/entities/document_history_entity.dart';
import 'package:flutter_playground/features/documentscanner/domain/repositories/document_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

import 'document_scanner_data_source.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentScannerDataSource dataSource;
  final AppDatabase database;

  DocumentRepositoryImpl(this.dataSource, this.database);

  @override
  Future<DocumentScanningResult> scanDocument({
    required DocumentFormat format,
    required ScannerMode mode,
    int pageLimit = 1,
    bool allowGallery = true,
  }) async {
    final result = await dataSource.scanDocument(
      format: format,
      mode: mode,
      pageLimit: pageLimit,
      allowGallery: allowGallery,
    );

    final entity = DocumentHistoryEntity(
      id: Uuid().v4(),
      pdfPath: result.pdf?.uri,
      imagePaths: result.images.map((uri) => uri).toList(),
      createdAt: DateTime.now(),
      isFavorite: false,
      note: null,
    );
    await database.into(database.documentHistoryTable).insertOnConflictUpdate(entity.toCompanion());
    return result;
  }

  @override
  Future<List<DocumentHistoryEntity>> getAllDocuments() async {
    final query = database.select(database.documentHistoryTable)
      ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
      ]);
    final results = await query.get();
    return results.map((row) {
      return DocumentHistoryEntity(
        id: row.id,
        pdfPath: row.pdfPath,
        imagePaths: List<String>.from(jsonDecode(row.imagePaths)),
        isFavorite: row.isFavorite,
        note: row.note,
        createdAt: row.createdAt,
      );
    }).toList();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final query = database.select(database.documentHistoryTable)..where((t) => t.id.equals(id));
    final document = await query.getSingleOrNull();
    if (document != null) {
      await (database.update(database.documentHistoryTable)..where((t) => t.id.equals(id)))
          .write(DocumentHistoryTableCompanion(
        isFavorite: Value(!document.isFavorite),
      ));
    }
  }

  @override
  Future<void> updateNote(String id, String note) async {
    await (database.update(database.documentHistoryTable)..where((t) => t.id.equals(id)))
        .write(DocumentHistoryTableCompanion(
      note: Value(note),
    ));
  }

  @override
  Future<void> deleteAllDocuments() async {
    await database.delete(database.documentHistoryTable).go();
  }
}