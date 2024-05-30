import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'benefit_pay_flutter_platform_interface.dart';

/// An implementation of [BenefitPayFlutterPlatform] that uses method channels.
class MethodChannelBenefitPayFlutter extends BenefitPayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('benefit_pay_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
