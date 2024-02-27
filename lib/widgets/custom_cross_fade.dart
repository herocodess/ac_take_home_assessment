import 'package:flutter/material.dart';

/// This widget was designed to have an animated switch(fade) between two widgets
/// This specifies what child to show based on [CrossFadeState]
/// The widgets to switches between the skeleton loader [CustomShimmer] and the main widget to be rendered.

class CustomCrossFade extends StatelessWidget {
  const CustomCrossFade({
    Key? key,
    required this.state,
    required this.firstChild,
    this.secondChild = const SizedBox.shrink(),
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);
  final bool state;
  final Widget firstChild;
  final Widget secondChild;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState:
          state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
      firstChild: firstChild,
      secondChild: secondChild,
    );
  }
}
