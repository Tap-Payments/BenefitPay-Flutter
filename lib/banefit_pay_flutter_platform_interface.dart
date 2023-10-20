import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'banefit_pay_flutter_method_channel.dart';

abstract class BanefitPayFlutterPlatform extends PlatformInterface {
  /// Constructs a BanefitPayFlutterPlatform.
  BanefitPayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static BanefitPayFlutterPlatform _instance = MethodChannelBanefitPayFlutter();

  /// The default instance of [BanefitPayFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelBanefitPayFlutter].
  static BanefitPayFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BanefitPayFlutterPlatform] when
  /// they register themselves.
  static set instance(BanefitPayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
