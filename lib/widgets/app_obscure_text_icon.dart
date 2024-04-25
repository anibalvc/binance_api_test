import 'package:flutter/material.dart';

class AppObscureTextIcon extends StatelessWidget {
  const AppObscureTextIcon({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: const Color.fromARGB(255, 230, 224, 224),
      ),
      onPressed: onPressed,
    );
  }
}
