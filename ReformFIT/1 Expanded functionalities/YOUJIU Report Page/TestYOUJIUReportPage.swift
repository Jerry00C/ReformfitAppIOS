//
//  YOUJIUReportPage.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-12.
//

import SwiftUI

struct TestYOUJIUReportPage: View {
    
    private let phoneNumber = "14379876631"
    private let phoneNumber1 = "16476765784"

    

    @ObservedObject var reportManager:YOUJIUReportManager = YOUJIUReportManager()
    var body: some View {
        NavigationView {
            VStack{
                Button(action: {
                    reportManager.initializeToken{
                        token in
                        reportManager.getReport(accessToken: token, phoneNumber: phoneNumber){
                            
    //                        measurementIds = ids
                        }
                    }
                    
                }, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                })
                
                if reportManager.listOfDataModels.count == reportManager.loadingCounter{
                    ScrollView {
                        VStack(spacing:0) {
                            ForEach(reportManager.listOfDataModels,id: \.self){
                                data in
                                NavigationLink(
                                    destination: WebView(url: data.generateDetailedReportUrl()),
                                    label: {
                                        SingleReportSummary(dataModel: data)
                                    })
                                
                            }
                        }
                    }
                }
            }
        }
    }
}

struct TestYOUJIUReportPage_Previews: PreviewProvider {
    static var previews: some View {
        TestYOUJIUReportPage()
    }
}
