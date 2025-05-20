import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

/// mac에서 시뮬레이터 사용할 경우는 네트워크 주소 똑같음
/// 이 외에는 네트워크가 다르므로 에뮬레이터 기준으로 따로 설정을 해줘야함
/// localhost
final emulatorIp = '10.0.2.2:3000';
final simulatorIp = '127.0.0.1:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

final storage = FlutterSecureStorage(); // 반드시 동일한 인스턴스를 사용