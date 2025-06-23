import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';

/// ForgotPasswordScreen - Password recovery interface
/// 
/// This screen provides a comprehensive password reset experience with:
/// - Email input for password recovery
/// - Professional validation and error handling
/// - Loading states with user feedback
/// - Success confirmation with next steps
/// - Navigation back to sign-in screen
/// - Professional UI/UX patterns
/// 
/// Features implemented:
/// - Email validation for password reset
/// - Loading states and user feedback
/// - Professional error handling with snackbars
/// - Success message with instructions
/// - Navigation integration ready
/// - Responsive design matching Figma specifications
/// - MVC architecture compliance (UI-only)
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  
  bool _isLoading = false;
  bool _isEmailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: _navigateBack,
        ),
        title: Text(
          'Reset Password',
          style: AppTextStyles.headingMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              if (!_isEmailSent) ...[
                _buildHeader(),
                const SizedBox(height: 40),
                _buildEmailForm(),
                const SizedBox(height: 32),
                _buildResetButton(),
              ] else ...[
                _buildSuccessContent(),
                const SizedBox(height: 32),
                _buildResendButton(),
              ],
              const SizedBox(height: 32),
              _buildBackToSignInPrompt(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password?',
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Don\'t worry! Enter your email address and we\'ll send you a link to reset your password.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailForm() {
    return Form(
      key: _formKey,
      child: CustomInputField(
        controller: _emailController,
        labelText: 'Email Address',
        hintText: 'Enter your email address',
        prefixIcon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email address';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildResetButton() {
    return CustomButton(
      text: 'Send Reset Link',
      onPressed: _handleResetPassword,
      buttonType: ButtonType.primary,
      size: ButtonSize.large,
      isLoading: _isLoading,
      prefixIcon: _isLoading
          ? null
          : Icon(
              Icons.email_outlined,
              size: 20,
              color: AppColors.whiteColor,
            ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.successColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.mark_email_read_outlined,
            size: 60,
            color: AppColors.successColor,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Check Your Email',
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text: 'We\'ve sent a password reset link to ',
              ),
              TextSpan(
                text: _emailController.text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(
                text: '. Please check your email and follow the instructions to reset your password.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.infoColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.infoColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.infoColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Didn\'t receive the email? Check your spam folder or try again.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.infoColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResendButton() {
    return CustomButton(
      text: 'Resend Email',
      onPressed: _handleResendEmail,
      buttonType: ButtonType.outline,
      size: ButtonSize.large,
      prefixIcon: Icon(
        Icons.refresh,
        size: 20,
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildBackToSignInPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Remember your password? ',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: _navigateToSignIn,
          child: Text(
            'Sign In',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleResetPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _isEmailSent = true;
        });
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password reset link sent successfully!',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.whiteColor),
            ),
            backgroundColor: AppColors.successColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      });
    }
  }

  void _handleResendEmail() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      
      // Show resend confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reset link resent to ${_emailController.text}',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.whiteColor),
          ),
          backgroundColor: AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    });
  }

  void _navigateBack() {
    if (_isEmailSent) {
      setState(() {
        _isEmailSent = false;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void _navigateToSignIn() {
    // TODO: Navigate to sign in screen
    // Navigator.pushReplacementNamed(context, '/signin');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Navigation to Sign In screen',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
