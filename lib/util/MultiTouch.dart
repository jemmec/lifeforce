import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef MultiTouchCallback = void Function(int touchCount);

class MultiTouchGesture extends MultiTapGestureRecognizer {
  MultiTouchCallback onMultiLongTap;
  MultiTouchCallback onMultiTap;
  var numberOfTouches = 0;

  MultiTouchGesture() {
    super.longTapDelay = Duration(milliseconds: 500);
    super.onLongTapDown = (pointer, details) => this.longTap(pointer, details);
    super.onTapDown = (pointer, details) => this.addTouch(pointer, details);
    super.onTapUp = (pointer, details) => this.removeTouch(pointer, details);
    super.onTapCancel = (pointer) => this.cancelTouch(pointer);
    super.onTap = (pointer) => this.captureDefaultTap(pointer);
  }

  void longTap(int pointer, TapDownDetails details) {
    if (this.numberOfTouches > 0) {
      this.onMultiLongTap(numberOfTouches);
    }
    this.numberOfTouches = 0;
  }

  void addTouch(int pointer, TapDownDetails details) {
    this.numberOfTouches++;
  }

  void removeTouch(int pointer, TapUpDetails details) {
    if (this.numberOfTouches > 0) {
      this.onMultiTap(numberOfTouches);
    }
    this.numberOfTouches = 0;
  }

  void cancelTouch(int pointer) {
    this.numberOfTouches = 0;
  }

  void captureDefaultTap(int pointer) {}

  @override
  set onLongTapDown(_onLongTapDown) {}

  @override
  set onTapDown(_onTapDown) {}

  @override
  set onTapUp(_onTapUp) {}

  @override
  set onTapCancel(_onTapCancel) {}

  @override
  set onTap(_onTap) {}
}

class MultiTouch extends StatefulWidget {
  final MultiTouchCallback onMultiLongTap;
  final MultiTouchCallback onMultiTouch;
  final Widget child;

  MultiTouch({this.child, this.onMultiTouch, this.onMultiLongTap});

  @override
  MultiTouchState createState() => MultiTouchState();
}

class MultiTouchState extends State<MultiTouch> with TickerProviderStateMixin {
  AnimationController buttonController;
  Animation<Color> buttonSequence;

  void onTap(int numberOfTouches) {
    widget.onMultiTouch(numberOfTouches);
  }

  void onLongTap(int numberOfTouches) {
    widget.onMultiLongTap(numberOfTouches);
  }

  @override
  void initState() {
    super.initState();

    buttonController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ))
      ..addListener(() {
        setState(() {});
      });

    buttonSequence = TweenSequence(<TweenSequenceItem<Color>>[
      TweenSequenceItem<Color>(
        tween: ColorTween(
          begin: Colors.transparent,
          end: Colors.black12,
        ).chain(
          CurveTween(
            curve: Curves.easeInQuad,
          ),
        ),
        weight: 20,
      ),
      TweenSequenceItem<Color>(
        tween: ColorTween(
          begin: Colors.black12,
          end: Colors.transparent,
        ).chain(
          CurveTween(
            curve: Curves.easeOutSine,
          ),
        ),
        weight: 80,
      ),
    ]).animate(buttonController);
  }

  void doButtonAnim() {
    buttonController.reset();
    buttonController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: buttonSequence.value,
      child: RawGestureDetector(
        gestures: {
          MultiTouchGesture:
              GestureRecognizerFactoryWithHandlers<MultiTouchGesture>(
            () => MultiTouchGesture(),
            (MultiTouchGesture instance) {
              instance.onMultiTap = (count) {
                doButtonAnim();
                this.onTap(count);
              };
              instance.onMultiLongTap = (count) {
                doButtonAnim();
                this.onLongTap(count);
              };
            },
          ),
        },
        child: widget.child,
      ),
    );
  }
}
