import 'dart:async';
import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/cupertino.dart';

import 'model/download_task_notes.dart';

class DownloadManager {
  final StreamController<TaskUpdate> _broadcastStream = StreamController<TaskUpdate>.broadcast();
  final StreamController<Task> _taskEnqueueFailedStream = StreamController<Task>.broadcast();
  final MemoryTaskQueue _taskQueue = MemoryTaskQueue();

  DownloadManager() {
    _init();
  }

  void _init() async {
    _taskQueue.maxConcurrent = 2;
    _taskQueue.maxConcurrentByGroup = 2;
    _taskQueue.maxConcurrentByHost = 3;
    _taskQueue.minInterval = const Duration(milliseconds: 10);
    FileDownloader().addTaskQueue(_taskQueue);

    FileDownloader().updates.listen((event) {
      _broadcastStream.add(event);
    });

    _taskQueue.enqueueErrors.listen((event) {
      _taskEnqueueFailedStream.add(event);
    });
  }

  Future<void> batchEnqueueDownloadTasks(List<DownloadTask> tasks) async {
    _taskQueue.addAll(tasks);
  }

  void batchPause(List<String> taskIds) async {
    FileDownloader().cancelTasksWithIds(taskIds);
    _taskQueue.removeTasksWithIds(taskIds);
  }

  Future<void> batchResume(List<DownloadTask> tasks) async {
    _taskQueue.addAll(tasks);
  }

  void removeDownload(List<String> taskIds) async {
    await FileDownloader().database.deleteRecordsWithIds(taskIds);
  }

  Future<void> cancelAll() async {
    final allTaskIds = await FileDownloader().allTaskIds();
    await FileDownloader().cancelTasksWithIds(allTaskIds);
    _taskQueue.removeAll();
    await FileDownloader().database.deleteAllRecords();
  }

  Future<List<DownloadTaskNotes>> getAllDownloadTasks() async {
    final records = await FileDownloader().database.allRecords();
    return records.map((e) => DownloadTaskNotes(
      task: e.task.taskToDownloadTask(),
      status: e.status,
      progress: e.progress,
      expectedFileSize: e.expectedFileSize,
      exception: e.exception,
    )).toList();
  }

  Future<bool> pauseDownload(DownloadTask task) async {
    return FileDownloader().pause(task);
  }

  Future<bool> resumeDownload(DownloadTask task) async {
    return FileDownloader().resume(task);
  }

  Stream<TaskUpdate> getTaskStatusStream() {
    return _broadcastStream.stream;
  }

  Stream<Task> getTaskEnqueueFailedStream() {
    return _taskEnqueueFailedStream.stream;
  }

  void updateDownloadNetworkSetting(RequireWiFi wifiSetting, bool reschedule) {
    FileDownloader().requireWiFi(wifiSetting, rescheduleRunningTasks: reschedule);
  }
}

extension DownloadTaskConverter on Task {
  DownloadTask taskToDownloadTask() {
    return DownloadTask(
      taskId: taskId,
      url: url,
      directory: directory,
      headers: headers,
      filename: filename,
      baseDirectory: baseDirectory,
      group: group,
      updates: updates,
      allowPause: allowPause,
      post: post,
      httpRequestMethod: httpRequestMethod,
      requiresWiFi: requiresWiFi,
      retries: retries,
      displayName: displayName,
      priority: priority,
      metaData: metaData,
      creationTime: creationTime,
    );
  }
}