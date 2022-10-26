import 'package:calendar_scheduler/models/schdule.dart';
import 'package:calendar_scheduler/styles.dart';
import 'package:flutter/material.dart';

import 'datepicker.dart';
import 'texteditor.dart';

class SchduleDialog extends StatefulWidget {
  const SchduleDialog({super.key});

  @override
  State<SchduleDialog> createState() => _SchduleDialogState();
}

class _SchduleDialogState extends State<SchduleDialog> {
  DateTime? _startDay;
  DateTime? _endDay;
  String? _contents;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 시간 설정
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 시작 시간
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: DatePicker(
                label: "시작 시간",
                width: 170,
                height: 40,
                onSubmitted: (value) {
                  setState(() {
                    _startDay = DateTime.parse(value);
                  });
                },
              ),
            ),
            // 마감 시간
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: DatePicker(
                label: "마감 시간",
                width: 170,
                height: 40,
                onSubmitted: (value) {
                  setState(() {
                    _endDay = DateTime.parse(value);
                  });
                },
              ),
            ),
          ],
        ),

        // 내용
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextEditor(
            label: "내용",
            width: double.maxFinite,
            height: 150,
            onSubmitted: (value) {
              _contents = value;
            },
          ),
        ),

        // 저장
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.noonSun,
              ),
              onPressed: () {
                if (_startDay == null || _endDay == null || _contents == null) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(
                    context,
                    Schdule(
                      startDay: _startDay!,
                      endDay: _endDay!,
                      title: _contents!,
                    ),
                  );
                }
              },
              child: const Text("저장"),
            ),
          ),
        ),
      ],
    );
  }
}
