import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/social_login_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                
                // Header Section
                _buildHeader(),
                
                const SizedBox(height: 48),
                
                // Email Input
                CustomInputField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  prefixIcon: Icons.email_outlined,
                ),
                
                const SizedBox(height: 20),
                
                // Password Input
                CustomInputField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onTogglePassword: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  validator: _validatePassword,
                  prefixIcon: Icons.lock_outline,
                ),
                
                const SizedBox(height: 16),
                
                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _onForgotPasswordTap,
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.forgotPasswordLink,
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Sign In Button
                CustomButton(
                  text: 'Sign In',
                  onPressed: _isLoading ? null : _onSignInTap,
                  isLoading: _isLoading,
                  width: double.infinity,
                ),
                
                const SizedBox(height: 32),
                
                // Divider
                _buildDivider(),
                
                const SizedBox(height: 32),
                
                // Social Login Buttons
                _buildSocialLoginButtons(),
                
                const SizedBox(height: 48),
                
                // Sign Up Link
                _buildSignUpLink(),
                
                const SizedBox(height: 32),
              ],
            ),
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
          'Welcome Back!',
          style: AppTextStyles.welcomeTitle,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to your account',
          style: AppTextStyles.welcomeSubtitle,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.borderPrimary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.borderPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Column(
      children: [
        SocialLoginButton(
          text: 'Continue with Google',
          iconAsset: 'assets/icons/google.svg',
          onPressed: _onGoogleSignInTap,
          backgroundColor: AppColors.white,
          textColor: AppColors.textPrimary,
          borderColor: AppColors.borderPrimary,
        ),
        const SizedBox(height: 16),
        SocialLoginButton(
          text: 'Continue with Apple',
          iconAsset: 'assets/icons/apple.svg',
          onPressed: _onAppleSignInTap,
          backgroundColor: AppColors.socialApple,
          textColor: AppColors.white,
          borderColor: AppColors.socialApple,
        ),
        const SizedBox(height: 16),
        SocialLoginButton(
          text: 'Continue with Facebook',
          iconAsset: 'assets/icons/facebook.svg',
          onPressed: _onFacebookSignInTap,
          backgroundColor: AppColors.socialFacebook,
          textColor: AppColors.white,
          borderColor: AppColors.socialFacebook,
        ),
      ],
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: AppTextStyles.signUpPrompt,
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: _onSignUpTap,
                child: Text(
                  'Sign Up',
                  style: AppTextStyles.signUpLink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Validation Methods
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Action Methods
  void _onSignInTap() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        
        // Navigate to home screen or show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in successful!'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  void _onForgotPasswordTap() {
    // Navigate to forgot password screen
    Navigator.pushNamed(context, '/forgot-password');
  }

  void _onGoogleSignInTap() {
    // Handle Google sign in
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Sign In pressed')),
    );
  }

  void _onAppleSignInTap() {
    // Handle Apple sign in
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Apple Sign In pressed')),
    );
  }

  void _onFacebookSignInTap() {
    // Handle Facebook sign in
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Facebook Sign In pressed')),
    );
  }

  void _onSignUpTap() {
    // Navigate to sign up screen
    Navigator.pushNamed(context, '/signup');
  }
}
