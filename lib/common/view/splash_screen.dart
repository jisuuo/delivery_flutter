import 'package:delivery_flutter/common/const/colors.dart';
import 'package:delivery_flutter/common/const/data.dart';
import 'package:delivery_flutter/common/layout/default_layout.dart';
import 'package:delivery_flutter/common/view/root_tab.dart';
import 'package:delivery_flutter/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// 앱 처음 실행 시, storage에 access, refresh 있는지 확인

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      /// accessToken 재발급 시도
      final resp = await dio.post(
        'http://$ip/auth/token',
        options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RootTab()),
            (route) => false,
      );

    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 16),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
