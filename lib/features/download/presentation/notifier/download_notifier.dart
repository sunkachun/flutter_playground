import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_playground/core/config/service_locator.dart';
import 'package:flutter_playground/features/download/data/model/download_task_notes.dart';
import 'package:flutter_playground/features/download/domain/download_repository.dart';
import 'package:flutter_playground/features/download/domain/entity/download_task_entity.dart';
import 'package:flutter_playground/features/download/domain/usecase/pause_download_use_case.dart';
import 'package:flutter_playground/features/download/domain/usecase/remove_download_use_case.dart';
import 'package:flutter_playground/features/download/domain/usecase/resume_download_use_case.dart';
import 'package:flutter_playground/features/download/domain/usecase/start_download_use_case.dart';
import 'package:flutter_playground/features/download/presentation/state/download_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadNotifier extends StateNotifier<DownloadState> {
  final StartDownloadUseCase _startDownloadUseCase;
  final PauseDownloadUseCase _pauseDownloadUseCase;
  final ResumeDownloadUseCase _resumeDownloadUseCase;
  final RemoveDownloadUseCase _removeDownloadUseCase;
  final DownloadTaskEntity _task;
  StreamSubscription<TaskUpdate>? _streamSubscription;

  DownloadNotifier(this._task)
      : _startDownloadUseCase = serviceLocator.get<StartDownloadUseCase>(),
        _pauseDownloadUseCase = serviceLocator.get<PauseDownloadUseCase>(),
        _resumeDownloadUseCase = serviceLocator.get<ResumeDownloadUseCase>(),
        _removeDownloadUseCase = serviceLocator.get<RemoveDownloadUseCase>(),
        super(DownloadState(taskId: _task.taskId)) {
    _init();
  }

  void _init() async {
    final tasks = await serviceLocator.get<DownloadRepository>().getAllDownloadTasks();
    final taskRecord = tasks.firstWhere(
          (record) => record.task.taskId == _task.taskId,
      orElse: () => DownloadTaskNotes(
        task: DownloadTask(
          taskId: _task.taskId,
          url: _task.url,
          filename: _task.filename,
          directory: _task.directory,
        ),
        status: TaskStatus.enqueued,
        progress: 0.0,
        expectedFileSize: 0,
        exception: null,
      ),
    );
    state = state.copyWith(
      status: _mapToStatus(taskRecord.status),
      progress: taskRecord.progress,
    );

    _streamSubscription = serviceLocator.get<DownloadRepository>().getDownloadTaskStatusStream().listen((update) {
      if (update.task.taskId == _task.taskId) {
        if (update is TaskProgressUpdate) {
          state = state.copyWith(
            progress: update.progress,
            status: DownloadStatus.downloading,
          );
        } else if (update is TaskStatusUpdate) {
          state = state.copyWith(
            progress: state.progress,
            status: _mapToStatus(update.status),
          );
        }
      }
    });
  }

  Future<void> startDownload() async {
    try {
      await _startDownloadUseCase.execute([_task]);
      state = state.copyWith(status: DownloadStatus.downloading);
    } catch (e) {
      state = state.copyWith(status: DownloadStatus.failed, error: e.toString());
    }
  }

  Future<void> pauseDownload() async {
    await _pauseDownloadUseCase.execute(_task);
    state = state.copyWith(status: DownloadStatus.paused);
  }

  Future<void> resumeDownload() async {
    await _resumeDownloadUseCase.execute(_task);
    state = state.copyWith(status: DownloadStatus.downloading);
  }

  Future<void> removeDownload() async {
    await _removeDownloadUseCase.execute([_task.taskId]);
    state = state.copyWith(status: DownloadStatus.initial, progress: 0.0, error: null);
  }

  DownloadStatus _mapToStatus(TaskStatus status) {
    switch (status) {
      case TaskStatus.running:
        return DownloadStatus.downloading;
      case TaskStatus.paused:
        return DownloadStatus.paused;
      case TaskStatus.complete:
        return DownloadStatus.completed;
      case TaskStatus.failed:
        return DownloadStatus.failed;
      default:
        return DownloadStatus.initial;
    }
  }

  Future<void> openFile() async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDocDir.path}/${_task.directory}/${_task.filename}';
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        state = state.copyWith(
          status: DownloadStatus.failed,
          error: 'Failed to open file: ${result.message}',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: DownloadStatus.failed,
        error: 'Failed to open file: $e',
      );
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

final downloadProvider = StateNotifierProvider.family<DownloadNotifier, DownloadState, DownloadTaskEntity>(
      (ref, task) => DownloadNotifier(task),
);