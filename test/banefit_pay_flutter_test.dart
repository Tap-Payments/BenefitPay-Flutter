import 'package:flutter_test/flutter_test.dart';
import 'package:banefit_pay_flutter/banefit_pay_flutter.dart';
import 'package:banefit_pay_flutter/banefit_pay_flutter_platform_interface.dart';
import 'package:banefit_pay_flutter/banefit_pay_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBanefitPayFlutterPlatform
    with MockPlatformInterfaceMixin
    implements BanefitPayFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BanefitPayFlutterPlatform initialPlatform = BanefitPayFlutterPlatform.instance;

  test('$MethodChannelBanefitPayFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBanefitPayFlutter>());
  });

  test('getPlatformVersion', () async {
//    BanefitPayFlutter banefitPayFlutterPlugin = BanefitPayFlutter();
    MockBanefitPayFlutterPlatform fakePlatform = MockBanefitPayFlutterPlatform();
    BanefitPayFlutterPlatform.instance = fakePlatform;

  //  expect(await banefitPayFlutterPlugin.getPlatformVersion(), '42');
  });
}
