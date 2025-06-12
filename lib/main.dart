import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:room_reservation_app/data/database/database_service.dart';
import 'package:room_reservation_app/presentation/router/app_router.dart';
import 'package:timezone/data/latest_all.dart' as tz; 
import 'package:window_size/window_size.dart';

import 'locator/locator_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await initializeDateFormatting('ja_JP');
  final locatorSetup = LocatorSetup();
  await locatorSetup.initialize();
  setupWindow();
  tz.initializeTimeZones(); // ここでタイムゾーンデータをロード

  // アプリ初期化処理　初回のみSecureStorage削除
  //final AppInitializer initializer = AppInitializer();
  //await initializer.initializeApp();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// サイズを設定するメソッド
void setupWindow() {
  // webとプラットフォームをチェック
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // 画面情報を取得してウィンドウサイズを設定
    getScreenList().then((screenList) {
      if (screenList.isNotEmpty) {
        final screen = screenList.first;
        final size = screen.frame.size;

        setWindowTitle('ChronoLink');
        setWindowMinSize(Size(size.width - 200, size.height - 200));
        // ディスプレイサイズに基づいた最大ウィンドウサイズを設定
        setWindowMaxSize(Size(size.width, size.height));
        setWindowFrame(Rect.fromLTWH(
          (size.width - (size.width - 200)) / 2,
          (size.height - (size.height - 200)) / 2,
          size.width - 200,
          size.height - 200,
        ));
      }
    });
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // これを追加するだけ
      //  title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Hiragino Sans',
        // ダークモードのテーマ設定
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        // 他のテーマプロパティもここで設定可能
      ),
      themeMode: ThemeMode.dark,
      routerConfig: _appRouter.config(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', ''), // 日本語をサポート
      ],
      locale: const Locale('ja', ''), // 日本語をデフォルトに設定
    );
  }
}
