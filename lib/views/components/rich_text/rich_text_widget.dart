import 'package:exam_instagram_clone_tut/views/components/rich_text/base_text.dart';
import 'package:exam_instagram_clone_tut/views/components/rich_text/link_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAll;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map(
          (baseText) {
            if (baseText is LinkText) {
              return TextSpan(
                text: baseText.text,
                style: styleForAll?.merge(baseText.style),
                recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
              );
            } else {
              return TextSpan(
                text: baseText.text,
                style: styleForAll?.merge(baseText.style),
              );
              //BaseText.plain(text: text);
            }
          },
        ).toList(),
      ),
    );
  }
}
