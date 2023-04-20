import 'package:flutter/material.dart';

class Style {
  static const kScaffoldColor = Color(0XFF1C1D22);
  static const kTextColor = Color(0XFFF5F7F9);
  static const kInActiveButton = Color(0XFF82868D);
  static const kActiveButton = Color(0XFFF5F7F9);
  static const kSubmitButton = Color.fromRGBO(66, 202, 144, 0.3);
  static const kButtonText = Color(0XFF42CA90);
  static const kNameContainer = Color.fromRGBO(200, 177, 98, 0.1);
  static const kNameColor = Color(0XFFC8B162);
  static const kTextPlanInfo = Color(0XFF82868D);
  static const kTextPlanInfoLight = Color(0XFFF5F7F9);
  static const kBottomBar = Color(0XFF1C1D22);
  static const kBorderColor = Color(0XFF25262D);
  static const kPressedCard = Color(0XFF25262D);
  static const kStalledCard = Color(0XFF1C1D22);
  static const kPressedBorder = Color(0XFF373943);
  static const kIconColor = Color(0XFFF5F7F9);
  static const kBackgroundBlurred = Color(0XFF1C1D22);
  static const kResetColor = Color(0XFFDF696A);
  static const kResetBackground = Color.fromRGBO(223, 105, 106, 0.3);
  static const kUnoveredColor = Color(0XFF0077B6);
  static const khoveredColor = Color(0XFF00B4D8);
  static const kActivated = Color.fromARGB(255, 97, 17, 141);
  static const kInActivated = Color(0xFF636365);
  static const kAppBarColor = Colors.white;
  static const textColor = Colors.white;
  static const background = Colors.transparent;
  static const containerColor = Color(0xffA40000);
  static const padding = EdgeInsets.all(16);
  static const height = 90;

  static const TextStyle kTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );
  static const kSubmitTextStyle = TextStyle(
    color: kButtonText,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle h1 =
      TextStyle(color: Colors.white, fontSize: 60, fontFamily: 'OLF');
  static const TextStyle buttonstyle =
      TextStyle(color: Colors.black, fontSize: 40, fontFamily: 'OLF');

  static const TextStyle h2 = TextStyle(
    color: Colors.white,
    fontSize: 35,
    fontWeight: FontWeight.bold,
    fontFamily: 'Italic',
  );

  static const TextStyle h3 =
      TextStyle(color: Colors.white, fontSize: 31, fontFamily: 'OLF');

  static const TextStyle h4 = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle otpStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle bottomSheetText =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w400);

  static const InputDecoration inputdeco1 = InputDecoration(
    hintText: '',
    floatingLabelAlignment: FloatingLabelAlignment.center,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 3),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    alignLabelWithHint: true,
  );

  static const InputDecoration bottomSheetBox = InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.5),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  static final InputDecoration kInputdecoration = InputDecoration(
    label: Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        'Enter plan code',
        style: kTextStyle.copyWith(color: kInActiveButton, fontSize: 12),
      ),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
    fillColor: const Color(0XFF1C1D22),
    border: InputBorder.none,
    alignLabelWithHint: true,
  );
  static final InputDecoration kInputdecoration2 = InputDecoration(
    label: Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        'Search plan',
        style: kTextStyle.copyWith(color: kInActiveButton, fontSize: 12),
      ),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
    prefixIcon: const Icon(Icons.search, size: 32, color: Colors.white),
    fillColor: const Color(0XFF1C1D22),
    border: InputBorder.none,
    alignLabelWithHint: true,
  );
  static final kInfoStyle =
      Style.kTextStyle.copyWith(color: kTextPlanInfo, fontSize: 10);
  static final kTitleStyle =
      kTextStyle.copyWith(fontSize: 12, color: kTextPlanInfo);
}
