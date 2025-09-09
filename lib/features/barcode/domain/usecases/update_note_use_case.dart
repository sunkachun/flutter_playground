import 'package:flutter_playground/features/barcode/data/repositories/barcode_repository.dart';

class UpdateNoteUseCase {
  final BarcodeRepository _repository;

  UpdateNoteUseCase(this._repository);

  Future<void> call(String id, String note) async {
    await _repository.updateNote(id, note);
  }
}