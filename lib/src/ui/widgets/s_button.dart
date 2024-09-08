import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myskin_flutterbytes/src/utilities/responsive_dimension.dart';

import 's_text_widget.dart';

//A button widget to be used throughout the application. It is useful when
//creating a Widget object that is to perform an action.

class SButton extends StatefulWidget {
  const SButton(
      {super.key,
      required this.label,
      this.fct,
      // required this.color,
      this.withWidth,
      this.width,
      this.borderColor,
      this.textColor,
      this.horizontalPadding,
      this.verticalPadding,
      this.icon,
      this.iconColor,
      this.isPrefixPresent = false,
      this.prefixWidget,
      this.buttonWidget});
  final String label;
  final VoidCallback? fct;
  // final Color color;
  final bool? withWidth;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final IconData? icon;
  final Color? iconColor;
  final bool isPrefixPresent;
  final Widget? prefixWidget;
  final Widget? buttonWidget;

  @override
  State<SButton> createState() => _SButtonState();
}

class _SButtonState extends State<SButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        HapticFeedback.lightImpact();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
          if (widget.fct != null) {
            widget.fct!();
          }
        });
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 0.95,
        ).animate(_controller),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          height: ResponsiveDimension.height(0.058, context),
          width: widget.width ?? double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding ?? 10,
            vertical: widget.verticalPadding ?? 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor,
          ),
          child: widget.buttonWidget ??
              TextWidget(
                textAlign: TextAlign.center,
                text: widget.label,
                fontWeight: FontWeight.w500,
                fontsize: 14,
                color: widget.textColor ?? Colors.white,
              ),
        ),
      ),
    );
  }
}
