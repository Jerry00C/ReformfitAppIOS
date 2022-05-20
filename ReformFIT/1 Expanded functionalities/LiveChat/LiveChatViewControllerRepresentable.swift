//
//  LiveChat.swift
//  ReformFIT
//
//  Created by Chen Chen on 2021-09-18.
//

import Foundation
import UIKit
import SwiftUI
import LiveChat


struct LiveChatUIViewControllerRepresentable:UIViewControllerRepresentable{
    typealias UIViewType = LiveChatViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<LiveChatUIViewControllerRepresentable>) ->  UIViewType{
        let picker = LiveChatViewController()
        return picker
        }

        func updateUIViewController(_ uiViewController: UIViewType, context: UIViewControllerRepresentableContext<LiveChatUIViewControllerRepresentable>) {
             
        }
    
}

struct LiveChatView: View{
//    @EnvironmentObject var LiveChatDelegate: AppDelegate
    var body: some View{
        VStack {
            Button("tap"){
//                LiveChatDelegate.received(message: LiveChatMessage)
                
                LiveChat.licenseId = "1520" // Set your licence number here
                LiveChat.groupId = "77" // Optionally, you can set specific group
                LiveChat.name = "iOS Widget Example" // User name and email can be provided if known
                LiveChat.email = "example@livechatinc.com"
                
                // Setting some custom variables:
                LiveChat.setVariable(withKey:"First variable name", value:"Some value")
                LiveChat.setVariable(withKey:"Second name", value:"Other value")
                LiveChat.presentChat(){
                    finished in
                    print("")
                }
            }
        Button("clear"){
            LiveChat.dismissChat()
            
        }
//            LiveChatUIViewControllerRepresentable()
        }
    }
    
}


struct LiveChatView_Previews: PreviewProvider {
    static var previews: some View {
        LiveChatView()
    }
}
