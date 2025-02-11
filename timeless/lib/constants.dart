import 'package:flutter/cupertino.dart';

class AppColors {
  static const primaryColor = CupertinoColors.systemBlue;
  static const secondaryColor = CupertinoColors.systemGrey;
  static const backgroundColor = CupertinoColors.systemBackground;
  static const accentColor = CupertinoColors.activeBlue;
}

class AppText {
  static const titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const subtitleStyle = TextStyle(
    fontSize: 16,
    color: CupertinoColors.systemGrey,
  );

  static const bodyStyle = TextStyle(
    fontSize: 14,
    color: CupertinoColors.black,
  );

  static const buttonStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: CupertinoColors.white,
  );
}

class AppPadding {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}
