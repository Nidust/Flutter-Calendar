import 'package:calendar_scheduler/styles.dart';
import 'package:calendar_scheduler/utils/datetime.dart';
import 'package:calendar_scheduler/widget/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.label,
    required this.width,
    required this.height,
    required this.onSubmitted,
  }) : super(key: key);

  final String label;
  final double? width;
  final double? height;
  final void Function(String value) onSubmitted;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.label,
            style: const TextStyle(color: AppColor.noonSun),
          ),
        ),

        // TextField
        Container(
          width: widget.width,
          height: widget.height,
          color: AppColor.noonSky,
          child: TextField(
            readOnly: true,
            controller: _controller,
            onTap: () async {
              DateTime? pickedDate = await showDialog<DateTime>(
                context: context,
                builder: (context) => _DatePickerDialog(
                  title: widget.label,
                  initialDate: kToday,
                  firstDate: kFirstDay,
                  lastDate: kLastDay,
                ),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);

                setState(() {
                  _controller.text = formattedDate;
                });

                widget.onSubmitted(_controller.text);
              }
            },
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.noonSun),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.noonSky),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DatePickerDialog extends StatefulWidget {
  const _DatePickerDialog({
    required this.title,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  final String title;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<_DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<_DatePickerDialog> {
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${widget.title} 선택"),
      content: Calendar(
        fontSize: 10.0,
        borderRadius: 3.0,
        spacing: 3.0,
        onDaySelected: (selectedDay) {
          setState(() {
            pickedDate = selectedDay;
          });
        },
      ),
      titlePadding: const EdgeInsets.only(
        left: 24.0,
        top: 24.0,
        bottom: 0.0,
        right: 0.0,
      ),
      contentPadding: const EdgeInsets.only(
        left: 24.0,
        top: 0.0,
        bottom: 0.0,
        right: 24.0,
      ),
      actionsPadding: const EdgeInsets.only(
        left: 24.0,
        top: 0.0,
        bottom: 10.0,
        right: 24.0,
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.noonCloud),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("취소"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.noonSun),
          onPressed: () {
            Navigator.pop(context, pickedDate);
          },
          child: const Text("확인"),
        ),
      ],
    );
  }
}
