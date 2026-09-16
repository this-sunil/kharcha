import 'package:flutter/material.dart';

// Extension to easily access custom colors via context: context.appColors.primary
extension AppThemeContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const colors = AppColors.light;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        surface: colors.surface,
        error: colors.error,
      ),
      cardColor: colors.card,
      extensions: const [
        AppColors.light,
      ],
    );
  }

  static ThemeData get dark {
    const colors = AppColors.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        surface: colors.surface,
        error: colors.error,
      ),
      cardColor: colors.card,
      extensions: const [
        AppColors.dark,
      ],
    );
  }
}

// Renamed from _AppColors to AppColors to make it accessible across the app
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color card;
  final Color cardLight;
  final Color primary;
  final Color text;
  final Color secondaryText;
  final Color border;
  final Color error;
  final Color success;
  final Color warning;

  const AppColors({
    required this.background,
    required this.surface,
    required this.card,
    required this.cardLight,
    required this.primary,
    required this.text,
    required this.secondaryText,
    required this.border,
    required this.error,
    required this.success,
    required this.warning,
  });

  static const light = AppColors(
    background: Color(0xFFF5F8F3),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    cardLight: Color(0xFFF4F8F6),
    primary: Color(0xFF6D991A),
    text: Color(0xFF172016),
    secondaryText: Color(0xFF687267),
    border: Color(0xFFE1E9DE),
    error: Color(0xFFE45564),
    success: Color(0xFF19B85B),
    warning: Color(0xFFF2A94A),
  );

  static const dark = AppColors(
    background: Color(0xFF090C10),
    surface: Color(0xFF0D1117),
    card: Color(0xFF11161D),
    cardLight: Color(0xFF171D24),
    primary: Color(0xFF19D66B),
    text: Color(0xFFF2F5F3),
    secondaryText: Color(0xFF8B9590),
    border: Color(0xFF252D35),
    error: Color(0xFFFF6472),
    success: Color(0xFF19D66B),
    warning: Color(0xFFF2A94A),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? card,
    Color? cardLight,
    Color? primary,
    Color? text,
    Color? secondaryText,
    Color? border,
    Color? error,
    Color? success,
    Color? warning,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      cardLight: cardLight ?? this.cardLight,
      primary: primary ?? this.primary,
      text: text ?? this.text,
      secondaryText: secondaryText ?? this.secondaryText,
      border: border ?? this.border,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;

    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardLight: Color.lerp(cardLight, other.cardLight, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      text: Color.lerp(text, other.text, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      border: Color.lerp(border, other.border, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }
}