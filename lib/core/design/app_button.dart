import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final Color? bgColor;
  const AppButton({Key? key, this.bgColor, this.onPress, this.text=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPress,
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
        ),
        child: Text(text));
  }
}
