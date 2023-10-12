import 'package:flutter/material.dart';
import 'package:fwc_album_app/app/core/ui/styles/colors_app.dart';

class RoundedButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const RoundedButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(.2),
      shape: const CircleBorder(),
      child: DecoratedBox(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: IconButton(
          icon: Icon(
            icon,
            color: context.colors.darkGrey,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
