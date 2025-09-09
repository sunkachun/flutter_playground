import 'package:flutter_playground/features/barcode/data/entity/barcode_history_entity.dart';
import 'package:flutter_playground/features/barcode/data/repositories/barcode_repository.dart';

class GetAllBarcodesUseCase {
  final BarcodeRepository _repository;

  GetAllBarcodesUseCase(this._repository);

  Future<List<BarcodeHistoryEntity>> call({bool sortByNewest = true}) async {
    return await _repository.getAllBarcodes(sortByNewest: sortByNewest);
  }
}