import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

const kScaffoldColor = Color(0XFF1C1D22);
const kTextColor = Color(0XFFF5F7F9);
const kInActiveButton = Color(0XFF82868D);
const kActiveButton = Color(0XFFF5F7F9);
const kSubmitButton = Color.fromRGBO(66, 202, 144, 0.3);
const kButtonText = Color(0XFF42CA90);
const kNameContainer = Color.fromRGBO(200, 177, 98, 0.1);
const kNameColor = Color(0XFFC8B162);
const kTextPlanInfo = Color(0XFF82868D);
const kTextPlanInfoLight = Color(0XFFF5F7F9);
const kBottomBar = Color(0XFF1C1D22);
const kBorderColor = Color(0XFF25262D);
const kPressedCard = Color(0XFF25262D);
const kStalledCard = Color(0XFF1C1D22);
const kPressedBorder = Color(0XFF373943);
const kIconColor = Color(0XFFF5F7F9);
const kBackgroundBlurred = Color(0XFF1C1D22);
const kResetColor = Color(0XFFDF696A);
const kResetBackground = Color.fromRGBO(223, 105, 106, 0.3);
const kUnoveredColor = Color(0XFF0077B6);
const khoveredColor = Color(0XFF00B4D8);
const TextStyle kTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w700,
  // fontFamily: GoogleFonts.almarai().fontFamily,
);
const kSubmitTextStyle = TextStyle(
  color: kButtonText,
  fontWeight: FontWeight.w700,
);

TextStyle h1 =
    const TextStyle(fontFamily: "OLF", fontSize: 60, color: Colors.white);
TextStyle buttonstyle = const TextStyle(
  fontFamily: "OLF",
  fontSize: 40,
  color: Colors.black,
);

TextStyle h2 = const TextStyle(
    fontFamily: "Italic",
    fontSize: 35,
    color: Colors.white,
    fontWeight: FontWeight.bold);

TextStyle h3 =
    const TextStyle(fontFamily: "OLF", fontSize: 31, color: Colors.white);

TextStyle h4 = const TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontStyle: FontStyle.italic,
);

TextStyle otpStyle = const TextStyle(
  fontSize: 30,
  color: Colors.white,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.bold,
);
TextStyle bottomSheetText =
    const TextStyle(fontSize: 30, fontWeight: FontWeight.w400);

InputDecoration inputdeco1 = const InputDecoration(
  alignLabelWithHint: true,
  // labelText: '',
  hintText: '',
  floatingLabelAlignment: FloatingLabelAlignment.center,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 3, color: Colors.white),
    borderRadius: BorderRadius.all(
      Radius.circular(30),
    ),
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
      borderSide: BorderSide(width: 1, color: Colors.white)),
);

InputDecoration bottomSheetBox = InputDecoration(
  focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      borderSide: BorderSide(width: 2.5, color: Colors.white)),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(width: 3, color: Colors.white),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

final InputDecoration kInputdecoration = InputDecoration(
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
final InputDecoration kInputdecoration2 = InputDecoration(
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
  suffixIcon: Padding(
    padding: const EdgeInsets.only(left: 3.0, top: 10.0),
    child: badges.Badge(
      badgeContent: const Text('2'),
      badgeStyle: const badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: Color(0XFF6CC795),
        elevation: 0,
        padding: EdgeInsets.all(3.0),
      ),
      position: badges.BadgePosition.topEnd(top: 16, end: 28),
      showBadge: true,
      ignorePointer: false,
      child: const Icon(
        Icons.filter_list_alt,
        size: 32,
        color: Colors.white,
      ),
    ),
  ),
  fillColor: const Color(0XFF1C1D22),
  border: InputBorder.none,
  alignLabelWithHint: true,
);
final kInfoStyle = kTextStyle.copyWith(color: kTextPlanInfo, fontSize: 10);
final kTitleStyle = kTextStyle.copyWith(fontSize: 12, color: kTextPlanInfo);
