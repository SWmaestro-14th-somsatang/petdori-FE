import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';
import 'package:wooyoungsoo/provider/gps_util_provider.dart';
import 'package:wooyoungsoo/provider/session_state_provider.dart';
import 'package:wooyoungsoo/provider/session_stats_provider.dart';
import 'package:wooyoungsoo/screens/activity_log_screen.dart';
import 'package:wooyoungsoo/screens/activity_screen.dart';
import 'package:wooyoungsoo/screens/bloodsugar_screen.dart';
import 'package:wooyoungsoo/screens/dog_register_screen.dart';
import 'package:wooyoungsoo/screens/login_screen.dart';
import 'package:wooyoungsoo/screens/main_screen.dart';
import 'package:wooyoungsoo/screens/monthly_walk_log_screen.dart';
import 'package:wooyoungsoo/screens/my_page_screen.dart';
import 'package:wooyoungsoo/screens/nearby_facility_screen.dart';
import 'package:wooyoungsoo/screens/signup_screen.dart';
import 'package:wooyoungsoo/screens/walk_log_screen.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY'],
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GpsUtilProvider()),
        ProxyProvider<GpsUtilProvider, SessionStatsProvider>(
            update: (_, gpsUtilProvider, __) =>
                SessionStatsProvider(gpsUtilProvider: gpsUtilProvider)),
        ChangeNotifierProvider(create: (_) => SessionStateProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "NotoSansKR",
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const MainScreen(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignupScreen(),
        "/dog-register": (context) => const DogRegisterScreen(),
        "/activity-log": (context) => const ActivityLogScreen(),
        "/activity": (context) => const ActivityScreen(),
        "/mypage": (context) => const MypageScreen(),
        "/nearby": (context) => const NearbyFacilityScreen(),
        "/log": (context) => const WalkLogScreen(),
        "/monthly-log": (context) => const MonthlyWalkLogScreen(),
        "/blood-sugar": (context) => BloodSugarScreen(),
      },
    );
  }
}
