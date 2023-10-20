import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:banefit_pay_flutter/banefit_pay_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelBanefitPayFlutter platform = MethodChannelBanefitPayFlutter();
  const MethodChannel channel = MethodChannel('banefit_pay_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
