import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_playground/features/download/data/model/download_task_notes.dart';

import 'entity/download_task_entity.dart';

abstract class DownloadRepository {
  Future<void> batchEnqueueDownload(List<DownloadTaskEntity> tasks);
  Future<void> batchPauseDownload(List<String> taskIds);
  Future<void> batchRemoveDownload(List<String> taskIds);
  Future<void> batchRestartDownload(List<DownloadTaskEntity> tasks);
  Future<List<DownloadTaskNotes>> getAllDownloadTasks();
  Stream<TaskUpdate> getDownloadTaskStatusStream();
  Future<bool> pauseDownload(DownloadTaskEntity task);
  Future<bool> resumeDownload(DownloadTaskEntity task);
  Future<bool> checkNetworkAndDownload(List<DownloadTaskEntity> tasks, {bool wifiOnly = false});
}