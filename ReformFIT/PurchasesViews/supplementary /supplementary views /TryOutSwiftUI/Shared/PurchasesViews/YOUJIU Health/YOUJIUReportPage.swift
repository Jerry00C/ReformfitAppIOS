//
//  YOUJIUReportPage.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-12.
//

import SwiftUI

struct YOUJIUReportPage: View {

    @ObservedObject var reportManager:YOUJIUReportManager = YOUJIUReportManager()
    var body: some View {

        Button(action: {
            reportManager.initializeToken(onCompletion: {
                print("Completed")
            }
            )
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

struct YOUJIUReportPage_Previews: PreviewProvider {
    static var previews: some View {
        YOUJIUReportPage()
    }
}
