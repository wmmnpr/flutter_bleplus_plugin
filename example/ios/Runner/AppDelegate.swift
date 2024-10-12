import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let binaryMessenger = controller.binaryMessenger
      
      // Register the Pigeon API here
      BLEPeripheralApiSetup.setUp(binaryMessenger: binaryMessenger, api: BlePlusPlatformImpl(binaryMessenger : binaryMessenger))

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

