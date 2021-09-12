//
//  ReformFITApp.swift
//  ReformFIT
//
//  Created by J on 2021-07-19.
//

import SwiftUI
import Firebase

@main
struct ReformFITApp: App {
    
    init(){
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        
        WindowGroup(Text("www")){
            Main()
        }
        
    }
}
