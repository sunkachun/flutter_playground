import 'package:background_downloader/background_downloader.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_playground/features/download/domain/download_repository.dart';
import 'package:flutter_playground/features/download/domain/entity/download_task_entity.dart';
import 'download_manager.dart';
import 'model/download_task_notes.dart';


class DownloadRepositoryImpl implements DownloadRepository {
  final DownloadManager _downloadManager;

  DownloadRepositoryImpl(this._downloadManager);

  @override
  Future<void> batchEnqueueDownload(List<DownloadTaskEntity> tasks) async {
    final downloadTasks = tasks.map((e) => DownloadTask(
      taskId: e.taskId,
      url: e.url,
      filename: e.filename,
      directory: e.directory,
      updates: Updates.statusAndProgress,
    )).toList();
    _downloadManager.batchEnqueueDownloadTasks(downloadTasks);
  }

  @override
  Future<void> batchPauseDownload(List<String> taskIds) async {
    _downloadManager.batchPause(taskIds);
  }

  @override
  Future<void> batchRemoveDownload(List<String> taskIds) async {
    _downloadManager.removeDownload(taskIds);
  }

  @override
  Future<void> batchRestartDownload(List<DownloadTaskEntity> tasks) async {
    final downloadTasks = tasks.map((e) => DownloadTask(
      taskId: e.taskId,
      url: e.url,
      filename: e.filename,
      directory: e.directory,
    )).toList();
    _downloadManager.batchResume(downloadTasks);
  }

  @override
  Future<List<DownloadTaskNotes>> getAllDownloadTasks() async {
    return _downloadManager.getAllDownloadTasks();
  }

  @override
  Stream<TaskUpdate> getDownloadTaskStatusStream() {
    return _downloadManager.getTaskStatusStream();
  }

  @override
  Future<bool> pauseDownload(DownloadTaskEntity task) async {
    return _downloadManager.pauseDownload(DownloadTask(
      taskId: task.taskId,
      url: task.url,
      filename: task.filename,
      directory: task.directory,
    ));
  }

  @override
  Future<bool> resumeDownload(DownloadTaskEntity task) async {
    return _downloadManager.resumeDownload(DownloadTask(
      taskId: task.taskId,
      url: task.url,
      filename: task.filename,
      directory: task.directory,
      updates: Updates.statusAndProgress,
    ));
  }

  @override
  Future<bool> checkNetworkAndDownload(List<DownloadTaskEntity> tasks, {bool wifiOnly = false}) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      throw Exception('No network connection');
    }
    if (wifiOnly && connectivity != ConnectivityResult.wifi) {
      throw Exception('Wi^Fi required for download');
    }
    final downloadTasks = tasks.map((e) => DownloadTask(
      taskId: e.taskId,
      url: e.url,
      filename: e.filename,
      directory: e.directory,
      updates: Updates.statusAndProgress,
    )).toList();
    await _downloadManager.batchEnqueueDownloadTasks(downloadTasks);
    return true;
  }
}