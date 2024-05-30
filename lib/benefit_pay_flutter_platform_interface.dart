import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'benefit_pay_flutter_method_channel.dart';

abstract class BenefitPayFlutterPlatform extends PlatformInterface {
  /// Constructs a BenefitPayFlutterPlatform.
  BenefitPayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static BenefitPayFlutterPlatform _instance = MethodChannelBenefitPayFlutter();

  /// The default instance of [BenefitPayFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelBenefitPayFlutter].
  static BenefitPayFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BenefitPayFlutterPlatform] when
  /// they register themselves.
  static set instance(BenefitPayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
