import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'banefit_pay_flutter_platform_interface.dart';

/// An implementation of [BanefitPayFlutterPlatform] that uses method channels.
class MethodChannelBanefitPayFlutter extends BanefitPayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('banefit_pay_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
