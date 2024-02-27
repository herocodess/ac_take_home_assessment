import 'package:acumen_technical_assessment/core/utils/images.dart';
import 'package:flutter/material.dart';

enum QuantityAction { increment, decrement }

class IncrementDecrementWidget extends StatelessWidget {
  const IncrementDecrementWidget({
    super.key,
    required this.action,
    required this.onTap,
  });
  final QuantityAction action;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: action == QuantityAction.increment
          ? Image.asset(
              AppImages.incrementButton,
              scale: 1.9,
            )
          : Image.asset(
              AppImages.decrementButton,
              scale: 1.9,
            ),
    );
  }
}
