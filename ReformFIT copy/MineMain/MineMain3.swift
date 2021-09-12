//
//  MineMain3.swift
//  ReformFIT
//
//  Created by J on 2021-08-04.
//

import SwiftUI
import Firebase


struct MineMain3: View {
    
    @Binding var stoppedOnce: Bool
    @Binding var screenActive: Bool
    
    @Binding var refreshingHistoryViewModel: RefreshingHistoryViewModel
    @Binding var refreshingProgressViewModel: RefreshingProgressViewModel
    
    @Binding var classInfoHistory: [Class]
    @Binding var classInfoProgress: [Class]
    
    
    
    @State var comingWaitlistMenu: Bool = false
    @State var comingMenu: Bool = false
    @State var comingOnlineMenu: Bool = false
    
    @State var historyMenu: Bool = false
    
    @State var comingWaitlistMenuDis: Bool = false
    @State var comingMenuDis: Bool = false
    @State var comingOnlineMenuDis: Bool = false
    
    @State var historyMenuDis: Bool = false
    
    @State var classClicked: Class = Class(classScheduleId: nil, classId: nil, startDateAndTime: nil, endDateAndTime: nil, maxCapacity: nil, totalBooked: nil, totalBookedWaitlist: nil, isWaitlistAvailable: nil, isAvailable: nil, isCancel: nil, virtualStreamLink: nil, description: nil, staff: nil, location: nil)
    
    @Binding var rootActive: Bool
    @Binding var bottomView: Bool
    
    @State var classInfoActive: Bool = false
    
    @State var removeClientFromClassViewModel = RemoveClientFromClassViewModel()
    @State var removeFromWaitlistViewModel = RemoveFromWaitlistViewModel()
    
    @State var calendarProgressActive = false
    @State var calendarProgressDis = false
    
    @State var calendarHistoryActive = false
    @State var calendarHistoryDis = false
    
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
            
                    Spacer().frame(height: 15)
                    
                    
                    ZStack{
                        VStack{
                            
                            HStack{
                                Text("我的预约")
                                    .foregroundColor(Color("yellow"))
                                Spacer()
                                Image("向下箭头")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("yellow"))
                                    .onTapGesture {
                                        bottomView.toggle()
                                        calendarProgressActive = true
                                    }
                                
                            }
                            
                            DividerView(width: 2)
                            
                            
                            Text("Empty")
                                .foregroundColor(Color("grey"))
                                .opacity(classInfoProgress.count == 0 ? 1 : 0)
                            
                            VStack{
                                ForEach(0..<classInfoProgress.count, id: \.self){index in
                                    
                                    ClassComingInfoTitleEx(classModelEx: $refreshingProgressViewModel.classInfoResponse[index], comingWaitlistMenu: $comingWaitlistMenu, comingMenu: $comingMenu, comingOnlineMenu: $comingOnlineMenu, classClicked: $classClicked, bottomView: $bottomView)
                                        
                                    
                                }
                            
                            
                                Spacer()
                            }
                            .opacity(classInfoProgress.count != 0 ? 1 : 0)
                            
                            
                            HStack{
                                Spacer()
                                
                                Image("向下箭头")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("yellow"))
                                    .onTapGesture {
                                        bottomView.toggle()
                                        calendarProgressActive = true
                                    }
                                
                                Spacer()
                            }
                                
                                
                            
                            
                            
                        }
                        .padding()
                    }
                    .background(Color("black2"))
                    .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
                    .cornerRadius(10)
                    
                    
                        
                        ZStack{
                            VStack{
                                
                                HStack{
                                    Text("我已完成")
                                        .foregroundColor(Color("yellow"))
                                    Spacer()
                                    Image("向下箭头")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color("yellow"))
                                        .onTapGesture {
                                            bottomView.toggle()
                                            calendarHistoryActive = true
                                        }
                                    
                                }
                                
                                DividerView(width: 2)
                                
                                Text("Empty")
                                    .foregroundColor(Color("grey"))
                                    .opacity(classInfoHistory.count == 0 ? 1 : 0)
                                
                                VStack{
                                    ForEach(0..<classInfoHistory.count, id: \.self){index in
                                        
                                        ClassHistoryInfoTitleEx(classModelEx: $classInfoHistory[index], historyMenu: $historyMenu, classClicked: $classClicked, bottomView: $bottomView)
                                            
                                        
                                    }
                                
                                
                                    Spacer()
                                }
                                
                                
                                HStack{
                                    Spacer()
                                    
                                    Image("向下箭头")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color("yellow"))
                                        .onTapGesture {
                                            bottomView.toggle()
                                            calendarHistoryActive = true
                                        }
                                    Spacer()
                                }
                                    
                                
                                
                            }
                            .padding()
                        }
                        .background(Color("black2"))
                        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
                        .cornerRadius(10)
                    
                    
                    Spacer().frame(height: 40)
                    Spacer()
                }
                    
                
            }
            
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("black"))
                .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                .opacity(!screenActive ? 1 : 0)
                //.opacity(0)
                .onAppear(perform: {
                    
                    
                    if globalVariable.logIn{
                       
                        screenActive.toggle()
                        classInfoHistory = []
                        classInfoProgress = []
                        
                        fetchData(){
                            bottomView = false

                            comingWaitlistMenu = false
                            comingMenu = false
                            comingOnlineMenu = false

                            historyMenu = false
                            
                            calendarProgressActive = false

                        }
                    }
                    
                })
                .zIndex(2)
            
            BottomSheetView(cardShown: $calendarProgressActive, cardDismissal: $calendarProgressDis, offset: UIScreen.main.bounds.height, whenExpanded: 20) {
                
                DateRangePicker(dateSelectorCardShown: $calendarProgressActive){selectedDate, selectedDate2 in
                    
                    screenActive.toggle()
                    
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    
                    
                    let startDate = formatter.string(from: selectedDate)
                    let endDate = formatter.string(from: selectedDate2)
                    
                    
                    print("startDate   \(startDate)")
                    print("endDate   \(endDate)")
                    
                    
                    refreshingProgressing(startDate: startDate, endDate: endDate){
                        
                        screenActive.toggle()
                        
                    }
                    
                
                }
                
            }
            .zIndex(1)
            
            
            BottomSheetView(cardShown: $calendarHistoryActive, cardDismissal: $calendarHistoryDis, offset: UIScreen.main.bounds.height, whenExpanded: 20) {
                
                DateRangePicker(dateSelectorCardShown: $calendarHistoryActive){selectedDate, selectedDate2 in
                    
                    screenActive.toggle()
                    
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    
                    
                    let startDate = formatter.string(from: selectedDate)
                    let endDate = formatter.string(from: selectedDate2)
                    
                    
                    print("startDate   \(startDate)")
                    print("endDate   \(endDate)")
                    
                    
                    refreshingHistory(startDate: startDate, endDate: endDate){
                        
                        screenActive.toggle()
                        
                    }
                    
                
                }
                
            }
            .zIndex(1)
            
            
            BottomSheetView(cardShown: $comingWaitlistMenu, cardDismissal: $comingWaitlistMenuDis ,offset:300, whenExpanded: 0){


                
                VStack{
                    Button(action: {
                        
                        removeFromWaitlistViewModel.initalize(waitlistIds: classClicked.waitlistEntryId)
                        
                        removeFromWaitlistViewModel.getToken {
                            print("Toast Message:  cancelled successful")
                           
                            
                            classInfoHistory = []
                            classInfoProgress = []
                            
                            fetchData(){
                                bottomView = false

                                comingWaitlistMenu = false
                                comingMenu = false
                                comingOnlineMenu = false

                                historyMenu = false

                            }
                            
                        } onError: { message in
                            print("error message  \(message)")
                            print("Toast Message:  cancelled failed, try again later")
                            
                            screenActive.toggle()
                        }

                        
                        
                        
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("移除等待列表")
                            Spacer()
                        }
                        .padding(.vertical)
                    })
                    Spacer()
                        .frame(height:0)
                    
                    Button(action: {
                        
                        classInfoActive.toggle()
                        
                    
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("查看课程信息")
                            Spacer()
                        }
                        .padding(.vertical)
                    })
                    
                    
                    
                    DividerView(width: 4)
                    
                    Button(action: {
                        comingMenu.toggle()
                        bottomView.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        .padding(.vertical)
                    })
                }



            }
            .zIndex(1)
            
            BottomSheetView(cardShown: $comingMenu, cardDismissal: $comingMenuDis ,offset:300, whenExpanded: 0){


                
                VStack{
                    Button(action: {
                        screenActive.toggle()
                        removeClientFromClassViewModel.initalize(clientId: globalVariable.clientId ?? "", classId: classClicked.classId ?? 0, lateCancel: classClicked.lateCancel ?? false)
                        
                        removeClientFromClassViewModel.getToken {
                            print("Toast Message:  cancelled successful")
                           
                            
                            classInfoHistory = []
                            classInfoProgress = []
                            
                            fetchData(){
                                bottomView = false

                                comingWaitlistMenu = false
                                comingMenu = false
                                comingOnlineMenu = false

                                historyMenu = false

                            }
                            
                        } onError: { message in
                            print("error message  \(message)")
                            print("Toast Message:  cancelled failed, try again later")
                            
                            screenActive.toggle()
                        }

                        
                        
                    }, label: {
                        HStack {
                            Spacer()
                            if classClicked.lateCancel ?? false{
                                Text("Late Cancel")
                            }
                            else{
                                Text("取消预约")
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                    })
                    Spacer()
                        .frame(height:0)
                    
                    Button(action: {
                        
                        classInfoActive.toggle()
                        
                    
                        
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("查看课程信息")
                            Spacer()
                        }
                        .padding(.vertical)
                    })
                    
                    DividerView(width: 4)
                    
                    Button(action: {
                        comingMenu.toggle()
                        bottomView.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Cancel")
                            Spacer()
                        }
                        .padding(.vertical)
                    })
                }



            }
            .zIndex(1)
            
            
            BottomSheetView(cardShown: $comingOnlineMenu, cardDismissal: $comingOnlineMenuDis ,offset:300, whenExpanded: 0){


                
                    VStack{
                        Button(action: {
                            screenActive.toggle()
                            removeClientFromClassViewModel.initalize(clientId: globalVariable.clientId ?? "", classId: classClicked.classId ?? 0, lateCancel: classClicked.lateCancel ?? false)
                            
                            removeClientFromClassViewModel.getToken {
                                print("Toast Message:  cancelled successful")
                               
                                
                                classInfoHistory = []
                                classInfoProgress = []
                                
                                fetchData(){
                                    bottomView = false

                                    comingWaitlistMenu = false
                                    comingMenu = false
                                    comingOnlineMenu = false

                                    historyMenu = false

                                }
                                
                            } onError: { message in
                                print("error message  \(message)")
                                print("Toast Message:  cancelled failed, try again later")
                                
                                screenActive.toggle()
                            }

                        }, label: {
                            HStack {
                                Spacer()
                                if classClicked.lateCancel ?? false{
                                    Text("Late Cancel")
                                }
                                else{
                                    Text("取消预约")
                                }
                                Spacer()
                            }
                            .padding(.vertical)
                        })
                        
                        Spacer()
                            .frame(height:0)
                        
                        Button(action: {
                            
                            classInfoActive.toggle()
                            
                        
                            
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("查看课程信息")
                                Spacer()
                            }
                            .padding(.vertical)
                        })
                        
                        Spacer()
                            .frame(height:0)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            HStack {
                                Spacer()
                                Text("进入直播间")
                                Spacer()
                            }
                            .padding(.vertical)
                        })
                        
                        DividerView(width: 4)
                        
                        Button(action: {
                            
                            comingMenu.toggle()
                            bottomView.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Cancel")
                                Spacer()
                            }
                            .padding(.vertical)
                        })
                    }



            }
            .zIndex(1)
            
            
            BottomSheetView(cardShown: $historyMenu, cardDismissal: $historyMenuDis ,offset:300, whenExpanded: 0){
                
                    VStack{
                        Button(action: {
                            
                            classInfoActive.toggle()
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("查看课程信息")
                                Spacer()
                            }
                            .padding(.vertical)
                        })
                        
                        DividerView(width: 4)
                        
                        Button(action: {
                            comingMenu.toggle()
                            bottomView.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Cancel")
                                Spacer()
                            }
                            .padding(.vertical)
                        })
                    }



            }
            .zIndex(1)
            
            
            NavigationLink(destination: ClassInfo(classInfo: classClicked, rootActive: $rootActive), isActive: $classInfoActive){
                Text("")
            }
            
            
        }
    }
}

extension MineMain3{
    
    func refreshing() -> Void{
        
        screenActive.toggle()
        fetchData(){
            
        }
        
    }
}

extension MineMain3{
    
    func fetchData(onCompletion:@escaping()->Void) -> Void{
        print("fetching")
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let auth = Auth.auth()
        let date = auth.currentUser?.metadata.creationDate ?? Date()
        let startDate = formatter.string(from: date)
        
        
        
        let date2 = Date()
        let endDate = formatter.string(from: date2)
        
        let date3 = Calendar.current.date(byAdding: .month, value: 12, to: date2) ?? Date()
        let endDate2 = formatter.string(from: date3)
        
        
        print("Start date:  \(startDate)")
        print("end date:   \(endDate)")
        print("end date 2:   \(endDate2)")
        
        
        
        refreshingHistory(startDate: startDate, endDate: endDate){
            if !stoppedOnce {
                stoppedOnce = true
            }
            else{
                screenActive.toggle()
                stoppedOnce = false
                onCompletion()
            }
        }
        
        
        refreshingProgressing(startDate: endDate, endDate: endDate2){
            
            
            
            if !stoppedOnce {
                stoppedOnce = true
            }
            else{
                screenActive.toggle()
                stoppedOnce = false
                onCompletion()
            }
        }
        
       
        

    }
    
    func refreshingHistory(startDate: String, endDate: String, onCompletion:@escaping()->Void) -> Void{
        
        
        print("refreshingHistory")
        self.refreshingHistoryViewModel.initialize(startDate: startDate, endDate: endDate, limited: true)
        
        self.refreshingHistoryViewModel.getToken {
            if !refreshingHistoryViewModel.loading{
                print("history count \(refreshingHistoryViewModel.classInfoResponse.count)")
                
                if(self.classInfoHistory.count != 0){
                    self.classInfoHistory = []
                }
                
                self.classInfoHistory = refreshingHistoryViewModel.classInfoResponse
                    
                print("history count after \(classInfoHistory.count)")
                
                onCompletion()
            }
        }
       
   }
    
    
    func refreshingProgressing(startDate: String, endDate: String, onCompletion:@escaping()->Void) -> Void{
       
        print("refreshingProgressing")
        self.refreshingProgressViewModel.initialize(startDate: startDate, endDate: endDate, limited: true)
        
        self.refreshingProgressViewModel.getToken {
            
            if !refreshingProgressViewModel.loading{
                print("progress count \(refreshingProgressViewModel.classInfoResponse.count)")
               
                if(self.classInfoProgress.count != 0){
                    self.classInfoProgress = []
                }
                self.classInfoProgress = refreshingProgressViewModel.classInfoResponse
                
                print("progress classInfoResponse  \(refreshingProgressViewModel.classInfoResponse)")
                
                print("progress  self.classInfoProgress  \( self.classInfoProgress)")
                print("progress count after \(classInfoProgress.count)")
                onCompletion()
            }
        }
       
       
   }
}





struct ClassComingInfoTitleEx: View{
    
    @Binding var classModelEx: Class
    
    @Binding var comingWaitlistMenu: Bool
    @Binding var comingMenu: Bool
    @Binding var comingOnlineMenu: Bool
    
    @Binding var classClicked: Class
    @Binding var bottomView: Bool
    
    var body: some View{
        
        ZStack{
            HStack{
            
                ZStack{
                    if classModelEx.staff?.staffImage != nil {
                    
                        AsyncImage(url: URL(string: (classModelEx.staff?.staffImage)!)!,
                                       placeholder: { ProgressView() },
                                       image: { Image(uiImage: $0).resizable()
                                        })
                            .frame(width: 70, height: 70, alignment: .center)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    else{
                        
                        Text("loading")
                            .frame(width: 70, height: 70, alignment: .center)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                    if classModelEx.description?.program.programName != "Classes" {
                        
                        VirtualIndicator()
                    }
                }
                
                
                
                VStack{
                    HStack{
                        Text(classModelEx.className ?? "")
                            .foregroundColor(Color("white"))
                        Spacer()
                    }
                    
                    HStack{
                        Text(classModelEx.startDateCut)
                            .foregroundColor(Color("yellow"))
                        
                        Spacer().frame(width: 8)
                        
                        Text(classModelEx.startTimeCut + "-" + classModelEx.endTimeCut)
                            .foregroundColor(Color("white"))
                            .background(Color("black4"))
                        
                        Spacer()
                    }
                    
                    HStack{
                        Text("ReformFIT Markham")
                            .foregroundColor(Color("grey"))
                        Spacer()
                    }
                    
                        
                    
                }
                Image("向下箭头")
                    .resizable()
                    .frame(width: 18, height: 18)
                
            }
            
            
            
            HStack{
                Spacer()
                VStack{
                    
                    if classModelEx.waitlist{
                    
                        WaitlistIndicator(text: "\(classModelEx.waitlistOrder)/4")
                    
                    }
                    
                    Spacer()
            
                }
            }
            
            
            

        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width * 0.88,height: 80)
        .cornerRadius(10)
        .onTapGesture{
            
                if classModelEx.waitlist{
                    comingWaitlistMenu.toggle()
                }
                else {
                    if classModelEx.description?.program.programName == "Classes"{
                        
                        comingMenu.toggle()
                        
                    }
                    else{
                        
                        comingOnlineMenu.toggle()
                        
                        
                    }
                }
            
                classClicked = classModelEx
                bottomView.toggle()
            
            
        }
    }
    
    
    
    
    
    
}




struct ClassHistoryInfoTitleEx: View{
    
    @Binding var classModelEx: Class
    @Binding var historyMenu: Bool
    
    @Binding var classClicked: Class
    @Binding var bottomView: Bool
    
    var body: some View{
        
        ZStack{
            HStack{
            
                ZStack{
                    if classModelEx.staff?.staffImage != nil {
                    
                        AsyncImage(url: URL(string: (classModelEx.staff?.staffImage)!)!,
                                       placeholder: { ProgressView() },
                                       image: { Image(uiImage: $0).resizable()
                                        })
                            .frame(width: 70, height: 70, alignment: .center)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                    else{
                        
                        Text("loading")
                            .frame(width: 70, height: 70, alignment: .center)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                    if classModelEx.description?.program.programName != "Classes" {
                        
                        VirtualIndicator()
                    }
                }
                
                
                
                VStack{
                    HStack{
                        Text(classModelEx.className ?? "")
                            .foregroundColor(Color("white"))
                        Spacer()
                    }
                    
                    HStack{
                        Text(classModelEx.startDateCut)
                            .foregroundColor(Color("yellow"))
                        
                        Spacer().frame(width: 8)
                        
                        Text(classModelEx.startTimeCut + "-" + classModelEx.endTimeCut)
                            .foregroundColor(Color("white"))
                            .background(Color("black4"))
                        
                        Spacer()
                    }
                    
                    HStack{
                        Text("ReformFIT Markham")
                            .foregroundColor(Color("grey"))
                        Spacer()
                    }
                    
                        
                    
                }
                Image("向下箭头")
                    .resizable()
                    .frame(width: 18, height: 18)
                
            }
            

        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width * 0.88,height: 80)
        .cornerRadius(10)
        .onTapGesture{
            historyMenu.toggle()
            
            
            classClicked = classModelEx
            bottomView.toggle()
        }
    }
    
    
    
    
    
    
}



struct MineMain3_Previews: PreviewProvider {
    @State static var fab: Bool = false
    
    
    static var previews: some View {
        MineMain(bottomView: $fab)
    }
}
