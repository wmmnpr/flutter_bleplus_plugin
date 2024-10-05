import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    
    override func applicationDidFinishLaunching(_ notification: Notification) {
        //super.applicationDidFinishLaunching(notification)
        
        // Get the FlutterViewController from the window
        if let flutterViewController = NSApplication.shared.windows.first?.contentViewController as? FlutterViewController {
            
            // Access the FlutterBinaryMessenger from the FlutterViewController
            let binaryMessenger = flutterViewController.engine.binaryMessenger
            
            // Bootstrap your Pigeon-generated API
            BLEPeripheralApiSetup.setUp(binaryMessenger: binaryMessenger, api: BlePlusPlatformImpl())
        }
    }
}

