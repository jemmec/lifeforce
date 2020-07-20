import 'package:flutter/material.dart';

class FlashText extends ImplicitlyAnimatedWidget {
  final String text;
  final double fontSize;
  final Color flashColor;
  final Color color;

  FlashText({
    @required this.text,
    @required this.flashColor,
    @required this.color,
    @required Duration duration,
    Key key,
    this.fontSize,
  }) : super(key: key, duration: duration);

  @override
  _LifeTextState createState() => _LifeTextState();
}

class _LifeTextState extends AnimatedWidgetBaseState<FlashText> {
  FlashColorTween _cTween;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.text}',
      style: TextStyle(
        color: _cTween.evaluate(animation),
        fontSize: widget.fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _cTween = visitor(
      _cTween,
      widget.color,
      (color) => FlashColorTween(begin: color, flash: widget.flashColor),
    );
  }
}

class FlashColorTween extends Tween<Color> {
  final Color flash;

  FlashColorTween({Color begin, Color end, this.flash})
      : super(begin: begin, end: end);

  Color lerp(double t) {
    if (t < 0.25) {
      return begin;
    } else if (t >= 0.25 && t < 0.75) {
      return Colors.purple;
    } else {
      return begin;
    }
  }
}
