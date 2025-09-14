import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

class DocumentScannerDataSource {
  Future<DocumentScanningResult> scanDocument({
    required DocumentFormat format,
    required ScannerMode mode,
    int pageLimit = 1,
    bool allowGallery = true,
  }) async {
    final options = DocumentScannerOptions(
      documentFormat: format,
      mode: mode,
      pageLimit: pageLimit,
      isGalleryImport: allowGallery,
    );
    final scanner = DocumentScanner(options: options);
    final result = await scanner.scanDocument();
    scanner.close();
    if (result.images.isEmpty && result.pdf == null) {
      throw Exception('掃描失敗');
    }
    return result;
  }
}