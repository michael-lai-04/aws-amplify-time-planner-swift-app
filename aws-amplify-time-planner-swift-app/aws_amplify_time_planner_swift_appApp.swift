//
//  aws_amplify_time_planner_swift_appApp.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 14/1/2023.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            //Amplify.Logging.logLevel = .verbose
            try Amplify.configure()
            print("Amplify configured with API and Auth plugin")
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
        return true
    }
}

@main
struct aws_amplify_time_planner_swift_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
