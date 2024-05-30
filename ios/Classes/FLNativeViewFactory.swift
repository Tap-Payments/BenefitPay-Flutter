import Flutter
import UIKit
import BenefitPay_iOS

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    private var benefitPayDelegate: PayButtonDelegate

    private var benefitPayButton: PayButtonView

    init(messenger: FlutterBinaryMessenger,benefitPayDelegate:PayButtonDelegate, benefitPayButton: PayButtonView) {
        self.messenger = messenger
        self.benefitPayDelegate = benefitPayDelegate
        self.benefitPayButton = benefitPayButton
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            benefitPayDelegate: benefitPayDelegate,
            benefitPayButton: benefitPayButton
        )
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var _args: [String:Any]?
    private var benefitPayDelegate: PayButtonDelegate


    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        benefitPayDelegate: PayButtonDelegate,
        benefitPayButton: PayButtonView

    ) {
        self.benefitPayDelegate = benefitPayDelegate
        _view = UIView()
        self._args = args as? [String:Any]
        super.init()
        createNativeView(view: _view, benefitPayButton: benefitPayButton)
    }

    func view() -> UIView {
        return _view
    }

   // var tapCardView = TapCardView.init()

    func createNativeView(view _view: UIView,benefitPayButton: PayButtonView){
        _view.backgroundColor = UIColor.clear
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)){
           // self.tapCardView = TapCardView(frame: .init(x: 0, y: 0, width: self._view.frame.width, height: self._view.frame.height))
            self._view.addSubview(benefitPayButton)
            self._view.bringSubviewToFront(benefitPayButton)
            benefitPayButton.translatesAutoresizingMaskIntoConstraints = false
                // adjust the constraints MUST
                NSLayoutConstraint.activate([
                    benefitPayButton.leadingAnchor.constraint(equalTo: self._view.leadingAnchor, constant: 0),
                    benefitPayButton.trailingAnchor.constraint(equalTo: self._view.trailingAnchor, constant: 0),
                    benefitPayButton.centerYAnchor.constraint(equalTo: self._view.centerYAnchor)
                ])
            benefitPayButton.initPayButton(configDict: self._args ??  [:],delegate: self.benefitPayDelegate,payButtonType: PayButtonTypeEnum.BenefitPay)

            }
    }
}
