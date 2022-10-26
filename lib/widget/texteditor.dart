import 'package:calendar_scheduler/styles.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  const TextEditor({
    Key? key,
    required this.label,
    this.width,
    this.height,
    required this.onSubmitted,
  }) : super(key: key);

  final String label;
  final double? width;
  final double? height;
  final void Function(String) onSubmitted;

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: const TextStyle(color: AppColor.noonSun),
        ),

        // Spacing
        const SizedBox(height: 5.0),

        GestureDetector(
          onTap: () {
            _focus.requestFocus();
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            color: AppColor.noonSky,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: TextField(
                  focusNode: _focus,
                  autofocus: false,
                  controller: _controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: AppColor.noonSun,
                  decoration: null,
                  onSubmitted: widget.onSubmitted,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
