import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget? child;
  final double radiusValue;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? radius;

  const RoundedContainer({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.radiusValue = 10,
    this.color,
    this.radius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius ?? BorderRadius.circular(radiusValue),
      ),
      child: child,
    );
  }
}