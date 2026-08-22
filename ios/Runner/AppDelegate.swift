//// import Flutter
//// import UIKit
////
//// @main
//// @objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
////   override func application(
////     _ application: UIApplication,
////     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
////   ) -> Bool {
////     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
////   }
////
////   func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
////     GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
////   }
//// }
//import UIKit
//import Flutter
//
//@main
//@objc class AppDelegate: FlutterAppDelegate {
//
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//
//    GeneratedPluginRegistrant.register(with: self)
//
//    return super.application(
//      application,
//      didFinishLaunchingWithOptions: launchOptions
//    )
//  }
//}
//import UIKit
//import Flutter
//import GoogleMaps
//
//@main
//@objc class AppDelegate: FlutterAppDelegate {
//  override func application(
//  _ application: UIApplication,
//  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//
//    GMSServices.provideAPIKey("AIzaSyD0Qn6kSmSEVASiBX8xAfcFijyUZum8-xU")
//
//    GeneratedPluginRegistrant.register(with: self)
//
//    return super.application(
//      application,
//      didFinishLaunchingWithOptions: launchOptions
//    )
//  }
//}
import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GeneratedPluginRegistrant.register(with: self)

    return super.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
  }
}
