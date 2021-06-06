import 'package:flutter/material.dart';

class GlobalActionButton extends StatelessWidget {
  final String action;
  final VoidCallback onPressed;

  const GlobalActionButton({
    Key? key,
    required this.action,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Colors.orange,
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          action,
          style: Theme.of(context).textTheme.button,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
