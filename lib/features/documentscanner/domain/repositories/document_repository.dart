import 'package:flutter_playground/features/documentscanner/domain/entities/document_history_entity.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

abstract class DocumentRepository {
  Future<DocumentScanningResult> scanDocument({
    required DocumentFormat format,
    required ScannerMode mode,
    int pageLimit,
    bool allowGallery,
  });
  Future<List<DocumentHistoryEntity>> getAllDocuments();
  Future<void> toggleFavorite(String id);
  Future<void> updateNote(String id, String note);
  Future<void> deleteAllDocuments();
}