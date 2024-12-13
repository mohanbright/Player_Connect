import UIKit
import Flutter
import Firebase
import GoogleSignIn
import flutter_local_notifications
import FBSDKCoreKit

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
      if let error = error {
        print("Error restoring Google sign-in: \(error.localizedDescription)")
      }
    }

    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: self)

    if #available(iOS 12.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
      handleNotification(notification)
    }

    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    handleNotification(userInfo)
    completionHandler(.newData)
  }

  private func handleNotification(_ userInfo: [AnyHashable: Any]) {
    print("Received notification: \(userInfo)")
  }

  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    if ApplicationDelegate.shared.application(app, open: url, options: options) {
      return true
    }
    return super.application(app, open: url, options: options)
  }

  override func application(
    _ application: UIApplication,
    open url: URL,
    sourceApplication: String?,
    annotation: Any
  ) -> Bool {
    if ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
      return true
    }
    return super.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
  }
}
