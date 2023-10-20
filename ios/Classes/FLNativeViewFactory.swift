import Flutter
import UIKit
import BenefitPay_iOS

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    private var banefitPayDelegate: BenefitPayButtonDelegate

    private var banefitPayButton: BenefitPayButton

    init(messenger: FlutterBinaryMessenger,banefitPayDelegate:BenefitPayButtonDelegate, banefitPayButton: BenefitPayButton) {
        self.messenger = messenger
        self.banefitPayDelegate = banefitPayDelegate
        self.banefitPayButton = banefitPayButton
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
            banefitPayDelegate: banefitPayDelegate,
            banefitPayButton: banefitPayButton
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
    private var banefitPayDelegate: BenefitPayButtonDelegate


    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        banefitPayDelegate: BenefitPayButtonDelegate,
        banefitPayButton: BenefitPayButton

    ) {
        self.banefitPayDelegate = banefitPayDelegate
        _view = UIView()
        self._args = args as? [String:Any]
        super.init()
        createNativeView(view: _view, banefitPayButton: banefitPayButton)
    }

    func view() -> UIView {
        return _view
    }

   // var tapCardView = TapCardView.init()

    func createNativeView(view _view: UIView,banefitPayButton: BenefitPayButton){
        _view.backgroundColor = UIColor.clear
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)){
           // self.tapCardView = TapCardView(frame: .init(x: 0, y: 0, width: self._view.frame.width, height: self._view.frame.height))
            self._view.addSubview(banefitPayButton)
            self._view.bringSubviewToFront(banefitPayButton)
            banefitPayButton.translatesAutoresizingMaskIntoConstraints = false
                // adjust the constraints MUST
                NSLayoutConstraint.activate([
                    banefitPayButton.leadingAnchor.constraint(equalTo: self._view.leadingAnchor, constant: 0),
                    banefitPayButton.trailingAnchor.constraint(equalTo: self._view.trailingAnchor, constant: 0),
                    banefitPayButton.centerYAnchor.constraint(equalTo: self._view.centerYAnchor)
                ])
            banefitPayButton.initBenefitPayButton(configDict: self._args ??  [:],delegate: self.banefitPayDelegate)
            print(banefitPayButton.frame)
            }
    }
}
