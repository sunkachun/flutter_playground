import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/barcode/presentation/barcode_history_view.dart';
import 'package:flutter_playground/features/barcode/presentation/barcode_scanner_screen.dart';
import 'package:flutter_playground/features/barcode/presentation/cubit/barcode_cubit.dart';
import 'package:flutter_playground/features/download/presentation/screens/download_list_screen.dart';
import 'package:flutter_playground/features/entry/ButtonListPage.dart';
import 'package:flutter_playground/features/weather/presentation/page/weather_forecast_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

T? safelyTypeCast<T>(x) => x is T ? x : null;

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/buttonList',
    routes: [
      GoRoute(
        path: '/buttonList',
        name: 'buttonList',
        builder: (context, state) => ButtonListPage(),
      ),
      GoRoute(
        path: '/weather',
        name: 'weather',
        builder: (context, state) => const WeatherForecastPage(),
      ),
      GoRoute(
        path: '/download',
        name: 'download',
        builder: (context, state) => const DownloadListScreen(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const DownloadListScreen(),
      ),
      GoRoute(
        path: '/barcode',
        name: 'barcode',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => BarcodeCubit()..init(),
            child: BarcodeScannerView(),
          );
        },
      ),
      GoRoute(
        path: '/barcodeHistory',
        name: 'barcodeHistory',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => BarcodeCubit()..init(),
            child: BarcodeHistoryView(),
          );
        },
      ),
    ],
  );
});
