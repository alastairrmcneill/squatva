import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: _darkThemeBackgroundColor,
      primaryColor: Colors.red,
      appBarTheme: AppBarTheme(
        color: _darkThemeBackgroundColor,
        foregroundColor: _darkThemeTextColor,
        elevation: 0,
        centerTitle: false,
      ),
      accentColor: _darkThemeAccent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _darkThemeAccent,
        unselectedItemColor: Color.fromARGB(255, 238, 238, 238),
        backgroundColor: _darkThemeCardColor,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 0,
        color: _darkThemeCardColor,
      ),
      dividerTheme: DividerThemeData(
        space: 10,
        color: _darkThemeTextColor.withOpacity(0.7),
        indent: 8,
        endIndent: 9,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(_darkThemeAccent),
          foregroundColor: MaterialStateProperty.all<Color?>(_darkThemeTextColor),
          textStyle: MaterialStateProperty.all<TextStyle?>(const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          elevation: MaterialStateProperty.all<double?>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(_darkThemeAccent),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: _darkThemeAccent),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: _darkThemeCardColor,
        filled: true,
        prefixIconColor: _darkThemeAccent,
        suffixIconColor: _darkThemeAccent,
        hintStyle: TextStyle(color: _darkThemeTextColor.withOpacity(0.4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[900]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: _darkThemeAccent.withOpacity(0.3),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: _darkThemeTextColor),
        bodyMedium: TextStyle(color: _darkThemeTextColor),
        bodySmall: TextStyle(color: _darkThemeTextColor),
        headlineLarge: TextStyle(color: _darkThemeTextColor),
        headlineMedium: TextStyle(color: _darkThemeTextColor),
        headlineSmall: TextStyle(color: _darkThemeTextColor),
        titleLarge: TextStyle(color: _darkThemeTextColor),
        titleMedium: TextStyle(color: _darkThemeTextColor),
        titleSmall: TextStyle(color: _darkThemeTextColor),
        labelLarge: TextStyle(color: _darkThemeTextColor),
        labelMedium: TextStyle(color: _darkThemeTextColor),
        labelSmall: TextStyle(color: _darkThemeTextColor),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: _lightThemeBackgroundColor,
      primaryColor: Colors.red,
      appBarTheme: AppBarTheme(
        color: _lightThemeBackgroundColor,
        foregroundColor: _lightThemeTextColor,
        elevation: 0,
        centerTitle: false,
      ),
      accentColor: _lightThemeAccent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _lightThemeAccent,
        unselectedItemColor: Color.fromARGB(255, 238, 238, 238),
        backgroundColor: _lightThemeCardColor,
        elevation: 5,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 3,
        color: _lightThemeCardColor,
      ),
      dividerTheme: DividerThemeData(
        space: 10,
        color: _lightThemeTextColor.withOpacity(0.7),
        indent: 8,
        endIndent: 9,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(_lightThemeAccent),
          foregroundColor: MaterialStateProperty.all<Color?>(const Color(0xFFFFFFFF)),
          textStyle: MaterialStateProperty.all<TextStyle?>(const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          elevation: MaterialStateProperty.all<double?>(2),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(_lightThemeAccent),
          textStyle: MaterialStateProperty.all<TextStyle?>(const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: _lightThemeAccent),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        prefixIconColor: _lightThemeAccent,
        suffixIconColor: _lightThemeAccent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _lightThemeAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: _lightThemeTextColor),
        bodyMedium: TextStyle(color: _lightThemeTextColor),
        bodySmall: TextStyle(color: _lightThemeTextColor),
        headlineLarge: TextStyle(color: _lightThemeTextColor),
        headlineMedium: TextStyle(color: _lightThemeTextColor),
        headlineSmall: TextStyle(color: _lightThemeTextColor),
        titleLarge: TextStyle(color: _lightThemeTextColor),
        titleMedium: TextStyle(color: _lightThemeTextColor),
        titleSmall: TextStyle(color: _lightThemeTextColor),
        labelLarge: TextStyle(color: _lightThemeTextColor),
        labelMedium: TextStyle(color: _lightThemeTextColor),
        labelSmall: TextStyle(color: _lightThemeTextColor),
      ),
    );
  }
}

Color _darkThemeBackgroundColor = const Color(0xFF1C1C1C);
Color _darkThemeCardColor = const Color(0xFF333333);
Color _darkThemeAccent = const Color(0xFFEE5E44);
Color _darkThemeTextColor = const Color.fromARGB(255, 238, 238, 238);

Color _lightThemeBackgroundColor = Color.fromARGB(255, 234, 239, 239);
Color _lightThemeCardColor = const Color(0xFFFFFFFF);
Color _lightThemeAccent = Color.fromARGB(255, 91, 149, 176); //const Color(0xFF6DA273);  //const Color(0xFFEE5E44);
Color _lightThemeTextColor = Color.fromARGB(255, 79, 81, 84);
