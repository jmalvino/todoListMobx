import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double radius;
  final IconData iconData;
  final Function onTap;

  CustomIconButton({
    required this.radius,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(iconData),
        ),
      ),
    );
  }
}
