import 'package:climax_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/themes.dart';
import '../../../../shared/widgets/widgets.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  bool _isVerifyEnabled = false;
  String _currentOtp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.mark_email_read_rounded,
                      size: 64,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Headings
                Text(
                  'Verify Email',
                  style: AppTextStyles.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Please enter the 4-digit code sent to\nyour registered email address.',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // OTP Input Field
                AppOtpField(
                  length: 4,
                  boxSize: 64,
                  spacing: 16,
                  borderRadius: BorderRadius.circular(16),
                  onChanged: (value) {
                    setState(() {
                      _currentOtp = value;
                      _isVerifyEnabled = value.length == 4;
                    });
                  },
                  onCompleted: (code) {
                    // Optionally auto-verify when completed
                  },
                ),
                const SizedBox(height: 40),

                // Verify Button
                Container(
                  decoration: BoxDecoration(
                    gradient: _isVerifyEnabled
                        ? AppColors.primaryGradient
                        : null,
                    color: _isVerifyEnabled ? null : AppColors.divider,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isVerifyEnabled
                        ? AppShadows.primaryButton
                        : null,
                  ),
                  child: ElevatedButton(
                    onPressed: _isVerifyEnabled
                        ? () {
                            context.pushNamed(AppRoute.resetPassword.name);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      disabledBackgroundColor: Colors.transparent,
                      disabledForegroundColor: AppColors.textDisabled,
                    ),
                    child: Text(
                      'Verify OTP',
                      style: AppTextStyles.button.copyWith(
                        fontSize: 16,
                        color: _isVerifyEnabled
                            ? AppColors.textOnPrimary
                            : AppColors.textDisabled,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Resend Code Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Resend OTP logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('OTP sent successfully!'),
                            backgroundColor: AppColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Resend OTP',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
