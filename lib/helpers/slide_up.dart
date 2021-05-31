import 'dart:async';
import 'package:flutter/material.dart';

class SlideUp extends StatefulWidget {
  final Widget child;
  final int delay;

  const SlideUp({required this.child, required this.delay, Key? key}) : super(key: key);

  @override
  _SlideUpState createState() => _SlideUpState();
}

class _SlideUpState extends State<SlideUp> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _offset = Tween<Offset>(begin: Offset(0.0, 0.35), end: Offset.zero).animate(curve);

    // ignore: unnecessary_null_comparison
    if(widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _offset,
        child: widget.child,
      ),
    );
  }
}
