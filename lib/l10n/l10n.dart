import 'dart:ui';

/// Localization utility class to manage app locales
final class L10n {
  // Private constructor to prevent instantiation
  L10n._();

  // List of supported locales with language and country codes
  static const supportedLocales = [
    Locale('en'), // English (Default)
    // Locale('en', 'GB'), // English (UK)
    // Locale('es'), // Spanish (Default - Spain)
    // Locale('es', 'MX'), // Spanish (Mexico)
  ];

  // Default locale
  static const fallbackLocale = Locale('en');

  /// Gets the locale name for display
  static String getLocaleName(Locale locale) {
    final String languageCode = locale.languageCode;
    final String? countryCode = locale.countryCode;

    // Return full name with country if available
    if (countryCode != null) {
      switch ('$languageCode-$countryCode') {
        case 'en-US':
          return 'English (US)';
      }
    }

    // Fallback to language-only name
    switch (languageCode) {
      case 'en':
        return 'English';
      default:
        return countryCode != null
            ? '$languageCode-$countryCode'
            : languageCode;
    }
  }

  /// Gets the locale flag
  static String getLocaleFlag(Locale locale) {
    final String languageCode = locale.languageCode;
    final String? countryCode = locale.countryCode;

    // Return country-specific flag if available
    if (countryCode != null) {
      switch (countryCode) {
        case 'US':
          return '🇺🇸';
        case 'GB':
          return '🇬🇧';
        case 'ES':
          return '🇪🇸';
        case 'MX':
          return '🇲🇽';
      }
    }

    // Fallback to language-based flag
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      default:
        return '🌐';
    }
  }

  /// Checks if the exact locale (language + country) is supported
  static bool isExactLocaleSupported(Locale locale) {
    return supportedLocales.any(
      (supportedLocale) =>
          supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode,
    );
  }

  /// Checks if the language is supported (regardless of country)
  static bool isLanguageSupported(Locale locale) {
    return supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  /// Gets the supported locale closest to the device locale
  static Locale getClosestSupportedLocale(Locale deviceLocale) {
    // Match strategy 1: Exact match (language + country)
    if (isExactLocaleSupported(deviceLocale)) {
      return deviceLocale;
    }

    // Match strategy 2: Same language, any country
    if (deviceLocale.countryCode != null) {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == deviceLocale.languageCode &&
            supportedLocale.countryCode != null) {
          return supportedLocale;
        }
      }
    }

    // Match strategy 3: Same language, no country preference
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode) {
        return supportedLocale;
      }
    }

    // No match found, return fallback locale
    return fallbackLocale;
  }

  /// Get all supported locales for a specific language
  static List<Locale> getLocalesForLanguage(String languageCode) {
    return supportedLocales
        .where((locale) => locale.languageCode == languageCode)
        .toList();
  }

  /// Get all supported languages (without duplicates)
  static List<String> get supportedLanguages {
    return supportedLocales
        .map((locale) => locale.languageCode)
        .toSet()
        .toList();
  }
}
