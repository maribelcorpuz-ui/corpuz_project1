import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final double height;
  final double? width;
  final double borderRadius;
  final bool outlined;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.color,
    this.textColor,
    this.icon,
    this.height = 52,
    this.width = double.infinity,
    this.borderRadius = 12,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    // Default colors (inline na, wala nay AppColors)
    const Color defaultPrimary = Color(0xFFE91E63);
    const Color defaultWhite = Colors.white;

    final bgColor = color ?? defaultPrimary;
    final fgColor = textColor ?? defaultWhite;
    final isButtonDisabled = isDisabled || isLoading || onPressed == null;

    // OUTLINED VARIANT
    if (outlined) {
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: isButtonDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: bgColor,
            side: BorderSide(color: bgColor, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: _buildChild(fgColor: bgColor),
        ),
      );
    }

    // FILLED VARIANT (default)
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isButtonDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          disabledBackgroundColor: bgColor.withOpacity(0.5),
          disabledForegroundColor: fgColor.withOpacity(0.7),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildChild(fgColor: fgColor),
      ),
    );
  }

  Widget _buildChild({required Color fgColor}) {
    if (isLoading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: fgColor,
          strokeWidth: 2.5,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: fgColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: fgColor,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: fgColor,
      ),
    );
  }
}