import 'package:flutter/material.dart';

// dart에서는 상수들을 lowerCamelCase로 작성하는 것을 권장한다고 함

// BASE URL
const baseURL = "http://www.petdori.com";
// const baseURL = "http://localhost:8080";

// 소셜 플랫폼 지정 컬러 - 카카오
const kakaoButtonColor = Color(0xFFFEE500);
const kakaoTextColor = Color(0xFF191919);

// 소셜 플랫폼 지정 컬러 - 구글
const googleButtonColor = Color(0xFFFFFFFF);
const googleTextColor = Color(0xFF191919);

// 소셜 플랫폼 지정 컬러 - 애플
const appleButtonColor = Color(0xFF000000);
const appleTextColor = Color(0xFFFFFFFF);

// 앱 로고 경로
const appLogoPath = "assets/images/petdori-logo.svg";

// 컬러 관련 상수들
const screenBackgroundColor = Color(0xFFffffff);
const mainColor = Color(0xFF3c99f8);
const lightBlueColor = Color(0xFFe1f0ff);
const lightGreyColor = Color(0xFFefefef);
const mediumGreyColor = Color(0xFFa0a0a0);
const darkGreyColor = Color(0xFF8c8c8c);
const deepPurpleColor = Color(0xFF8f59f5);
const transparentColor = Colors.transparent;
const blackColor = Color(0xFF292929);
const whiteColor = Color(0xFFffffff);

// 폰트 굵기 관련 상수들
const fontWeightThin = FontWeight.w100;
const fontWeightLight = FontWeight.w300;
const fontWeightRegular = FontWeight.w400;
const fontWeightMedium = FontWeight.w500;
const fontWeightBold = FontWeight.w700;
const fontWeightBlack = FontWeight.w900;

// 애니메이션 관련 상수들
const animationDuration = Duration(milliseconds: 500);

// 화면 위젯 비율 상수들
const mapHeightRatio = 0.34;
const consoleHeightRatio = 0.66;
const statsGridHeightRatio = 0.4;
const statsGridColumnCount = 3;
const statsGridItemWidthHeightRatio = 0.9;
const controlButtonsWidgetHeightRatio = 0.15;
const testWidgetHeightRatio = 0.45;

// 위젯 State 관리 주기 상수들
const mapWidgetRebuildCycle = 1000; // milliseconds
const distanceStatsUpdateCycle = 3000; // milliseconds
const speedStatsUpdateCycle = 2000; // milliseconds
const caloriesStatsUpdateCycle = 5000; // milliseconds
const elapsedTimeStatsUpdateCycle = 500; // milliseconds
const paceStatsUpdateCycle = 10000; // milliseconds
const stepStatsUpdateCycle = 1000; // milliseconds
const altitudeStatsUpdateCycle = 5000; // milliseconds
const heartRateStatsUpdateCycle = 3000; // milliseconds