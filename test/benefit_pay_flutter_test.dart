import 'package:flutter_test/flutter_test.dart';
import 'package:benefit_pay_flutter/benefit_pay_flutter_platform_interface.dart';
import 'package:benefit_pay_flutter/benefit_pay_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBenefitPayFlutterPlatform
    with MockPlatformInterfaceMixin
    implements BenefitPayFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BenefitPayFlutterPlatform initialPlatform = BenefitPayFlutterPlatform.instance;

  test('$MethodChannelBenefitPayFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBenefitPayFlutter>());
  });

  test('getPlatformVersion', () async {
 //   BenefitPayFlutter benefitPayFlutterPlugin = BenefitPayFlutter();
    MockBenefitPayFlutterPlatform fakePlatform = MockBenefitPayFlutterPlatform();
    BenefitPayFlutterPlatform.instance = fakePlatform;

 //   expect(await benefitPayFlutterPlugin.getPlatformVersion(), '42');
  });
}
