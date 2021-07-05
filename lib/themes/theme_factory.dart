import 'package:flutter/material.dart';

class ThemeFactory {
  final BuildContext context;
  final _BaseTheme _normal = _BaseTheme();
  final _BaseTheme _large = _LargeTheme();

  ThemeFactory.of(
    BuildContext context,
  ) : this.context = context;

  _BaseTheme get theme {
    // 테마 예제
    // 사이즈별로 다른 테마를
    // 리턴해주는 함수를 이용해서
    // 텍스트 사이즈 및 컨테이너 사이즈 조절
    //
    //
    // 모든 Font Size 를 특정 비율에 맞춰서 자동 조절 할수도 있으나
    // UI가 까다로워질 경우를 대비해 텍스트 사이즈 별로 모두
    // 커스텀 적용이 가능하게 설계.
    if (MediaQuery.of(context).size.width > 200) {
      return _normal;
    } else {
      return _large;
    }
  }
}

abstract class _ITheme {
  /*
  * 스플래시 스크린 배경
  * */
  late Color primaryBgColor;
  /*
  * 일반 화면 배경
  * */
  late Color secondaryBgColor;
  /*
  * primary color
  * */
  late Color primaryColor;

  /*
  * 타이틀 폰트 사이즈
  * */
  late double titleFontSize;

  /*
  * 프라이머리 배경 글자색
  * */
  late Color whiteTextColor;

  /*
  * 회색 글자색
  * */
  late Color greyPrimaryTextColor;

  /*
  * 세컨 회색 글자색
  * */
  late Color secondaryGreyTextColor;

  /*
  * 메인 회색 배경
  * */
  late Color primaryGreyBgColor;

  /*
  * 세컨 회색 배경
  * */
  late Color secondaryGreyBgColor;

  /*
  * 노란색
  * */
  late Color primaryYellowColor;

  /*
  * 초록색
  * */
  late Color primaryGreenColor;

  /*
  * 어두은 파란색
  * */
  late Color primaryBlueColor;

  /*
  * 밝은 파란색
  * */
  late Color secondaryBlueColor;

  /*
  * 오렌지색
  * */
  late Color primaryOrangeColor;

  /*
  * 빨간색
  * */
  late Color primaryRedColor;

  /*
  * 회색
  * */
  late Color primaryGreyColor;

  /*
  * 하늘색
  * */
  late Color primarySkyBlueColor;

  /*
  * 핑크색
  * */
  late Color primaryPinkColor;

  /*
  * 보라색
  * */
  late Color primaryVioletColor;

  /*
  * 일반 FW
  * */
  late FontWeight primaryFontWeight;

  /*
  * Heavy FW
  * */
  late FontWeight heavyFontWeight;

  /*
  * 22sp FS
  * */
  late double fontSize22;

  /*
  * 20sp FS
  * */
  late double fontSize20;

  /*
  * 16sp FS
  * */
  late double fontSize16;


  /*
  * 14sp FS
  * */
  late double fontSize15;

  /*
  * 14sp FS
  * */
  late double fontSize14;

  /*
  * 13sp FS
  * */
  late double fontSize13;

  /*
  * 12sp FS
  * */
  late double fontSize12;

  /*
  * 11sp FS
  * */
  late double fontSize11;

  /*
  * 12sp FS
  * */
  late double fontSize10;

  /*
  * 9sp FS
  * */
  late double fontSize9;
}

class _BaseTheme implements _ITheme {
  @override
  Color primaryBgColor = Color(0xFF4042AB);

  @override
  Color secondaryBgColor = Color(0xFFFFFFFF);

  @override
  Color primaryColor = Color(0xFF4042AB);

  @override
  double titleFontSize = 20.0;

  @override
  Color whiteTextColor = Colors.white;

  @override
  FontWeight primaryFontWeight = FontWeight.normal;

  @override
  FontWeight heavyFontWeight = FontWeight.w700;

  @override
  double fontSize22 = 22.0;

  @override
  double fontSize20 = 20.0;

  @override
  double fontSize16 = 16.0;

  @override
  double fontSize15 = 15.0;

  @override
  double fontSize14 = 14.0;

  @override
  double fontSize13 = 13.0;

  @override
  double fontSize12 = 12.0;

  @override
  double fontSize11 = 11.0;

  @override
  double fontSize10 = 10.0;

  @override
  double fontSize9 = 9.0;

  @override
  Color greyPrimaryTextColor = Color(0xFFB8B8B8);

  @override
  Color primaryGreyBgColor = Color(0xFFC5C5CF);

  @override
  Color secondaryGreyBgColor = Color(0xFFEEEFF3);

  @override
  Color secondaryGreyTextColor = Color(0xFF434343);

  @override
  Color primaryYellowColor = Color(0xFFFDD84F);

  @override
  Color primaryBlueColor = Color(0xFF1D1F75);

  @override
  Color primaryGreenColor = Color(0xFF6CC4BF);

  @override
  Color primaryGreyColor = Color(0xFFEEEFF3);

  @override
  Color primaryOrangeColor = Color(0xFFF29061);

  @override
  Color primaryPinkColor = Color(0xFFFF9B95);

  @override
  Color primaryRedColor = Color(0xFFDC5050);

  @override
  Color primarySkyBlueColor = Color(0xFF6FA7FA);

  @override
  Color primaryVioletColor = Color(0xFF8B6ADC);

  @override
  Color secondaryBlueColor = Color(0xFF4042AB);
}

class _LargeTheme extends _BaseTheme {
  @override
  Color primaryBgColor = Color(0xFF000000);

  @override
  double titleFontSize = 26.0;
}
