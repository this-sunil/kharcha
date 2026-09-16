import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kharcha/core/util/CustomText.dart';

class CustomAnimation extends StatelessWidget {
  final double amount;
  final TextStyle style;

  const CustomAnimation({
    super.key,
    required this.amount,
    required this.style
  });

  String _formatIndianNumber(double value) {
    final number = value.round().toString();

    if (number.length <= 3) {
      return number;
    }

    final lastThree = number.substring(number.length - 3);
    var remaining = number.substring(0, number.length - 3);

    final parts = <String>[];

    while (remaining.length > 2) {
      parts.insert(0, remaining.substring(remaining.length - 2));
      remaining = remaining.substring(0, remaining.length - 2);
    }

    if (remaining.isNotEmpty) {
      parts.insert(0, remaining);
    }

    return '${parts.join(',')},$lastThree';
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 0,
        end: amount,
      ),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      onEnd: (){
        log("End Animation");
      },
      builder: (context, value, child) {
        return CustomText(
          text: '₹${_formatIndianNumber(value)}',
          style: style,
        );
      },
    );
  }
}