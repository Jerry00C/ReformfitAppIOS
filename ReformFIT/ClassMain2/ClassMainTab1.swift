//
//  ClassMainTab1.swift
//  ReformFIT
//
//  Created by J on 2021-08-11.
//

import SwiftUI

struct ClassMainTab1: View {
    
    @Binding var classesModel: [[Class]]
    @Binding var dates: [String]
    
    @Binding var rootActive: Bool
    
    @State var selectedPage = 0
    
    
    
    var body: some View {
        
        VStack{
            Spacer().frame(height: 10)
            TabView(){
                Image("wifi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color("yellow"))
                    
                
                Image("wifi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color("yellow"))
                    
                
                Image("wifi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color("yellow"))
                
                    
                
                Image("wifi")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color("yellow"))
                
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
            .onAppear(perform: {
                print(dates)
            })
            
            ScrollViewReader{proxy in
                ScrollView(.horizontal){
                    HStack(alignment: .center, spacing: 0, content: {
                            Spacer()
                        ForEach(0..<dates.count, id: \.self){index in
                                Text(dates[index])
                                    .foregroundColor(selectedPage == index ? Color("yellow") : Color("white") )
                                    .id(String(index))
                                    .onTapGesture {
                                        selectedPage = index
                                        withAnimation{proxy.scrollTo(String(index), anchor: .center)
                                        }
                                    }
                                
                                Spacer()
                            }
                        })
                }
            }
            
            TabView(selection: $selectedPage,
                    content:  {
                        
                        ForEach(0..<classesModel.count, id: \.self){index in
                            
                            ScrollView{
                                VStack{
                                    ForEach(0..<classesModel[index].count, id: \.self){index2 in
                                        
                                        ClassInfoTitleEx(classModelEx: classesModel[index][index2], rootActive: $rootActive)
                                        
                                        
                                    }
                                
                                
                                    Spacer()
                                }
                            }.tag(index)
                            
                        }
                    })
                
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
            Spacer()
        }
        
    }
    
}

struct ClassInfoTitleEx: View{
    
    @State var classModelEx: Class
    @Binding var rootActive: Bool
    
    var body: some View{
        
        NavigationLink(destination: ClassInfo(classInfo: classModelEx, rootActive: $rootActive)){
            
            ZStack{
                HStack{
                
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
                    
                    
                    
                    VStack{
                        HStack{
                            Text(classModelEx.className ?? "")
                                .foregroundColor(Color("white"))
                            Spacer()
                        }
                        
                        HStack{
                            Text(classModelEx.startTimeCut + "-" + classModelEx.endTimeCut)
                                .foregroundColor(Color("yellow"))
                            
                            Spacer().frame(width: 8)
                            
                            Text("400-8004 kcal")
                                .foregroundColor(Color("white"))
                                .background(Color("black4"))
                            
                            Spacer()
                        }
                        
                        HStack{
                            Text("燃脂|HIIT|拳击|心肺训练")
                                .foregroundColor(Color("grey"))
                            Spacer()
                        }
                        
                            
                        
                    }
        
                }
                
                HStack{
                    Spacer()
                    VStack{
                        
                        if classModelEx.totalBookedWaitlist == 4{
                            
                            WaitlistIndicator(text: "FULL")
                                .frame(width: 10, height: 10)
                                .offset(x: -50)
                        }
                        else if classModelEx.totalBookedWaitlist == 2{

                            WaitlistIndicator(text: "BUSY")                      
                        
                        }
                        
                        Spacer()
                
                    }
                }
            }
            
            
        }
        
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width * 0.92,height: 80)
        .cornerRadius(10)
    }
    
    
    
    
    
    
}

struct ClassMainTab1_Previews: PreviewProvider {
    @State static var rootActive: Bool = false
    static var previews: some View {
        ClassMain2(index: 1, offset: 0, rootActive: $rootActive)
    }
}
