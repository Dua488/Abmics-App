import 'package:flutter/material.dart';

class VAnimationLoading extends StatelessWidget {
  const VAnimationLoading({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
