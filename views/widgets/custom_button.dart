import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// CustomButton - A versatile button widget for the workout app
/// 
/// This widget provides multiple button variants with consistent styling:
/// - Primary button (main action button)
/// - Secondary button (alternative actions)
/// - Outline button (ghost/outlined style)
/// - Text button (minimal style)
/// - Social login button (with icon support)
/// 
/// Features:
/// - Gradient backgrounds matching app theme
/// - Loading states with spinner
/// - Icon support (prefix/suffix)
/// - Multiple sizes (small, medium, large)
/// - Disabled states
/// - Custom width and height options
/// - Proper accessibility support
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.width,
    this.height,
    this.isLoading = false,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.elevation = 0,
    this.gradient,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final ButtonSize size;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool isEnabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double elevation;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? _getButtonWidth(),
      height: height ?? _getButtonHeight(),
      child: _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    switch (buttonType) {
      case ButtonType.primary:
        return _buildPrimaryButton(context);
      case ButtonType.secondary:
        return _buildSecondaryButton(context);
      case ButtonType.outline:
        return _buildOutlineButton(context);
      case ButtonType.text:
        return _buildTextButton(context);
      case ButtonType.social:
        return _buildSocialButton(context);
    }
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.2),
                  blurRadius: elevation,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: _getOnPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
          ),
          padding: _getButtonPadding(),
        ),
        child: _buildButtonChild(
          textColor ?? AppColors.whiteColor,
          _getTextStyle().copyWith(color: textColor ?? AppColors.whiteColor),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _getOnPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.secondaryColor,
        foregroundColor: textColor ?? AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
        ),
        padding: _getButtonPadding(),
        elevation: elevation,
      ),
      child: _buildButtonChild(
        textColor ?? AppColors.whiteColor,
        _getTextStyle().copyWith(color: textColor ?? AppColors.whiteColor),
      ),
    );
  }

  Widget _buildOutlineButton(BuildContext context) {
    return OutlinedButton(
      onPressed: _getOnPressed(),
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        foregroundColor: textColor ?? AppColors.primaryColor,
        side: BorderSide(
          color: borderColor ?? AppColors.primaryColor,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
        ),
        padding: _getButtonPadding(),
        elevation: elevation,
      ),
      child: _buildButtonChild(
        textColor ?? AppColors.primaryColor,
        _getTextStyle().copyWith(color: textColor ?? AppColors.primaryColor),
      ),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: _getOnPressed(),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        foregroundColor: textColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
        ),
        padding: _getButtonPadding(),
        elevation: elevation,
      ),
      child: _buildButtonChild(
        textColor ?? AppColors.primaryColor,
        _getTextStyle().copyWith(color: textColor ?? AppColors.primaryColor),
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.whiteColor,
        border: Border.all(
          color: borderColor ?? AppColors.borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _getOnPressed(),
          borderRadius: BorderRadius.circular(borderRadius ?? _getBorderRadius()),
          child: Container(
            padding: _getButtonPadding(),
            child: _buildButtonChild(
              textColor ?? AppColors.textPrimary,
              _getTextStyle().copyWith(color: textColor ?? AppColors.textPrimary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonChild(Color iconColor, TextStyle textStyle) {
    if (isLoading) {
      return SizedBox(
        width: _getLoadingSize(),
        height: _getLoadingSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(iconColor),
        ),
      );
    }

    List<Widget> children = [];

    if (prefixIcon != null) {
      children.add(prefixIcon!);
      children.add(const SizedBox(width: 8));
    }

    children.add(
      Text(
        text,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );

    if (suffixIcon != null) {
      children.add(const SizedBox(width: 8));
      children.add(suffixIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  VoidCallback? _getOnPressed() {
    if (!isEnabled || isLoading) return null;
    return onPressed;
  }

  double _getButtonWidth() {
    switch (size) {
      case ButtonSize.small:
        return 120;
      case ButtonSize.medium:
        return 200;
      case ButtonSize.large:
        return double.infinity;
    }
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case ButtonSize.small:
        return 8;
      case ButtonSize.medium:
        return 12;
      case ButtonSize.large:
        return 16;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTextStyles.buttonSmall;
      case ButtonSize.medium:
        return AppTextStyles.buttonMedium;
      case ButtonSize.large:
        return AppTextStyles.buttonLarge;
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }
}

/// Button type enumeration
enum ButtonType {
  primary,
  secondary,
  outline,
  text,
  social,
}

/// Button size enumeration
enum ButtonSize {
  small,
  medium,
  large,
}

/// SocialLoginButton - Specialized button for social authentication
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.textColor,
    this.borderColor,
    this.isLoading = false,
    this.width,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final Widget icon;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      buttonType: ButtonType.social,
      size: ButtonSize.large,
      width: width,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      isLoading: isLoading,
      prefixIcon: icon,
    );
  }
}
