import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FileDownloader().configure(
    globalConfig: [
      (Config.requestTimeout, const Duration(seconds: 60)),
    ],
  );
  setupLocator();
  runApp(const ProviderScope(child: MyPlayground()));
}

class MyPlayground extends ConsumerWidget {
  const MyPlayground({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
        routerConfig: router,
        title: 'Playground',
    );
  }
}
