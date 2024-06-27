import 'package:flutter/material.dart';

class ScrollingText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  ScrollingText({
    required this.text,
    this.style,
    this.duration = const Duration(
        milliseconds: 5000), // Đặt duration dài hơn để chạy từ đầu đến cuối
  });

  @override
  _ScrollingTextState createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.repeat(
        reverse: true); // Lặp lại animation với reverse để chạy qua lại

    _controller.addListener(() {
      setState(() {}); // Cập nhật lại UI khi animation thay đổi
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Tính toán offset để chữ chạy từ trái sang phải
        final double screenWidth = MediaQuery.of(context).size.width;
        final double offset = _controller.value * screenWidth;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              Transform.translate(
                offset: Offset(offset, 0.0),
                child: Text(
                  widget.text,
                  style: widget.style,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
