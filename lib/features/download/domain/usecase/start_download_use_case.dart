import 'package:flutter_playground/features/download/domain/entity/download_task_entity.dart';
import '../download_repository.dart';

class StartDownloadUseCase {
  final DownloadRepository repository;

  StartDownloadUseCase(this.repository);

  Future<bool> execute(List<DownloadTaskEntity> tasks, {bool wifiOnly = false}) async {
    return repository.checkNetworkAndDownload(tasks, wifiOnly: wifiOnly);
  }
}