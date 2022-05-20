//
//  YOUJIUReportPage.swift
//  ReformFIT
//
//  Created by Chen Chen on 2021-09-16.
//

import SwiftUI

struct YOUJIUReportPage: View {
    
    @ObservedObject var reportManager:YOUJIUReportManager = YOUJIUReportManager()
    @State var loggedInLoading:Bool = true
    var body: some View {
        ZStack {
            Color("black")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
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
            if globalVariable.logIn && loggedInLoading{
                initialLoadingScreen
                    .onAppear(){
                        DispatchQueue.main.async {
                            reportManager.initializeToken{
                                token in
                                reportManager.getReport(accessToken: token, phoneNumber: (globalVariable.client?.MobilePhone) ?? ""){
                                    
                                    withAnimation{
                                        loggedInLoading = false
                                    }
            //                        measurementIds = ids
                                }
                            }
                        }
                        
                    }
            }
        }
    }
    var initialLoadingScreen: some View{
        
        InitialLoadingScreen()
    
    }
}

struct YOUJIUReportPage_Previews: PreviewProvider {
    static var previews: some View {
        YOUJIUReportPage()
    }
}
