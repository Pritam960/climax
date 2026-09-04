import 'package:flutter/material.dart';
import '../../../../core/themes/themes.dart';
import '../../../../shared/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        showGreeting: true,
        title: 'User Name', // TODO: Fetch dynamic user name
        showNotification: true,
        onNotificationTap: () {
          // TODO: Handle notification tap
        },
      ),
      body: Center(
        child: Text(
          'Welcome to Home Page',
          style: AppTextStyles.bodyLarge,
        ),
      ),
    );
  }
}
