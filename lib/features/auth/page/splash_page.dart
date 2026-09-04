import 'package:climax_app/core/themes/themes.dart';
import 'package:climax_app/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with TickerProviderStateMixin {
  late AnimationController _logoController;

  late Animation<double> _logoScaleAnim;
  late Animation<double> _logoOpacityAnim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Clean white background
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // LOGO
            AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoScaleAnim.value,
                  child: Opacity(
                    opacity: _logoOpacityAnim.value,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: AppColors
                            .primaryContainer, // Soft blue background for icon
                        shape: BoxShape.circle,
                      ),
                      child: const AppLogo(
                        size: AppLogoSize.xl,
                        showText: false,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.xl),

            // APP NAME
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
