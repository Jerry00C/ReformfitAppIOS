//
//  Service1Info.swift
//  ReformFIT
//
//  Created by J on 2021-09-10.
//

import SwiftUI



private struct OffsetPreferenceKey: PreferenceKey{
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat){}
}

struct Service1Info: View {
    
    @Binding var rootActive: Bool
    
    
    @ObservedObject var locationViewModel: LocationViewModel = LocationViewModel()
    
    @State var screenActive: Bool = false
    
    
    @State var scrollViewOverFlow: Bool = false
    
    @State var thresh0: CGFloat = 0
    @State var thresh1: CGFloat = 0
    @State var thresh2: CGFloat = 0
    
    @State var scrollPos: Int = 0
    
    
    @State var lIntroText: String = ""
    @State var lat: Double = 0
    @State var lon: Double = 0
    @State var phoneNum: String = ""
    @State var address: String = ""
    
    
    
    var body: some View {
        
        
        ZStack{
            VStack{
                TopBar(rootActive: $rootActive, titleText: "万锦试验点")
                
                ScrollViewReader{proxy in
                    
                    if scrollViewOverFlow{
                        HStack{
                            Text("Description")
                                .foregroundColor(scrollPos == 1 ? Color("white") : Color("grey"))
                                .onTapGesture {
                                    
                                    withAnimation{
                                        proxy.scrollTo("thresh1", anchor: .top)
                                        
                                    }
                                    
                                }
                            Text("Note")
                                .foregroundColor(scrollPos == 2 ? Color("white") : Color("grey"))
                                .onTapGesture {
                                    
                                    withAnimation{
                                        proxy.scrollTo("thresh2", anchor: .top)
                                    }
                                
                                    
                                }
                            Spacer()
                        }
                    }
                    GeometryReader{geometry in
                        ScrollView{
                            VStack{
                            
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
                                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                                
                                GeometryReader{geo in
                                    Text("")
                                        .frame(height: 1)
                                        .onAppear{
                                            thresh0 = geo.frame(in: .named("scroll")).origin.y
                                            
                                    }
                                        
                                }
                                .frame(height: 1)
                                if !scrollViewOverFlow{
                                    HStack{
                                        Text("场地信息")
                                            .foregroundColor(scrollPos == 1 ? Color("white") : Color("grey"))
                                            .onTapGesture {
                                                
                                                withAnimation{
                                                    proxy.scrollTo("thresh1", anchor: .top)
                                                    
                                                }
                                                
                                            }
                                        Text("注意事项")
                                            .foregroundColor(scrollPos == 2 ? Color("white") : Color("grey"))
                                            .onTapGesture {
                                               
                                                withAnimation{
                                                    proxy.scrollTo("thresh2", anchor: .top)
                                                }
                                            
                                                
                                            }
                                        Spacer()
                                    }
                                }
                                
                                VStack{
                                    GeometryReader{geo in
                                        Text("")
                                            .frame(height: 1)
                                            .onAppear{
                                                thresh1 = geo.frame(in: .named("scroll")).origin.y
                                            
                                        }
                                        
                                    }
                                    .frame(height: 1)
                                    
                                    
                                
                                   
                                    GeometryReader{geo in
                                        Text("")
                                            .frame(height: 1)
                                            .onAppear{
                                                thresh2 = geo.frame(in: .named("scroll")).origin.y
                                                
                                        }
                                            
                                    }
                                    .frame(height: 1)
                                    
                                    
                                   
                                    
                                        
                                }
                        
                                Spacer()
                                
                            }
                            
                            .background(GeometryReader {
                                Color.clear.preference(key: OffsetPreferenceKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                            })
                            .onPreferenceChange(OffsetPreferenceKey.self){value in
                                print("\(value)--thresh 0: \(thresh0+4)--thresh 2: \(thresh2 - 25)")
                                //print("thresh 1: \(threshView1)")
                                
                                if value < (thresh0+4){
                                    scrollPos = 0
                                }
                                else if value > (thresh0+4) && value < (thresh2-25) {
                                    scrollPos = 1
                                }
                                else if value > (thresh2-25) {
                                    scrollPos = 2
                                }
                                
                                
                                if value <= (thresh0+4) {
                                    scrollViewOverFlow = false
                                }
                                else{
                                    scrollViewOverFlow = true
                                }
                                
                        
                        
                            }
                        }
                    
                    }
                    .coordinateSpace(name: "scroll")
                         
                                
                               
                                
                            
                            
                        
                }
                        
                    
                
            
                Text("")
                
            
            }
                .background(Color("black"))
                .navigationTitle("")
                .navigationBarHidden(true)
                .statusBar(hidden: false)
                .navigationBarBackButtonHidden(true)
            
        }
        
    }
}

struct TitleBar: View{
    var iconText: String
    var titleText: String
    
    var body: some View{
        
        HStack{
            Image(iconText)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(Color("yellow"))
            
            
            
            Text(titleText)
                .foregroundColor(Color("yellow"))
            
            Spacer()
            
            
            
        }
    }
}

struct ServiceTitleView: View{
    
    @Binding var rootActive: Bool
    
    
    var body: some View{
        ZStack{
            
            VStack{
                
                HStack{
                    Image("Fat Shredder")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("yellow"))
                    
                    
                    
                    Text("FAT Shredder")
                        .foregroundColor(Color("yellow"))
                    
                    Spacer().frame(width: 0)
                    
                    Text("TM")
                        .font(.caption)
                        .baselineOffset(3)
                    
                    Spacer()
                    
                    
                    
                }
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
    
}

struct IntroView: View{
    @State var limitActive: Bool = false
    
    var body: some View{
        ZStack{
            VStack{
                TitleBar(iconText: "场地简介", titleText: "Class Introduction")
            
               
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
            
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}


struct EffectView: View{
    
    @State var limitActive: Bool = false
    var body: some View{
        
        
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "课程效果", titleText: "课程效果")
                
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
                
                HStack{
                    Spacer()
                    ForEach(0..<effectGrid.count){ row in
                            
                            VStack{
                                Image(effectGrid[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(effectGrid[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}


struct HeartRateView: View{
    
    @State var limitActive: Bool = false
    var body:some View{
        ZStack{
            VStack{
                
                CardViewTitleBar(iconText: "心率监测", titleText: "心率监测")
                
                
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
                
                
                HeartRateEx(imageText: "Zone 1", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 2", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 3", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 4", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 5", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                
                
                
                Text("链接")
                    .underline()
                    .foregroundColor(Color("yellow"))
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}
struct ClientView: View{
    var body:some View{
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "适合人群", titleText: "适合人群")
                
                HStack{
                    Spacer()
                    ForEach(0..<lMoreServiceGrid.count){ row in
                            
                            VStack{
                                Image(lMoreServiceGrid[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(lMoreServiceGrid[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
                
                
                
                
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}


struct StepView: View{
    var body: some View{
        ZStack{
            VStack{
                
                
                CardViewTitleBar(iconText: "上课步骤", titleText: "健身步骤")
                
                CStepElementView(stepNum: "1", stepContent: "联系客服领取免费体验")
                
                
                CStepElementView(stepNum: "2", stepContent: "购买课包或加入会员")
                
                
                CStepElementView(stepNum: "3", stepContent: "预约正式上课时间")
                
                
                CStepElementView(stepNum: "4", stepContent: "到店入场上课")
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}

struct StepElementView: View{
    
    var stepNum: String
    var stepContent: String
    
    
    var body: some View{
        ZStack{
            HStack{
                Spacer().frame(width: 3)
                Text(stepNum)
                    .padding(5)
                    .foregroundColor(Color("yellow"))
                    .background(Circle().stroke(Color("yellow"), lineWidth: 1))
                
                Spacer()
                
                
            }
            .padding(2)
            
            HStack(alignment: .center, spacing: 0, content: {
                    Spacer()
                    
                
                    Text(stepContent)
                        .foregroundColor(Color("white"))
                    
                    if(stepNum == "1"){
                        Text("新人专享")
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .foregroundColor(Color("yellow"))
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color("yellow"), lineWidth: 1))
                       
                    }
                    
                    Spacer()
            })
            .padding(2)
            
        }
        .background(Color("black4"))
        .cornerRadius(10)
    }
}





struct FaqView: View{
   
        
    @State var limitActive: Bool = false
    var body: some View{
        
        
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "FAQ", titleText: "FAQ")
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}

struct WarningView: View{
   
        
    @State var limitActive: Bool = false
    var body: some View{
        
        
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "注意事项", titleText: "注意事项")
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}

struct MoreServiceView: View{
    
    
    
    var body: some View{
        
        
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "更多服务", titleText: "更多服务")
                
                HStack{
                    Spacer()
                    ForEach(0..<lMoreServiceGrid.count){ row in
                            
                            VStack{
                                Image(lMoreServiceGrid[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(lMoreServiceGrid[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
                
                
                
                
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}





struct Service1Info_Previews: PreviewProvider {
   
    @State static var rootActive: Bool = false
    static var previews: some View {
        Service1Info(rootActive: $rootActive)
    }
}
