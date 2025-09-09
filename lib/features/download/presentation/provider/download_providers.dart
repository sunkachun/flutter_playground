import 'package:flutter_playground/core/config/service_locator.dart';
import 'package:flutter_playground/features/download/data/model/download_task_notes.dart';
import 'package:flutter_playground/features/download/domain/download_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:background_downloader/background_downloader.dart';
import '../state/download_state.dart';


final downloadServiceProvider = Provider<DownloadRepository>((ref) => serviceLocator.get<DownloadRepository>());

final downloadStatusStreamProvider = StreamProvider<List<TaskUpdate>>((ref) async* {
  final service = ref.watch(downloadServiceProvider);
  yield* service.getDownloadTaskStatusStream().map((event) => [event]);
});

final downloadTasksProvider = FutureProvider<List<DownloadTaskNotes>>((ref) async {
  final service = ref.watch(downloadServiceProvider);
  return service.getAllDownloadTasks();
});