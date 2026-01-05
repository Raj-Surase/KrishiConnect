import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// ---------------------------------------------------------------------------
/// EMOTIONAL THEME EXTENSION (unchanged)
/// ---------------------------------------------------------------------------
class EmotionalTheme extends ThemeExtension<EmotionalTheme> {
  final Duration motionShort;
  final Duration motionMedium;
  final Duration motionLong;

  final Curve entryCurve;
  final Curve exitCurve;
  final Curve emphasisCurve;

  final String hapticHint;
  final String soundTap;
  final String soundSuccess;
  final String soundError;

  const EmotionalTheme({
    required this.motionShort,
    required this.motionMedium,
    required this.motionLong,
    required this.entryCurve,
    required this.exitCurve,
    required this.emphasisCurve,
    required this.hapticHint,
    required this.soundTap,
    required this.soundSuccess,
    required this.soundError,
  });

  @override
  EmotionalTheme copyWith({
    Duration? motionShort,
    Duration? motionMedium,
    Duration? motionLong,
    Curve? entryCurve,
    Curve? exitCurve,
    Curve? emphasisCurve,
    String? hapticHint,
    String? soundTap,
    String? soundSuccess,
    String? soundError,
  }) {
    return EmotionalTheme(
      motionShort: motionShort ?? this.motionShort,
      motionMedium: motionMedium ?? this.motionMedium,
      motionLong: motionLong ?? this.motionLong,
      entryCurve: entryCurve ?? this.entryCurve,
      exitCurve: exitCurve ?? this.exitCurve,
      emphasisCurve: emphasisCurve ?? this.emphasisCurve,
      hapticHint: hapticHint ?? this.hapticHint,
      soundTap: soundTap ?? this.soundTap,
      soundSuccess: soundSuccess ?? this.soundSuccess,
      soundError: soundError ?? this.soundError,
    );
  }

  @override
  EmotionalTheme lerp(ThemeExtension<EmotionalTheme>? other, double t) {
    if (other is! EmotionalTheme) return this;

    Duration lerpDuration(Duration a, Duration b) {
      final ms = a.inMilliseconds + (b.inMilliseconds - a.inMilliseconds) * t;
      return Duration(milliseconds: ms.round());
    }

    return EmotionalTheme(
      motionShort: lerpDuration(motionShort, other.motionShort),
      motionMedium: lerpDuration(motionMedium, other.motionMedium),
      motionLong: lerpDuration(motionLong, other.motionLong),
      entryCurve: t < 0.5 ? entryCurve : other.entryCurve,
      exitCurve: t < 0.5 ? exitCurve : other.exitCurve,
      emphasisCurve: t < 0.5 ? emphasisCurve : other.emphasisCurve,
      hapticHint: t < 0.5 ? hapticHint : other.hapticHint,
      soundTap: t < 0.5 ? soundTap : other.soundTap,
      soundSuccess: t < 0.5 ? soundSuccess : other.soundSuccess,
      soundError: t < 0.5 ? soundError : other.soundError,
    );
  }
}

class EmoCurves {
  static const entry = Curves.easeOutCubic;
  static const exit = Curves.easeInCubic;
  static const emphasis = Curves.easeOutExpo;
}

/// ---------------------------------------------------------------------------
/// THEME ROOT
/// ---------------------------------------------------------------------------
class AppTheme {
  /// Shared Emotional Theme for both light & dark
  static const EmotionalTheme _emotional = EmotionalTheme(
    motionShort: Duration(milliseconds: 180),
    motionMedium: Duration(milliseconds: 320),
    motionLong: Duration(milliseconds: 520),
    entryCurve: EmoCurves.entry,
    exitCurve: EmoCurves.exit,
    emphasisCurve: EmoCurves.emphasis,
    hapticHint: 'light',
    soundTap: 'tap_short',
    soundSuccess: 'success_bounce',
    soundError: 'error_thud',
  );

  /// -------------------------------
  /// PUBLIC LIGHT THEME
  /// -------------------------------
  static ThemeData get lightTheme =>
      _buildTheme(_buildLightColorScheme(), Brightness.light);

  /// -------------------------------
  /// PUBLIC DARK THEME
  /// -------------------------------
  static ThemeData get darkTheme =>
      _buildTheme(_buildDarkColorScheme(), Brightness.dark);

  /// -------------------------------------------------------------------------
  /// CORE THEME BUILDER (shared)
  /// -------------------------------------------------------------------------
  static ThemeData _buildTheme(ColorScheme scheme, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      textTheme: _buildTextTheme(scheme),
      scaffoldBackgroundColor: scheme.background,
      extensions: [_emotional],

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.background,
        foregroundColor: scheme.surface,
        shadowColor: scheme.onBackground.withOpacity(0.3),
        iconTheme: IconThemeData(color: scheme.onSurface),
        elevation: 4,
        scrolledUnderElevation: 2,

        titleTextStyle: _buildTextTheme(scheme).titleLarge,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _FadeScaleSlidePageTransitionsBuilder(),
          TargetPlatform.iOS: _FadeScaleSlidePageTransitionsBuilder(),
          TargetPlatform.linux: _FadeScaleSlidePageTransitionsBuilder(),
          TargetPlatform.macOS: _FadeScaleSlidePageTransitionsBuilder(),
          TargetPlatform.windows: _FadeScaleSlidePageTransitionsBuilder(),
        },
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(style: _buttonStyle(scheme)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _outlinedButtonStyle(scheme),
      ),
      textButtonTheme: TextButtonThemeData(style: _textButtonStyle(scheme)),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),

      inputDecorationTheme: _inputDecoration(scheme),
      dropdownMenuTheme: _dropdownMenuTheme(scheme),

      bottomNavigationBarTheme: _bottomNavTheme(scheme),
      bottomAppBarTheme: _bottomAppBarTheme(scheme),
      tabBarTheme: _tabBarTheme(scheme),

      chipTheme: _chipTheme(scheme),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.all(12.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
      ),

      iconTheme: IconThemeData(color: scheme.onBackground),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStatePropertyAll(scheme.primary),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(scheme.primary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(scheme.primary),
        trackColor: WidgetStatePropertyAll(scheme.primary.withOpacity(0.5)),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        titleTextStyle: _buildTextTheme(scheme).titleLarge,
        contentTextStyle: _buildTextTheme(scheme).bodyLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: _buildTextTheme(
          scheme,
        ).labelLarge?.copyWith(color: scheme.surface),
        actionTextColor: scheme.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),

      splashFactory: InkRipple.splashFactory,
      hoverColor: scheme.primary.withOpacity(0.04),
      highlightColor: scheme.primary.withOpacity(0.06),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  /// -------------------------------------------------------------------------
  /// COLOR SCHEMES
  /// -------------------------------------------------------------------------
  static ColorScheme _buildLightColorScheme() => ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.lightPrimary,
    onPrimary: AppColors.lightOnPrimary,
    primaryContainer: AppColors.lightPrimaryContainer,
    onPrimaryContainer: AppColors.lightOnPrimaryContainer,
    secondary: AppColors.lightSecondary,
    onSecondary: AppColors.lightOnSecondary,
    secondaryContainer: AppColors.lightSecondaryContainer,
    onSecondaryContainer: AppColors.lightOnSecondaryContainer,
    tertiary: AppColors.lightTertiary,
    onTertiary: AppColors.lightOnTertiary,
    tertiaryContainer: AppColors.lightTertiaryContainer,
    onTertiaryContainer: AppColors.lightOnTertiaryContainer,
    error: AppColors.lightError,
    onError: AppColors.lightOnError,
    errorContainer: AppColors.lightErrorContainer,
    onErrorContainer: AppColors.lightOnErrorContainer,
    background: AppColors.lightBackground,
    onBackground: AppColors.lightOnBackground,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,
    surfaceContainer: AppColors.lightSurfaceContainer,
    surfaceVariant: AppColors.lightSurfaceVariant,
    onSurfaceVariant: AppColors.lightOnSurfaceVariant,
    outline: AppColors.lightBorder,
    outlineVariant: AppColors.lightBorder,
    shadow: Colors.black12,
    scrim: Colors.black12,
    inverseSurface: Color(0xFF323232),
    onInverseSurface: Colors.white,
    inversePrimary: Color(0xFF337568),
    surfaceTint: AppColors.lightPrimary,
  );

  static ColorScheme _buildDarkColorScheme() => ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryContainer,
    onPrimaryContainer: AppColors.darkOnPrimaryContainer,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    secondaryContainer: AppColors.darkSecondaryContainer,
    onSecondaryContainer: AppColors.darkOnSecondaryContainer,
    tertiary: AppColors.darkTertiary,
    onTertiary: AppColors.darkOnTertiary,
    tertiaryContainer: AppColors.darkTertiaryContainer,
    onTertiaryContainer: AppColors.darkOnTertiaryContainer,
    error: AppColors.darkError,
    onError: AppColors.darkOnError,
    errorContainer: AppColors.darkErrorContainer,
    onErrorContainer: AppColors.darkOnErrorContainer,
    background: AppColors.darkBackground,
    onBackground: AppColors.darkOnBackground,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceContainer: AppColors.darkSurfaceContainer,
    surfaceVariant: AppColors.darkSurfaceVariant,
    onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    outline: AppColors.darkBorder,
    outlineVariant: AppColors.darkBorder,
    shadow: Colors.black54,
    scrim: Colors.black54,
    inverseSurface: AppColors.lightSurface,
    onInverseSurface: AppColors.lightOnSurface,
    inversePrimary: AppColors.darkPrimary,
    surfaceTint: AppColors.darkPrimary,
  );

  /// -------------------------------------------------------------------------
  /// TEXT THEME
  /// -------------------------------------------------------------------------
  static TextTheme _buildTextTheme(ColorScheme scheme) {
    final primary = scheme.primary;
    final color = scheme.onBackground;
    final variant = scheme.onSurfaceVariant;

    TextStyle inter(double size, FontWeight w, Color c) =>
        GoogleFonts.inter(fontSize: size, fontWeight: w, color: c);

    TextStyle playfairDisplay(double size, FontWeight w, Color c) =>
        GoogleFonts.playfairDisplay(fontSize: size, fontWeight: w, color: c);

    return TextTheme(
      displayLarge: playfairDisplay(48.sp, FontWeight.w700, primary),
      displayMedium: playfairDisplay(36.sp, FontWeight.w600, primary),
      displaySmall: playfairDisplay(28.sp, FontWeight.w600, primary),
      headlineLarge: inter(40.sp, FontWeight.w700, color),
      headlineMedium: inter(32.sp, FontWeight.w700, color),
      headlineSmall: inter(24.sp, FontWeight.w700, color),

      titleLarge: inter(20.sp, FontWeight.w600, color),
      titleMedium: inter(18.sp, FontWeight.w600, color),
      titleSmall: inter(16.sp, FontWeight.w600, variant),

      labelLarge: inter(16.sp, FontWeight.w500, color),
      labelMedium: inter(14.sp, FontWeight.w500, color),
      labelSmall: inter(14.sp, FontWeight.w500, variant),

      bodyLarge: inter(18.sp, FontWeight.w400, color),
      bodyMedium: inter(16.sp, FontWeight.w400, color),
      bodySmall: inter(16.sp, FontWeight.w400, variant),
    );
  }

  /// -------------------------------------------------------------------------
  /// COMPONENT BUILDERS (Shared for Light + Dark)
  /// -------------------------------------------------------------------------
  static ButtonStyle _buttonStyle(ColorScheme c) => ElevatedButton.styleFrom(
    backgroundColor: c.primary,
    foregroundColor: c.onPrimary,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    elevation: 8,
    shadowColor: c.primary.withOpacity(0.4), // richer depth
    surfaceTintColor: Colors.transparent, // REMOVE M3 tint
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
  );

  static ButtonStyle _outlinedButtonStyle(ColorScheme c) =>
      OutlinedButton.styleFrom(
        foregroundColor: c.onBackground,
        backgroundColor: c.background,
        side: BorderSide(color: c.outline),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      );

  static ButtonStyle _textButtonStyle(ColorScheme c) => TextButton.styleFrom(
    foregroundColor: c.onBackground,
    backgroundColor: c.surface,
  );

  static InputDecorationTheme _inputDecoration(ColorScheme c) =>
      InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        labelStyle: TextStyle(color: c.onSurface),
        hintStyle: TextStyle(color: c.onSurface),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: c.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: c.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: c.primary, width: 1.5),
        ),
      );

  static DropdownMenuThemeData _dropdownMenuTheme(ColorScheme c) =>
      DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(c.primaryContainer),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
              side: BorderSide(color: c.outline),
            ),
          ),
        ),
      );

  static BottomNavigationBarThemeData _bottomNavTheme(ColorScheme c) =>
      BottomNavigationBarThemeData(
        backgroundColor: c.surface,
        selectedItemColor: c.primary,
        unselectedItemColor: c.onSurfaceVariant,
        elevation: 1,
      );

  static BottomAppBarThemeData _bottomAppBarTheme(ColorScheme c) =>
      BottomAppBarThemeData(
        elevation: 4,
        color: c.surface,
        shadowColor: c.onBackground.withOpacity(0.3),
      );

  static TabBarThemeData _tabBarTheme(ColorScheme c) => TabBarThemeData(
    labelColor: c.primary,
    unselectedLabelColor: c.onSurfaceVariant,
    indicatorColor: c.primary,
  );

  static ChipThemeData _chipTheme(ColorScheme c) => ChipThemeData(
    backgroundColor: c.surfaceVariant,
    selectedColor: c.primaryContainer,
    labelStyle: TextStyle(color: c.onSurface),
    secondaryLabelStyle: TextStyle(color: c.onSurface),
    deleteIconColor: c.onSurfaceVariant,
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    side: BorderSide(color: c.outlineVariant),
  );
}

/// ---------------------------------------------------------------------------
/// PAGE TRANSITIONS (unchanged)
/// ---------------------------------------------------------------------------
class _FadeScaleSlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const _FadeScaleSlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final emo = Theme.of(context).extension<EmotionalTheme>()!;

    final curved = CurvedAnimation(parent: animation, curve: emo.entryCurve);

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(curved),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.02, 0.06),
          end: Offset.zero,
        ).animate(curved),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.985, end: 1.0).animate(curved),
          child: _WrapWithEntranceFeedback(child: child),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// HAPTIC ON ROUTE ENTER (unchanged)
/// ---------------------------------------------------------------------------
class _WrapWithEntranceFeedback extends StatefulWidget {
  final Widget child;
  const _WrapWithEntranceFeedback({required this.child});

  @override
  State<_WrapWithEntranceFeedback> createState() =>
      _WrapWithEntranceFeedbackState();
}

class _WrapWithEntranceFeedbackState extends State<_WrapWithEntranceFeedback> {
  bool _fired = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fired) {
      _fired = true;
      final emo = Theme.of(context).extension<EmotionalTheme>();
      final hint = emo?.hapticHint ?? 'light';

      Future.microtask(() {
        switch (hint) {
          case 'heavy':
            HapticFeedback.heavyImpact();
            break;
          case 'medium':
            HapticFeedback.mediumImpact();
            break;
          case 'selection':
            HapticFeedback.selectionClick();
            break;
          default:
            HapticFeedback.lightImpact();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
