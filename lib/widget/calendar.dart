import 'package:calendar_scheduler/styles.dart';
import 'package:calendar_scheduler/utils/datetime.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: _selectedDayPredicate,
      onDaySelected: _onDaySelected,
      onFormatChanged: _onFormatChanged,
      onPageChanged: _onPageChanged,
      headerStyle: _renderHeaderStyle(),
      calendarStyle: _renderStyle(),
    );
  }

  bool _selectedDayPredicate(day) {
    return isSameDay(_selectedDay, day);
  }

  void _onDaySelected(selectedDay, focusedDay) {
    if (isSameDay(_selectedDay, selectedDay) == false) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _onFormatChanged(format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  void _onPageChanged(focusedDay) {
    _focusedDay = focusedDay;
  }

  HeaderStyle _renderHeaderStyle() {
    return HeaderStyle(
      titleCentered: true,
      formatButtonVisible: false,
      titleTextFormatter: (date, locale) {
        return DateFormat("yyyy년 MM월").format(date);
      },
    );
  }

  CalendarStyle _renderStyle() {
    return CalendarStyle(
      isTodayHighlighted: false,
      defaultDecoration: const BoxDecoration(
        color: AppColor.noonSky,
        shape: BoxShape.rectangle,
      ),
      weekendDecoration: const BoxDecoration(
        color: AppColor.noonSky,
        shape: BoxShape.rectangle,
      ),
      selectedDecoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.noonSun,
        ),
        shape: BoxShape.rectangle,
      ),
      selectedTextStyle: const TextStyle(
        color: AppColor.noonSun,
      ),
    );
  }
}
