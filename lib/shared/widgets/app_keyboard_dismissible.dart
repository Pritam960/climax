import 'package:flutter/material.dart';

/// Ek wrapper widget jo poore app me kahin bhi use kiya ja sakta hai.
/// Ye widget do kaam karta hai:
/// 1. Jab user screen pe kahin tap karta hai toh keyboard hide ho jata hai.
/// 2. Jab user screen ko scroll karta hai toh bhi keyboard hide ho jata hai.
class AppKeyboardDismissible extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  const AppKeyboardDismissible({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Translucent taaki ye taps ko pakad sake aur apne baccho (children)
      // tak bhi bhej sake.
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // Kisi bhi jagah tap hone par primary focus ko hataye
        final currentFocus = FocusManager.instance.primaryFocus;
        if (currentFocus != null && !currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // Jaise hi koi bhi scroll start ho, keyboard hide kar do
          if (scrollNotification is ScrollStartNotification) {
            final currentFocus = FocusManager.instance.primaryFocus;
            if (currentFocus != null && !currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
          // false return karna zaroori hai taaki scroll event ruk na jaye
          return false;
        },
        child: child,
      ),
    );
  }
}
