import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;
  final String tooltip;

  const CircleButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.iconSize,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      iconSize: iconSize ?? 24,
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}
