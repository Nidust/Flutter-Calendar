import 'package:calendar_scheduler/styles.dart';
import 'package:calendar_scheduler/widget/schdule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'widget/calendar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 가로 모드 허용하지 않음.
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      fontFamily: "GmarketSans",
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColor.noonSun),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      home: Scaffold(
        key: scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Calendar(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addSchedule(scaffoldKey.currentContext!),
          tooltip: "스케줄 추가하기",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addSchedule(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          color: Colors.white,
          child: const SchduleDialog(),
        );
      },
    );
  }
}
