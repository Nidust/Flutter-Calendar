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
                onSubmitted: (value) {},
              ),
            ),
            // 마감 시간
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: DatePicker(
                label: "마감 시간",
                width: 170,
                height: 40,
                onSubmitted: (value) {},
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
            height: 170,
            onSubmitted: (value) {},
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
                Navigator.pop(context);
              },
              child: const Text("저장"),
            ),
          ),
        ),
      ],
    );
  }
}
