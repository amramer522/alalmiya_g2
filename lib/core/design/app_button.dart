import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onPress;
  final Color? bgColor;
  const AppButton({Key? key,this.isLoading =false, this.bgColor, this.onPress, this.text=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isLoading)
      {
        return Center(child: CircularProgressIndicator(),);
      }
    return FilledButton(
        onPressed: onPress,
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
        ),
        child: Text(text));
  }
}
