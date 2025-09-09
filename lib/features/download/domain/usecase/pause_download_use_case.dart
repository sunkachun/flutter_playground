import 'package:flutter_playground/features/download/domain/download_repository.dart';
import 'package:flutter_playground/features/download/domain/entity/download_task_entity.dart';

class PauseDownloadUseCase {
  final DownloadRepository repository;

  PauseDownloadUseCase(this.repository);

  Future<bool> execute(DownloadTaskEntity task) async {
    return repository.pauseDownload(task);
  }
}