import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  final double width; // Thuộc tính width của logo
  final double height; // Thuộc tính height của logo

  const AnimatedLogo({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController _borderController;
  late Animation<Color?> _borderColorAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _borderColorAnimation = ColorTween(
      begin: Colors.white,
      end: Color(0XFFF67C4A7),
    ).animate(_borderController);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _borderController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedBuilder(
        animation: _borderColorAnimation,
        builder: (context, child) {
          return Container(
            width: widget.width, // Sử dụng width từ thuộc tính của widget
            height: widget.height, // Sử dụng height từ thuộc tính của widget
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _borderColorAnimation.value ?? Colors.black,
                width: 5.0,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/V.jpg",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
