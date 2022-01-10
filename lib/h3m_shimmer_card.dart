library h3m_shimmer_card;

import 'package:flutter/material.dart';

class ShimmerCard extends StatefulWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final Duration animationDuration;
  final Color backgroundColor;
  final Color shimmerColor;
  final Alignment beginAlignment;
  final Alignment endAlignment;

  ///
  ///```dart
  ///
  ///ShimmerCard(
  ///  width: 200,
  ///  height: 100,
  ///  beginAlignment: Alignment.topLeft,
  ///  endAlignment: Alignment.bottomRight,
  ///  backgroundColor: Colors.grey.shade800,
  ///  shimmerColor: Colors.grey.shade700,
  ///),
  ///
  /// ```
  ///

  const ShimmerCard({
    Key? key,
    this.height,
    this.width,
    this.borderRadius = 4,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.backgroundColor = const Color(0xFFE5E5E5),
    this.shimmerColor = const Color(0xFFF0F0F0),
    this.beginAlignment = Alignment.centerLeft,
    this.endAlignment = Alignment.centerRight,
  }) : super(key: key);

  @override
  _ShimmerCardState createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<ShimmerCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Color _backgroudColor, _shimmerColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.animationDuration)
      ..addListener(
        () {
          if (mounted) {
            if (_animationController.isCompleted) {
              _animationController.reset();
              _animationController.forward();
            }
          }
        },
      );
    _initAnimation();
    _backgroudColor = widget.shimmerColor;
    _shimmerColor = widget.backgroundColor;
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant ShimmerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.backgroundColor != widget.backgroundColor) {
      _shimmerColor = widget.backgroundColor;
    }
    if ((widget.animationDuration != oldWidget.animationDuration)) {
      _initAnimation();
    }
  }

  void _initAnimation() {
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            painter: _ShimmerCardPainter(
              backgroundColor: _shimmerColor,
              shimmerColor: _backgroudColor,
              progress: _animation.value,
              beginAlignment: widget.beginAlignment,
              endAlignment: widget.endAlignment,
            ),
            size: Size(widget.width ?? double.maxFinite, widget.height ?? double.maxFinite),
          );
        },
      ),
    );
  }
}

class _ShimmerCardPainter extends CustomPainter {
  final Color backgroundColor;
  final Color shimmerColor;
  final double progress;
  final Alignment beginAlignment;
  final Alignment endAlignment;

  const _ShimmerCardPainter({
    required this.beginAlignment,
    required this.endAlignment,
    required this.backgroundColor,
    required this.shimmerColor,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;

    var paint = Paint()
      ..shader = LinearGradient(
        colors: [backgroundColor, shimmerColor, backgroundColor],
        begin: beginAlignment,
        end: endAlignment,
      ).createShader(
        Rect.fromCenter(
          center: Offset(width * progress, height * progress),
          width: width,
          height: height,
        ),
      );
    var path = Path()
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
