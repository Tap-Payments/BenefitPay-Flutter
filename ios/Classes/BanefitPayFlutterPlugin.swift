import Flutter
import UIKit
import BenefitPay_iOS


public class BanefitPayFlutterPlugin: NSObject, FlutterPlugin , BenefitPayButtonDelegate,FlutterStreamHandler {
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
   
    var eventSink: FlutterEventSink?
    var result: FlutterResult?
    var button: BenefitPayButton = .init()
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = BanefitPayFlutterPlugin()
    let factory = FLNativeViewFactory(messenger: registrar.messenger(),banefitPayDelegate: instance, banefitPayButton: instance.button)
    registrar.register(factory, withId: "plugin/banefit_pay_view")
    let eventChannel = FlutterEventChannel(name: "banefit_pay_event", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance)
    let channel = FlutterMethodChannel(name: "banefit_pay_flutter", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      self.result = result
       switch call.method {
       case "start":
           break
       case "start2":
           break
       default:
         result(FlutterMethodNotImplemented)
       }
  }
    
    public func onReady() {
        self.eventSink?(["onReady":"OnReady Callback Executed"])
    }
    
    public func onClicked() {
        self.eventSink?(["onClick":"onClicked Callback Executed"])
    }
    
    public func onCanceled() {
        self.eventSink?(["onCancel":"onCanceled Callback Executed"])
    }
    
    public func onSuccess(data: String) {
        self.eventSink?(["onSuccess":data])
    }
    
    public func onError(data: String) {
        self.eventSink?(["onError":data])

    }
    
    public func onOrderCreated(data: String) {
        
        self.eventSink?(["onOrderCreated":data])

    }
    
    public func onChargeCreated(data: String) {
        self.eventSink?(["onChargeCreated":data])
    }
    
    
}
