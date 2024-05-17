import 'dart:async';
import '../widgets/empty_widget.dart';

import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatefulWidget {
  final Duration duration;
  final double? heightFactor, widthFactor, sizeFactor;
  final LoaderType? loaderType;
  final Color color;
  const CustomLoader(
      {Key? key,
      this.loaderType,
      this.sizeFactor,
      this.widthFactor,
      this.heightFactor,
      required this.color,
      required this.duration})
      : super(key: key);

  @override
  CustomLoaderState createState() => CustomLoaderState();
}

class CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animation;
  Screen screen = Screen();
  Helper get hp => Helper.of(context);
  double get length =>
      hp.radius / (widget.sizeFactor ?? (hp.factor * 8.388608));
  Timer get tm => Timer(widget.duration, moveForwardIfMounted);

  void refreshIfMounted() {
    try {
      if (mounted) setState(() {});
    } catch (e) {
      sendAppLog(e);
    }
  }

  void moveForwardIfMounted() async {
    try {
      if (mounted) {
        await _controller?.forward();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void listenAnimationStatus(AnimationStatus status) {
    try {
      if (status == AnimationStatus.dismissed ||
          status == AnimationStatus.completed) {
        _controller?.dispose();
      }
    } catch (e) {
      sendAppLog(e);
    }
  }

  void getData() {
    try {
      _controller = AnimationController(duration: widget.duration, vsync: this);
      CurvedAnimation curve = CurvedAnimation(
          parent: _controller ??
              AnimationController(duration: widget.duration, vsync: this),
          curve: Curves.easeOut);
      animation = Tween<double>(
              begin: hp.height / (widget.heightFactor ?? hp.factor), end: 0)
          .animate(curve)
        ..addListener(refreshIfMounted)
        ..addStatusListener(listenAnimationStatus);
    } catch (e) {
      sendAppLog(e);
    }
  }

  void assignState() async {
    await Future.delayed(Duration.zero, getData);
  }

  @override
  void initState() {
    super.initState();
    assignState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      Widget lc;
      switch (widget.loaderType) {
        case LoaderType.chasingDots:
          lc = SpinKitChasingDots(
              color: widget.color, duration: widget.duration, size: length);
          break;
        case LoaderType.circle:
          lc = SpinKitCircle(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.ring:
          lc = SpinKitRing(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.cubeGrid:
          lc = SpinKitCubeGrid(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.dancingSquare:
          lc = SpinKitDancingSquare(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.doubleBounce:
          lc = SpinKitDoubleBounce(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.dualRing:
          lc = SpinKitDualRing(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.fadingCircle:
          lc = SpinKitFadingCircle(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.fadingCube:
          lc = SpinKitFadingCube(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.fadingFour:
          lc = SpinKitFadingFour(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.fadingGrid:
          lc = SpinKitFadingGrid(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.foldingCube:
          lc = SpinKitFoldingCube(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.hourGlass:
          lc = SpinKitHourGlass(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.pouringHourGlass:
          lc = SpinKitPouringHourGlass(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.pulse:
          lc = SpinKitPulse(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.pumpingHeart:
          lc = SpinKitPumpingHeart(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.ripple:
          lc = SpinKitRipple(
              color: widget.color, duration: widget.duration, size: length);
          break;
        case LoaderType.rotatingCircle:
          lc = SpinKitRotatingCircle(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.rotatingPlain:
          lc = SpinKitRotatingPlain(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.spinningCircle:
          lc = SpinKitSpinningCircle(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.spinningLines:
          lc = SpinKitSpinningLines(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.squareCircle:
          lc = SpinKitSquareCircle(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.threeBounce:
          lc = SpinKitThreeBounce(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.wanderingCubes:
          lc = SpinKitWanderingCubes(
              color: widget.color, duration: widget.duration, size: length);
          break;
        case LoaderType.wave:
          lc = SpinKitWave(
              color: widget.color,
              duration: widget.duration,
              controller: _controller,
              size: length);
          break;
        case LoaderType.normal:
        default:
          lc = CircularProgressIndicator(color: widget.color);
          break;
      }
      return AnimatedOpacity(
          opacity: (animation?.value ?? 101) > 100.0
              ? 1.0
              : ((animation?.value ?? 1) / 100),
          duration: widget.duration,
          child: Center(
              widthFactor: widget.widthFactor,
              heightFactor: widget.heightFactor,
              child: lc));
    } catch (e) {
      sendAppLog(e);
      return const EmptyWidget();
    }
  }
}
