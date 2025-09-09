import 'package:flutter_playground/features/barcode/data/repositories/barcode_repository.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ScanBarcodeUseCase {
  final BarcodeRepository _repository;
  final BarcodeScanner _barcodeScanner;

  ScanBarcodeUseCase(this._repository, this._barcodeScanner);

  Future<List<Barcode>> call(InputImage inputImage) async {
    final barcodes = await _barcodeScanner.processImage(inputImage);
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        await _repository.saveBarcode(barcode);
      }
    }
    return barcodes;
  }
}