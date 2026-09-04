import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';

import '../themes/themes.dart';

class MainShell extends StatefulWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (_isVisible) {
              setState(() {
                _isVisible = false;
              });
            }
          } else if (notification.direction == ScrollDirection.forward) {
            if (!_isVisible) {
              setState(() {
                _isVisible = true;
              });
            }
          }
          return false; // let the scroll event continue
        },
        child: widget.navigationShell,
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: _isVisible 
            ? 80.0 + MediaQuery.of(context).padding.bottom // Default NavigationBar height is ~80
            : 0.0,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: 80.0 + MediaQuery.of(context).padding.bottom,
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: NavigationBar(
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: (int index) {
                  _onTap(context, index);
                },
                backgroundColor: AppColors.surface,
                elevation: 0,
                indicatorColor: AppColors.primaryContainer,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(
                      Icons.home_rounded,
                      color: AppColors.primary,
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.receipt_long_outlined),
                    selectedIcon: Icon(
                      Icons.receipt_long_rounded,
                      color: AppColors.primary,
                    ),
                    label: 'Students',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    selectedIcon: Icon(
                      Icons.person_rounded,
                      color: AppColors.primary,
                    ),
                    label: 'Collect',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.more_vert_outlined),
                    selectedIcon: Icon(Icons.more_vert, color: AppColors.primary),
                    label: 'More',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
