import 'package:calendar_scheduler/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'page/calendar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 가로 모드 허용하지 않음.
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Calendar(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: "추가하기",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
