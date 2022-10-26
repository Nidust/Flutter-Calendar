import 'package:calendar_scheduler/styles.dart';
import 'package:calendar_scheduler/utils/datetime.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    this.fontSize = 16.0,
    this.rowHeight = 52,
    this.spacing = 6.0,
    this.runSpacing = 6.0,
    this.borderRadius = 10.0,
    this.onDaySelected,
  });

  final double? fontSize;
  final double rowHeight;
  final double spacing;
  final double runSpacing;
  final double borderRadius;
  final void Function(DateTime? selectedDay)? onDaySelected;

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
      locale: 'ko-KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      rowHeight: widget.rowHeight,
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

      if (widget.onDaySelected != null) {
        widget.onDaySelected!(_selectedDay);
      }
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
    return const HeaderStyle(
      titleCentered: true,
      formatButtonVisible: false,
    );
  }

  CalendarStyle _renderStyle() {
    return CalendarStyle(
      isTodayHighlighted: false,
      cellMargin: EdgeInsets.symmetric(
        horizontal: widget.spacing,
        vertical: widget.runSpacing,
      ),
      defaultDecoration: BoxDecoration(
        color: AppColor.noonSky,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      weekendDecoration: BoxDecoration(
        color: AppColor.noonSky,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      selectedDecoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.noonSun,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      todayTextStyle: TextStyle(
        fontSize: widget.fontSize,
        color: const Color(0xFFFAFAFA),
      ),
      defaultTextStyle: TextStyle(
        fontSize: widget.fontSize,
      ),
      outsideTextStyle: TextStyle(
        fontSize: widget.fontSize,
        color: const Color(0xFFAEAEAE),
      ),
      weekendTextStyle: TextStyle(
        fontSize: widget.fontSize,
        color: const Color(0xFF5A5A5A),
      ),
      weekNumberTextStyle: TextStyle(
        fontSize: widget.fontSize,
        color: const Color(0xFFBFBFBF),
      ),
      selectedTextStyle: TextStyle(
        fontSize: widget.fontSize,
        color: AppColor.noonSun,
      ),
    );
  }
}
