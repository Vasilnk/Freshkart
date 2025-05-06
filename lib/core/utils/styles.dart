import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static ButtonStyle bigButton = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(67),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.greenColor,
  );
  static ButtonStyle smallButton = ElevatedButton.styleFrom(
    minimumSize: const Size(0, 67),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: AppColors.greenColor,
  );
  static ButtonStyle bigButtonLight = OutlinedButton.styleFrom(
    minimumSize: const Size(330, 67),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    // backgroundColor: Colors.white,
  );
  static TextStyle bigButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
  static TextStyle lightBigButtonTextStyle = TextStyle(
    color: AppColors.greenColor,
    fontSize: 18,
  );

  static TextStyle welcomText = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontWeight: FontWeight.w600,
    ),
  );
  static TextStyle mediumTextStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
}
