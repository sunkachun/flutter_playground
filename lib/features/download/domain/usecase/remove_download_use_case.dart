import '../download_repository.dart';

class RemoveDownloadUseCase {
  final DownloadRepository repository;

  RemoveDownloadUseCase(this.repository);

  Future<void> execute(List<String> taskId) async {
    repository.batchRemoveDownload(taskId);
  }
}