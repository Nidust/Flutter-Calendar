import 'package:calendar_scheduler/models/schdule.dart';
import 'package:calendar_scheduler/styles.dart';
import 'package:calendar_scheduler/utils/datetime.dart';
import 'package:calendar_scheduler/widget/schdule_dialog.dart';
import 'package:calendar_scheduler/widget/schduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

import 'widget/calendar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 가로 모드 허용하지 않음.
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _schduleList = <Schdule>[];
  DateTime? _selectedDay = kToday;

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
        key: _scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Calendar(
              spacing: 3.0,
              runSpacing: 3.0,
              rowHeight: 40,
              onDaySelected: (selectedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
            Schduler(
              selectedDay: _selectedDay,
              schduleList: _selectedDay != null
                  ? _schduleList.where(
                      (schdule) {
                        bool isSame =
                            isSameDay(schdule.startDay, _selectedDay) ||
                                isSameDay(schdule.endDay, _selectedDay);
                        bool isBetween =
                            schdule.startDay.isBefore(_selectedDay!) &&
                                schdule.endDay.isAfter(_selectedDay!);

                        return isSame || isBetween;
                      },
                    ).toList()
                  : <Schdule>[],
              onDismissed: (index) {
                setState(() {
                  _schduleList.removeAt(index);
                });
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addSchedule(_scaffoldKey.currentContext!),
          tooltip: "스케줄 추가하기",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addSchedule(BuildContext context) async {
    Schdule? schdule = await showModalBottomSheet<Schdule>(
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          color: Colors.white,
          child: const SchduleDialog(),
        );
      },
    );

    if (schdule != null) {
      setState(() {
        _schduleList.add(schdule);
      });
    }
  }
}
