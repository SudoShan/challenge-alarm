import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<int> snooze_times = [5, 9, 15, 20, 30, 45];
List<int> check_awake_times = [5, 10, 15, 20, 30];

class PressShrinkButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PressShrinkButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  State<PressShrinkButton> createState() => _PressShrinkButtonState();
}

class _PressShrinkButtonState extends State<PressShrinkButton> {
  double _scale = 1.0;

  void _handleTapDown(TapDownDetails _) {
    setState(() {
      _scale = 0.85;
    });
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 80),
        child: widget.child,
      ),
    );
  }
}

class Challenge {
  final String name;
  final String description;
  final String imageUrl;
  final int optCount;
  final List<String> optNames;

  Challenge({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.optCount,
    required this.optNames,
  });
}