import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

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

class MultiTouchState extends State<MultiTouch> {
  void onTap(int numberOfTouches) {
    widget.onMultiTouch(numberOfTouches);
  }

  void onLongTap(int numberOfTouches) {
    widget.onMultiLongTap(numberOfTouches);
  }

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        MultiTouchGesture:
            GestureRecognizerFactoryWithHandlers<MultiTouchGesture>(
          () => MultiTouchGesture(),
          (MultiTouchGesture instance) {
            instance.onMultiTap = (count) {
              this.onTap(count);
            };
            instance.onMultiLongTap = (count) {
              this.onLongTap(count);
            };
          },
        ),
      },
      child: widget.child,
    );
  }
}
