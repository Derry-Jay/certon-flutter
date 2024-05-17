import 'custom_button.dart';
import '../../helpers/helper.dart';
import 'package:flutter/material.dart';

class CustomLabelledButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final OutlinedBorder? shape;
  final VoidCallback? onPressed;
  final FontWeight? labelWeight;
  final EdgeInsetsGeometry? padding;
  final double? labelSize, elevation;
  final Color? buttonColor, labelColor;
  const CustomLabelledButton(
      {Key? key,
      this.shape,
      this.padding,
      this.onPressed,
      this.elevation,
      this.labelSize,
      this.labelColor,
      this.buttonColor,
      this.labelWeight,
      required this.type,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final child = Text(label,
        style: TextStyle(fontWeight: labelWeight, fontSize: labelSize));
    return CustomButton(
        type: type,
        shape: shape,
        padding: padding,
        onPressed: onPressed,
        elevation: elevation,
        labelColor: labelColor,
        buttonColor: buttonColor,
        child: child);
  }
}
