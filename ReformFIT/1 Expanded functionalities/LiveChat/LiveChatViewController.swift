//
//  LiveChatViewController.swift
//  ReformFIT
//
//  Created by Chen Chen on 2021-09-18.
//

import Foundation
import UIKit
import LiveChat
import MapKit


class LiveChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "LiveChat"
//        LiveChat.presentChat()
    }
    
    @IBAction func openChat(_ sender: Any) {
        //Presenting chat:
        LiveChat.presentChat()
    }
    
    @IBAction func clearSession(_ sender: Any) {
        //Clearing session:
        LiveChat.clearSession()
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, LiveChatDelegate,ObservableObject{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        LiveChat.licenseId = "1520" // Set your licence number here
        LiveChat.groupId = "77" // Optionally, you can set specific group
        LiveChat.name = "iOS Widget Example" // User name and email can be provided if known
        LiveChat.email = "example@livechatinc.com"
        
        // Setting some custom variables:
        LiveChat.setVariable(withKey:"First variable name", value:"Some value")
        LiveChat.setVariable(withKey:"Second name", value:"Other value")
        
        LiveChat.delegate = self
        
        return true
    }
    
    // MARK: LiveChatDelegate
    
    func received(message: LiveChatMessage) {
        if (!LiveChat.isChatPresented) {
            // Notifying user
            let alert = UIAlertController(title: "Support", message: message.text, preferredStyle: .alert)
            let chatAction = UIAlertAction(title: "Go to Chat", style: .default) { alert in
                // Presenting chat if not presented:
                if !LiveChat.isChatPresented {
                    LiveChat.presentChat()
                }
            }
            alert.addAction(chatAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func handle(URL: URL) {
        UIApplication.shared.openURL(URL)
    }
}
