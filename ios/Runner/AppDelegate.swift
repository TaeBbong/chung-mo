import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.taebbong.chungMo.share_intent"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let sharedDataChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

        sharedDataChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getSharedData" {
                let userDefaults = UserDefaults(suiteName: "group.com.taebbong.chungMo")
                let sharedData = userDefaults?.string(forKey: "sharedData")
                result(sharedData)
                userDefaults?.removeObject(forKey: "sharedData")  // Clear after retrieval
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
