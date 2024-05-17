import 'package:flutter/material.dart';

class CustomDialogBoxWidget extends StatelessWidget {
  final Widget? child;
  final Duration duration;
  final double opacity;
  const CustomDialogBoxWidget( this.duration, this.opacity,
      {Key? key, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: opacity,
        duration: duration,
        child: AnimatedContainer(duration: duration, child: child));
  }
}
