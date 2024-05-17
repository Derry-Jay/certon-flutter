import '../empty_widget.dart';
import '../../helpers/helper.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final ButtonType type;
  final double? elevation;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor, labelColor;
  final VoidCallback? onPressed, onLongPress;
  const CustomButton(
      {Key? key,
      this.child,
      this.shape,
      this.padding,
      this.elevation,
      this.onPressed,
      this.labelColor,
      this.buttonColor,
      this.onLongPress,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final style = ButtonStyle(
        elevation: MaterialStateProperty.all<double?>(elevation),
        shape: MaterialStateProperty.all<OutlinedBorder?>(shape),
        foregroundColor: MaterialStateProperty.all<Color?>(labelColor),
        backgroundColor: MaterialStateProperty.all<Color?>(buttonColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(padding));
    switch (type) {
      case ButtonType.raised:
        return ElevatedButton(
            style: style,
            onPressed: onPressed,
            onLongPress: onLongPress,
            child: child);
      case ButtonType.border:
        return OutlinedButton(
            style: style,
            onPressed: onPressed,
            onLongPress: onLongPress,
            child: child ?? const EmptyWidget());
      case ButtonType.text:
        return TextButton(
            style: style,
            onPressed: onPressed,
            onLongPress: onLongPress,
            child: child ?? const EmptyWidget());
    }
  }
}
