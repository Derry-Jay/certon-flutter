import '../../helpers/helper.dart';
import 'custom_labelled_button.dart';
import 'package:flutter/material.dart';

class MyLabelledButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final bool? flag;
  final OutlinedBorder? shape;
  final VoidCallback? onPressed;
  final FontWeight? labelWeight;
  final EdgeInsetsGeometry? padding;
  final double? labelSize, elevation;
  const MyLabelledButton(
      {Key? key,
      this.flag,
      this.shape,
      this.padding,
      this.elevation,
      this.labelSize,
      this.onPressed,
      this.labelWeight,
      required this.type,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return CustomLabelledButton(
        type: type,
        label: label,
        shape: shape,
        padding: padding,
        elevation: elevation,
        labelSize: labelSize,
        onPressed: onPressed,
        labelWeight: labelWeight,
        labelColor: Colors.white,
        buttonColor:
            hp.theme.primaryColor.withOpacity((flag ?? false) ? 0.32 : 1.0));
  }
}
