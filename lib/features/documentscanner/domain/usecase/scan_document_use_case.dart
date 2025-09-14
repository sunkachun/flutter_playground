import 'package:flutter_playground/features/documentscanner/domain/repositories/document_repository.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

class ScanDocumentUseCase {
  final DocumentRepository repository;

  ScanDocumentUseCase(this.repository);

  Future<DocumentScanningResult> call({
    required DocumentFormat format,
    required ScannerMode mode,
    int pageLimit = 1,
    bool allowGallery = true,
  }) async {
    return await repository.scanDocument(
      format: format,
      mode: mode,
      pageLimit: pageLimit,
      allowGallery: allowGallery,
    );
  }
}