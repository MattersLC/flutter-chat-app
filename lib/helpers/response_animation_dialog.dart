import 'dart:ui';

import 'package:flutter/material.dart';

class ResponseAnimationDialog extends StatefulWidget {
  final Color mainColor;
  final Color backgroundColor;
  final IconData icon;
  const ResponseAnimationDialog({
    required this.mainColor,
    required this.backgroundColor,
    required this.icon,
    super.key
  });

  @override
  State<ResponseAnimationDialog> createState() => _ResponseAnimationDialogState();
}

class _ResponseAnimationDialogState extends State<ResponseAnimationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _visible = true;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        //backgroundColor: Colors.green.shade100.withOpacity(0.7),
        backgroundColor: widget.backgroundColor.withOpacity(0.7),
        surfaceTintColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 800),
              opacity: _visible ? 1.0 : 0.0,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.mainColor,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}