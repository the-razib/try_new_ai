import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onTogglePassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final VoidCallback? onSubmitted;
  final bool autofocus;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onTogglePassword,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
    this.onSubmitted,
    this.autofocus = false,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isFocused = false;
  bool _hasError = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: AppTextStyles.inputLabel,
          ),
          const SizedBox(height: 8),
        ],
        
        // Input Field Container
        Container(
          decoration: BoxDecoration(
            color: widget.enabled 
                ? AppColors.inputBackground 
                : AppColors.inputDisabled,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hasError
                  ? AppColors.error
                  : _isFocused
                      ? AppColors.primary
                      : AppColors.borderPrimary,
              width: _isFocused || _hasError ? 2 : 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && !widget.isPasswordVisible,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            style: widget.enabled 
                ? AppTextStyles.inputText 
                : AppTextStyles.inputText.copyWith(
                    color: AppColors.textDisabled,
                  ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.inputHint,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused
                          ? AppColors.primary
                          : AppColors.iconSecondary,
                      size: 20,
                    )
                  : null,
              suffixIcon: _buildSuffixIcon(),
              counterText: '',
            ),
            validator: (value) {
              final result = widget.validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _hasError = result != null;
                  _errorText = result;
                });
              });
              return result;
            },
            onChanged: (value) {
              if (_hasError) {
                setState(() {
                  _hasError = false;
                  _errorText = null;
                });
              }
            },
            onTap: () {
              setState(() {
                _isFocused = true;
              });
            },
            onTapOutside: (event) {
              setState(() {
                _isFocused = false;
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                _isFocused = false;
              });
              widget.onSubmitted?.call();
            },
          ),
        ),
        
        // Error Text
        if (_hasError && _errorText != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.error_outline,
                size: 14,
                color: AppColors.error,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _errorText!,
                  style: AppTextStyles.validationError,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        onPressed: widget.onTogglePassword,
        icon: Icon(
          widget.isPasswordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: _isFocused 
              ? AppColors.primary 
              : AppColors.iconSecondary,
          size: 20,
        ),
        splashRadius: 20,
      );
    }
    
    if (widget.suffixIcon != null) {
      return IconButton(
        onPressed: widget.onSuffixIconTap,
        icon: Icon(
          widget.suffixIcon,
          color: _isFocused 
              ? AppColors.primary 
              : AppColors.iconSecondary,
          size: 20,
        ),
        splashRadius: 20,
      );
    }
    
    return null;
  }
}

// Custom Input Field Variants for different use cases

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EmailInputField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: controller,
      label: 'Email',
      hintText: 'Enter your email address',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email_outlined,
      validator: validator ?? _defaultEmailValidator,
      textInputAction: TextInputAction.next,
    );
  }

  String? _defaultEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;

  const PasswordInputField({
    Key? key,
    required this.controller,
    this.label = 'Password',
    this.hintText = 'Enter your password',
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: widget.controller,
      label: widget.label,
      hintText: widget.hintText,
      isPassword: true,
      isPasswordVisible: _isPasswordVisible,
      onTogglePassword: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
      prefixIcon: Icons.lock_outline,
      validator: widget.validator ?? _defaultPasswordValidator,
      textInputAction: TextInputAction.done,
    );
  }

  String? _defaultPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;

  const SearchInputField({
    Key? key,
    required this.controller,
    this.hintText = 'Search...',
    this.onSearch,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: controller,
      label: '',
      hintText: hintText,
      prefixIcon: Icons.search_outlined,
      suffixIcon: controller.text.isNotEmpty ? Icons.clear : null,
      onSuffixIconTap: onClear ?? () => controller.clear(),
      textInputAction: TextInputAction.search,
      onSubmitted: onSearch,
    );
  }
}
