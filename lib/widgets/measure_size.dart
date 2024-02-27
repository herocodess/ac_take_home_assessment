import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// The [MeasureSize] widget is a custom widget designed to detect and notify when the size of its child widget
/// changes. It wraps a child widget, monitors its size after layout adjustments, and triggers a callback (onChange)
/// with the new size whenever a change is detected.
/// This is useful for scenarios where you need to perform actions based on the size of a widget
/// such as adjusting layouts or triggering animations

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    super.key,
    required this.onChange,
    required this.child,
  });

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize!);
  }
}
