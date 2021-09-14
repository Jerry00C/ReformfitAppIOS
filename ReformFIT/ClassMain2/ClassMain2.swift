//
//  ClassMain2.swift
//  ReformFIT
//
//  Created by J on 2021-07-26.
//

import SwiftUI

struct ClassMain2: View {
    
    @State var index: Int
    @State var offset : CGFloat
    
    @ObservedObject var classViewModel: ClassViewModel = ClassViewModel()
    @Binding var rootActive: Bool
    @State var dataLoaded: Bool = false
    
    @State var screenActive: Bool = false
    
    @State var classesModel: [[Class]] = [[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    @State var onlineClassModel: [[Class]] = [[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    
    @State var dates: [String] = []
    
    var body: some View {
        
        ZStack{
            VStack{
                TopBar(rootActive: $rootActive, titleText: "万锦FERRIER试验点")
                
                ZStack{
                
                    Color("black")
                    

                   VStack {
                        TabBars(index:self.$index, offset: self.$offset)
                        GeometryReader{ g in
                            HStack(alignment: .top, spacing:0){
                                                    
                            // this is where u put the main views under the tab bar
                                
                                ClassMainTab1(classesModel: $classesModel, dates: $dates, rootActive: $rootActive)
                                    .frame(width: g.frame(in: .global).width)
                                
                                ClassMainTab2()
                                    .frame(width: g.frame(in: .global).width)
                                
                                ClassMainTab1(classesModel: $onlineClassModel, dates: $dates, rootActive: $rootActive)
                                    .frame(width: g.frame(in: .global).width)
                                    
                                
                            }
                        .offset(x: self.offset)
                        }
                                            
                    }
                    .animation(.default)
                    
                    
                    
                    
                    
                }
                
            }
                .background(Color("black"))
                .navigationTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("black"))
                .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                .opacity(!screenActive ? 1 : 0)
                .onAppear(perform: {
                    screenActive.toggle()
                    classesModel = [[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
                    onlineClassModel = [[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
                    fetchData()
                })
        }
            
        
    }
}

extension ClassMain2{
    
    func fetchData() -> Void{
        if classViewModel.obtainedClassList?.count != 0{
            classViewModel.obtainedClassList?.removeAll()
        }
        
        

        print("testtt: \(classesModel.count)")
        
        print("testtt: \(onlineClassModel.count)")
        print("testttt \(String(describing: classViewModel.obtainedClassList?.count))")
        
        let calendar = Calendar.current
        
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "EDT")
        
        
        let startDate = formatter.string(from: midnight)
        _ = formatter.date(from: startDate)
        
        //print("startDate \(startDate)")
        //print("startDateDate \(String(describing: startDateDate))")
        
        let endDate = calendar.date(byAdding: .day, value: 13, to: midnight)!
        let endDateString = formatter.string(from: endDate)
        
        
        
        for i in 0...13{
            
            
            let nextDay = calendar.date(byAdding: .day, value: i, to: midnight)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM.dd"
            
            dates.append(formatter.string(from: nextDay!))
            
            
            
        }
        
        
        
        
        //print("dates: \(dates)")
        
        //print("startDate: \(startDate)")
        ///print("endDateString: \(endDateString)")
        classViewModel.setDateAndTime(startDateTime: startDate, endDateTime: endDateString)
        
        
        
        classViewModel.getToken {
            //print("classes: \(String(describing: classViewModel.obtainedClassList))")
            if !classViewModel.loading{

                for classModel in classViewModel.obtainedClassList!{
                    
                    //print(classModel.startDateCut)
                    let numOfDaysBetween = Calendar.current.dateComponents([.day], from: midnight,to: classModel.startDateDate).day!
                    
                    
//                    if numOfDaysBetween == 1 && classModel.startDate == startDate{
//                        print("16")
//                        numOfDaysBetween = 0
//                    }
//
                    if classModel.description?.program.programName == "Classes"{
                        
                        
                        //print("className, \(String(describing: classModel.className))")
                        //print("startDate, \(classModel.startDateCut)")
                        //print("index, \(numOfDaysBetween)\n")
                        
                        var added: Bool = false
                        let currentTimeStamp = classModel.startTimestamp
                        for index in 0 ..< classesModel[numOfDaysBetween].count {
                            
                            
                            if currentTimeStamp <=
                                
                                classesModel[numOfDaysBetween][index].startTimestamp{
                                classesModel[numOfDaysBetween].insert(classModel, at: index)
                                added = true
                                break
                            }
                            
                            
                        }
                        if !added {
                            
                            classesModel[numOfDaysBetween].append(classModel)
                        
                        }
                        
                    }
                    else if classModel.description?.program.programName == "Yoga" {
                        var added: Bool = false
                        let currentTimeStamp = classModel.startTimestamp
                        for index in 0 ..< onlineClassModel[numOfDaysBetween].count {
                            
                            
                            if currentTimeStamp <=
                                
                                onlineClassModel[numOfDaysBetween][index].startTimestamp{
                                onlineClassModel[numOfDaysBetween].insert(classModel, at: index)
                                added = true
                                break
                            }
                            
                            
                        }
                        if !added {
                            
                            onlineClassModel[numOfDaysBetween].append(classModel)
                        
                        }
                        
                    }
                
                }

                screenActive = true

            }
        }
        
    }
}



struct TabBars: View {
    @Binding var index: Int
    @Binding var offset : CGFloat
    var tabsCount = 3
    var width = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack (spacing:0){
            HStack(alignment: .center){
                Spacer()
                
                Text("团课")
                    .foregroundColor(self.index == 1 ? Color("white") : Color("grey"))
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .onTapGesture {
                        self.index = 1
                        self.offset = 0
                    }
              
                
                Spacer()
                
                Text("私教")
                    .foregroundColor(self.index == 2 ? Color("white") : Color("grey"))
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .onTapGesture {
                        
                            self.index = 2
                            self.offset = -self.width
                    }
                    
                
                Spacer()
                
                Text("线上教学")
                    .foregroundColor(self.index == 3 ? Color("white") : Color("grey"))
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .onTapGesture {
                        self.index = 3
                        self.offset = -self.width*2
                            
                    }
                    
                Spacer()
                
            }
            
            
            GeometryReader{ g in
                Capsule()
                    .fill(Color("yellow"))
                    .frame(width: self.tabWidth(from: g.size.width)-50, height: 4, alignment: .center)
                    .offset(x: self.selectionBarXOffset(from: g.size.width)+28, y: 2)
                
                
            }.frame(height: 4)
        }
    }
    
    private func selectionBarXOffset(from totalWidth: CGFloat)->CGFloat{
        return self.tabWidth(from: totalWidth) * CGFloat(index-1)
    }
    private func tabWidth(from totalWidth: CGFloat)-> CGFloat{
        return totalWidth/CGFloat(tabsCount)
    }
}





struct ClassMain2_Previews: PreviewProvider {
    
    @State static var rootActive: Bool = false
    static var previews: some View {
        ClassMain2(index: 1, offset: 0, rootActive: $rootActive)
    }
}
