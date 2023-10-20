import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TapBanefitPayWidget extends StatefulWidget {
  final Map<String, dynamic> sdkConfiguration;
  final Function()? onReady, onClick, onCancel;
  final Function(String?)? onSuccess, onError, onOrderCreated, onChargeCreated;

  const TapBanefitPayWidget({
    super.key,
    required this.sdkConfiguration,
    this.onReady,
    this.onClick,
    this.onSuccess,
    this.onError,
    this.onCancel,
    this.onChargeCreated,
    this.onOrderCreated,
  });

  @override
  State<TapBanefitPayWidget> createState() => _TapBanefitPayWidgetState();
}

class _TapBanefitPayWidgetState extends State<TapBanefitPayWidget> {
  late Function()? onReadyFunction;
  late Function()? onClickFunction;
  late Function()? onCancelFunction;
  late Function(String?)? onSuccessFunction;
  late Function(String?)? onErrorFunction;
  late Function(String?)? onChargeCreatedFunction;
  late Function(String?)? onOrderCreatedFunction;

  static const MethodChannel _channel = MethodChannel('banefit_pay_flutter');

  static const EventChannel _eventChannel = EventChannel('banefit_pay_event');

  void streamTimeFromNative() {
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(dynamic event) {
    //Receive Event
    var data = "Start Listing..";
    if (event.toString() != null) {
      data = event.toString();
    }
    handleCallbacks(event);
  }

  void _onError(dynamic event) {}

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      streamTimeFromNative();
      startTapCardSDK();
    });
    super.initState();
  }

  Future<dynamic> startTapCardSDK() async {
    try {
      dynamic result = await _channel.invokeMethod(
        'start',
        {
          "configuration": widget.sdkConfiguration,
        },
      );
      handleCallbacks(result);
      _startTapCardSDK2();
      // return responseData;
    } catch (ex) {
      debugPrint("Start SDK Exception >>>>>> $ex");
    }
  }

  Future<dynamic> _startTapCardSDK2() async {
    try {
      dynamic result = await _channel.invokeMethod(
        'start2',
        {
          "configuration": widget.sdkConfiguration,
        },
      );

      handleCallbacks(result);
      _startTapCardSDK2();
      //  return responseData;
    } catch (ex) {
      debugPrint("Exception >>>>>> $ex");
    }
  }

  handleCallbacks(dynamic result) {
    if (result.containsKey("onReady")) {
      debugPrint("On ready callback fired");
      onReadyFunction = widget.onReady;
      onReadyFunction!();
    }

    if (result.containsKey("onClick")) {
      debugPrint("On Click callback fired");
      onReadyFunction = widget.onReady;
      onReadyFunction!();
    }

    if (result.containsKey("onSuccess")) {
      /// onSuccess Callbacks Triggered From SDK
      debugPrint("On Success callback fired");
      var resultOfSuccess = jsonDecode(result["onSuccess"]);
      onSuccessFunction = widget.onSuccess;
      onSuccessFunction!(resultOfSuccess.toString());
    }

    if (result.containsKey("onError")) {
      debugPrint("On Error Callback Fired>>>>> ${result["onError"]} ");
      var resultOfError = jsonDecode(result["onSuccess"]);
      onErrorFunction = widget.onError;
      onErrorFunction!(resultOfError.toString());
    }

    if (result.containsKey("onOrderCreated")) {
      /// onValidInput Callbacks Triggered From SDK
      debugPrint("On Error Callback Fired>>>>>");
      var resultOfOnOrderCreated = jsonDecode(result["onOrderCreated"]);
      onOrderCreatedFunction = widget.onOrderCreated;
      onOrderCreatedFunction!(resultOfOnOrderCreated.toString());
    }

    if (result.containsKey("onCancel")) {
      /// onValidInput Callbacks Triggered From SDK
      debugPrint("On Cancel Callback Fired>>>>>");
    //  var resultOfOnOrderCreated = jsonDecode(result["onCancel"]);
      onCancelFunction = widget.onCancel;
      onCancelFunction!();
    }

    if (result.containsKey("onChargeCreated")) {
      /// onValidInput Callbacks Triggered From SDK
      var resultOfOnChargeCreated = jsonDecode(result["onChargeCreated"]);
      onChargeCreatedFunction = widget.onChargeCreated;
      onChargeCreatedFunction!(resultOfOnChargeCreated.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return SizedBox(
        height: 48,
        child: AndroidView(
          viewType: "plugin/banefit_pay_view",
          creationParams: widget.sdkConfiguration,
          creationParamsCodec: const StandardMessageCodec(),
          layoutDirection: TextDirection.ltr,
        ),
      );
    } else {
      return SizedBox(
        height: 48,
        child: UiKitView(
          viewType: "plugin/banefit_pay_view",
          creationParams: widget.sdkConfiguration,
          layoutDirection: TextDirection.ltr,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    }
  }
}
