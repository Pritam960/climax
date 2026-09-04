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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDashboardStats(),
              const SizedBox(height: 32),
              // You can add more sections here below the dashboard
              Text(
                'Recent Activity',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Dummy empty state for recent activity
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 48),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 48,
                      color: AppColors.textDisabled,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No recent activity',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardStats() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppShadows.sm,

        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Top Row: Collected & Pending
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  title: 'Collected',
                  value: '₹1,24,500',
                  icon: Icons.account_balance_wallet_rounded,
                  iconColor: AppColors.success,
                  isTopLeft: true,
                ),
              ),
              Container(width: 1, height: 80, color: AppColors.border),
              Expanded(
                child: _buildStatItem(
                  title: 'Pending',
                  value: '₹32,000',
                  icon: Icons.pending_actions_rounded,
                  iconColor: AppColors.warning,
                  isTopRight: true,
                ),
              ),
            ],
          ),
          // Divider
          Divider(height: 1, thickness: 1, color: AppColors.border),
          // Bottom Row: Today & Students
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  title: 'Today',
                  value: '₹8,500',
                  icon: Icons.trending_up_rounded,
                  iconColor: AppColors.primary,
                  isBottomLeft: true,
                ),
              ),
              Container(width: 1, height: 80, color: AppColors.border),
              Expanded(
                child: _buildStatItem(
                  title: 'Students',
                  value: '48',
                  icon: Icons.people_alt_rounded,
                  iconColor: AppColors.textSecondary,
                  isBottomRight: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    bool isTopLeft = false,
    bool isTopRight = false,
    bool isBottomLeft = false,
    bool isBottomRight = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isTopLeft ? 24 : 0),
          topRight: Radius.circular(isTopRight ? 24 : 0),
          bottomLeft: Radius.circular(isBottomLeft ? 24 : 0),
          bottomRight: Radius.circular(isBottomRight ? 24 : 0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}
