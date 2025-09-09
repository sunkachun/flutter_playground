import 'package:flutter_playground/features/barcode/data/repositories/barcode_repository.dart';

class DeleteAllBarcodesUseCase {
  final BarcodeRepository _repository;

  DeleteAllBarcodesUseCase(this._repository);

  Future<void> call() async {
    await _repository.deleteAllBarcodes();
  }
}