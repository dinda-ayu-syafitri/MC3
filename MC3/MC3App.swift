//
//  MC3App.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 09/08/24.
//

import Firebase
import FirebaseAuth
import FirebaseMessaging
import GoogleSignIn
import SwiftData
import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate, ObservableObject {
    @Environment(\.managedObjectContext) private var context
    @StateObject var loginVM = DependencyInjection.shared.loginViewModel()
    @StateObject var messageVM = DependencyInjection.shared.MessageNotifViewModel()
//    @StateObject var messageVM = MessageNotificationViewModel()
//    @EnvironmentObject var messageVM: MessageNotificationViewModel

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        requestNotificationAuthorization()
        Messaging.messaging().delegate = self
        BackgroundTaskManager.shared.scheduleBackgroundTask()
        return true
    }

    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                print("Notification permission granted")
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "No error information")")
            }
        }
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("FCM Token: \(fcmToken ?? "")")
        TokenManager.shared.fcmToken = fcmToken
        let firebaseID = Auth.auth().currentUser?.uid

        DispatchQueue.global().async {
            Task {
                if firebaseID != nil {
                    await self.loginVM.updateFcm(idFirestore: firebaseID!, fcm: fcmToken ?? "")
                }
            }
        }
//        saveUserToFirebase(fcmToken: fcmToken)
    }

//
//    func saveUserToFirebase(fcmToken: String?) {
//        let db = Firestore.firestore()
//        let phoneNumber = "0812 0213131"
//        let name = "Ipad Testt"
//
//        db.collection("users").document(phoneNumber).setData([
//            "name": name,
//            "fcm_token": fcmToken ?? "",
//            "created_at": Timestamp(date: Date())
//        ]) { error in
//            if let error = error {
//                print("Error adding user: \(error.localizedDescription)")
//            } else {
//                print("User added successfully")
//            }
//        }
//    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    // Handle incoming notifications while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
        print("Received push notification")

        let userInfo = response.notification.request.content.userInfo

        print("customMessage: \(String(describing: userInfo["customMessage"]))")

        if let locationLink = userInfo["locationLink"] as? String,
           let senderFCM = userInfo["senderFCM"] as? String, let customMessage = userInfo["customMessage"] as? String
        {
            if customMessage == "userTracked" {
                print("user Tracked sent")
                messageVM.stopSendingNotifications()
                messageVM.userTrackedMessage = "userTracked"
            } else {
                print("Notification received")
            }

            print("customMessage: \(customMessage)")
        }
        completionHandler([.banner, .sound, .badge])
    }

    // Handle FCM data message directly when the app is in foreground or background
    func messaging(_ messaging: Messaging, didReceive remoteMessage: [String: Any]) {
        print("Received data message: \(remoteMessage["customMessage"] as? String ?? "")")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("Received push notification: \(userInfo)")
        handleNotification(userInfo: userInfo)
        completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Tapped on notification: \(userInfo)")
        //        let userInfo = response.notification.request.content.userInfo

        // Access custom data here
        if let locationLink = userInfo["locationLink"] as? String,
           let senderFCM = userInfo["senderFCM"] as? String, let customMessage = userInfo["customMessage"] as? String
        {
            if customMessage != "userTracked" {
                messageVM.sendPushNotification(token: senderFCM, title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Emergency Contact") is tracking!", body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "") is currently tracking you", locationLink: "", senderFCM: "\(TokenManager.shared.fcmToken ?? "")", customMessage: "userTracked")
            }
        }
        handleNotification(userInfo: userInfo)
        completionHandler()
    }

    private func handleNotification(userInfo: [AnyHashable: Any]) {
        if let customMessage = userInfo["customMessage"] as? String {
            if customMessage == "userTracked" {
                print("user Tracked sent")
                DispatchQueue.main.async {
                    self.messageVM.stopSendingNotifications()
                    self.messageVM.userTrackedMessage = "userTracked"
                    print("USER TRACKEDD \(self.messageVM.userTrackedMessage)") // Moved inside the async block
                }
                messageVM.saveTrackStatus(status: "userTracked")
            } else {
                print("Notification received with message: \(customMessage)")
            }
        } else {
            print("Notification received without a customMessage")
        }
    }

    func application(
        _ app: UIApplication,
        open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }

        // If not handled by this app, return false.
        return false
    }
}

@main
struct MC3App: App {
    private let notificationDelegate = NotificationDelegate()

    init() {
        // Set the UNUserNotificationCenter's delegate to our custom delegate
        UNUserNotificationCenter.current().delegate = notificationDelegate

        // Register notification categories here if needed
        NotificationManager.shared.registerActionsWithCategories()

        // Request notification permissions
        NotificationManager.shared.requestAuthorization { granted in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(delegate)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
//                .environmentObject(messageNotifViewModel)
                .modelContainer(for: [EmergencyContacts.self])
        }
    }
}
