import 'package:flutter_playground/features/download/domain/entity/download_task_entity.dart';
import '../download_repository.dart';

class ResumeDownloadUseCase {
  final DownloadRepository repository;

  ResumeDownloadUseCase(this.repository);

  Future<bool> execute(DownloadTaskEntity task) async {
    return repository.resumeDownload(task);
  }
}