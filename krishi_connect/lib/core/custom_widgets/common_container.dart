import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/theme/app_colors.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;
  final int depth; // 0, 1, or 2

  const CommonContainer({
    super.key,
    required this.child,
    this.depth = 0, // default = no shadow
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode(context)
              ? [colors.surfaceContainer, colors.surface, colors.surface]
              : [colors.surfaceContainer, colors.surfaceContainer],
        ),

        border: Border.all(
          color: isDarkMode(context) ? colors.outline : colors.background,
          width: 1,
        ),

        borderRadius: BorderRadius.circular(24.r),

        // ⭐ Apply the shadow based on depth
        boxShadow: _shadowByDepth(colors, depth),
      ),

      child: child,
    );
  }

  /// Generates shadow list based on depth level
  List<BoxShadow> _shadowByDepth(ColorScheme colors, int depth) {
    switch (depth) {
      case 1:
        // Soft bottom + very light top shadow
        return [
          // Top very soft highlight
          BoxShadow(
            color: colors.onBackground.withOpacity(0.04),
            offset: const Offset(0, -1),
            blurRadius: 3,
          ),
          // Bottom soft shadow
          BoxShadow(
            color: colors.onBackground.withOpacity(0.10),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ];

      case 2:
        // Deeper, stronger shadows
        return [
          BoxShadow(
            color: colors.onBackground.withOpacity(0.06),
            offset: const Offset(0, -2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: colors.onBackground.withOpacity(0.15),
            offset: const Offset(0, 6),
            blurRadius: 10,
          ),
        ];

      case 0:
        return [
          // Top very soft highlight
          BoxShadow(
            color: colors.onBackground.withOpacity(0.02),
            offset: const Offset(0, -1),
            blurRadius: 2,
          ),
          // Bottom soft shadow
          BoxShadow(
            color: colors.onBackground.withOpacity(0.10),
            offset: const Offset(0, 1),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ];
      default:
        // No shadow
        return [];
    }
  }
}
