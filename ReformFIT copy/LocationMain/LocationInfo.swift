//
//  LocationInfo.swift
//  ReformFIT
//
//  Created by J on 2021-07-28.
//

import SwiftUI
import MobileCoreServices

private struct OffsetPreferenceKey: PreferenceKey{
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat){}
}

struct LocationInfo: View {
    
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
                TopBar(rootActive: $rootActive, titleText: "万锦FERRIER试验点")
                
                
                ScrollViewReader{proxy in
                    
                    if scrollViewOverFlow{
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
                                    
                                    LServiceView(rootActive: $rootActive)
                                        .id("thresh1")
                                    
                                
                                    LLocationIntroView(descText: lIntroText)
                                    
                                    GeometryReader{geo in
                                        Text("")
                                            .frame(height: 1)
                                            .onAppear{
                                                thresh2 = geo.frame(in: .named("scroll")).origin.y
                                                
                                        }
                                            
                                    }
                                    .frame(height: 1)
                                    
                                    LStepView()
                                        .id("thresh2")
                                    
                                    
//                                    .background(Color("black3"))
//                                    .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
//                                    .cornerRadius(10)
                                    
                                    
                                    LWarningView()
                                            
                                    LContactView(phoneNum: phoneNum)
                                            
                                    LAddress(address: address)
                                            
                                    LMoreServiceView()
                                        
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
            
            
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("black"))
                .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                .opacity(!screenActive ? 1 : 0)
                .onAppear(perform: {
                    fetchData()
                })
        }
        
    }
}

extension LocationInfo{
    
    func fetchData() -> Void{
        print("fetching")
        
        locationViewModel.getToken {
            
            print("name: \(String(describing: locationViewModel.obtainedLocation!.description))")
            
            if !locationViewModel.loading{
                
                lIntroText = locationViewModel.obtainedLocation?.description ?? ""
                phoneNum = locationViewModel.obtainedLocation?.phone ?? ""
                lon = locationViewModel.obtainedLocation?.lat ?? 0
                lat = locationViewModel.obtainedLocation?.lon ?? 0
                
                address = locationViewModel.obtainedLocation?.address ?? ""
                
                
                screenActive = true
            }
        }
    }
}

struct LScrollHeader: View{
    @Binding var proxy: ScrollViewProxy
    
    var body: some View{
        
        HStack{
            Text("场地信息")
                .foregroundColor(Color("white"))
                .onTapGesture {
                    proxy.scrollTo("thresh1")
                }
            Text("注意事项")
                .foregroundColor(Color("white"))
                .onTapGesture {
                    proxy.scrollTo("thresh2")
                }
            Spacer()
        }
    }
}

struct LServiceView: View{
    
    @Binding var rootActive: Bool
    
    
    var body: some View{
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "场地服务", titleText: "场地服务")
                
                
                ServiceDetailSelectionView(serviceName: "健身团课", rootActive: $rootActive, pos: 1)
                
                Spacer().frame(height:10)
                
                ServiceDetailSelectionView(serviceName: "精品私教",  rootActive: $rootActive, pos: 2)
                
                Spacer().frame(height:10)
                
                ServiceDetailSelectionView(serviceName: "线上训练",  rootActive: $rootActive, pos: 3)
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
    
}

struct LLocationIntroView: View{
    var descText: String
    var body: some View{
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "场地简介", titleText: "场地简介")
            
                HStack{
                    Text(descText == "" ? "Empty" : descText )
                        .foregroundColor(Color("grey"))
                    Spacer()
                }
                
                Spacer().frame(height: 10)
                
                HStack{
                    Text("免费WI_FI：RF_GUEST")
                        .foregroundColor(Color("grey"))
                    Spacer()
                }
                HStack{
                    Text(wifiPassword)
                        .foregroundColor(Color("grey"))
                    
                    Text("点击复制")
                        .underline()
                        .foregroundColor(Color("white"))
                        .onTapGesture{
                            UIPasteboard.general.setValue(wifiPassword, forPasteboardType: kUTTypePlainText as String)
                        }
                    Spacer()
                    
                }
                
                CardViewTitleBar(iconText: "场地设施", titleText: "场地设施")
                
                VStack{
                    HStack{
                        Spacer()
                        ForEach(0..<4){ row in
                                
                                VStack{
                                    Image(lIntroGrid[row][0])
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("yellow"))
                                    Text(lIntroGrid[row][1])
                                        .foregroundColor(Color("white"))
                                }
                                Spacer()
                                
                        }
                    }
                    HStack{
                        Spacer()
                        ForEach(4..<8){ row in
                                
                                VStack{
                                    Image(lIntroGrid[row][0])
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color("yellow"))

                                    Text(lIntroGrid[row][1])
                                        .foregroundColor(Color("white"))
                                }
                                Spacer()
                                
                            }
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

struct LStepView: View{
    var body: some View{
        ZStack{
            VStack{
                
                
                CardViewTitleBar(iconText: "上课步骤", titleText: "健身步骤")
                
                LStepElementView(stepNum: "1", stepContent: "联系客服领取免费体验")
                
                
                LStepElementView(stepNum: "2", stepContent: "购买课包或加入会员")
                
                
                LStepElementView(stepNum: "3", stepContent: "预约正式上课时间")
                
                
                LStepElementView(stepNum: "4", stepContent: "到店入场上课")
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}

struct LStepElementView: View{
    
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

struct LWarningView: View{
    var body: some View{
        
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "注意事项", titleText: "注意事项")
                
                Text(locationWarningText)
                    .foregroundColor(Color("grey"))

            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
    }
}

struct LContactView: View{
    
    var phoneNum: String
    
    var body: some View{
        
        ZStack{
            VStack(alignment: .center, spacing: 3, content: {
                
                CardViewTitleBar(iconText: "联系我们", titleText: "联系我们")
                
                Spacer().frame(height: 5)
                    
                    HStack{
                        Text("电话：")
                        
                        Spacer()
                        Text(phoneNum)
                    }
                    .foregroundColor(Color("grey"))
                    
                    HStack{
                        Text("邮件：")
                        
                        Spacer()
                        Text("info@reformfit.ca")
                    }
                    .foregroundColor(Color("grey"))
                    
                    HStack{
                        Text("LiveChat：")
                        
                        Spacer()
                        Text("点击发起对话")
                            .foregroundColor(Color("white"))
                            .underline()
                    }
                    .foregroundColor(Color("grey"))
                
            })
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
        
        
    }
}

struct LAddress: View{
    var address: String
    
    
    var body: some View{
        
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "地图", titleText: "地址")
                
                Image("wifi")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color("yellow"))
                
                HStack{
                    Text(address)
                        .foregroundColor(Color("grey"))
                    Spacer()
                }
                
                
                HStack{
                    Spacer()
                    Text("查看地图")
                        .underline()
                        .foregroundColor(Color("white"))
                        .onTapGesture {
                            let urlO = URL(string: "http://maps.apple.com/?q=ReformFit")
                            print(urlO)
                            if(UIApplication.shared.canOpenURL(urlO!)){
                                UIApplication.shared.open(urlO!, options: [:], completionHandler: nil)
                            }
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

struct LMoreServiceView: View{
    
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

struct ServiceDetailSelectionView: View{
    
    var serviceName: String
    @Binding var rootActive: Bool
    var pos: Int
    
    
    var body: some View{
        
        
        HStack{
            Text(serviceName)
                .foregroundColor(Color("white"))
            Spacer()
            
            NavigationLink(destination: ClassMain2(index: pos, offset: -UIScreen.main.bounds.width * CGFloat(pos - 1), rootActive: $rootActive)){
                
                    Text("查看")
                        .foregroundColor(Color("black"))
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background(Color("yellow"))
                        .cornerRadius(3)
                    
            }
            
        }
        
        
    }
    
}




struct CardViewTitleBar: View{
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

struct LocationInfo_Previews: PreviewProvider {
    
    @State static var rootActive: Bool = false
    static var previews: some View {
        LocationInfo(rootActive: $rootActive)
    }
}



var lIntroGrid: [[String]] = [["更衣室","更衣室"],["储物柜","储物柜"], ["淋浴间","淋浴间"], ["体测仪", "体测仪"], ["心率环", "心率环"], ["wifi", "Wi-Fi"],["卫生间", "卫生间"], ["休息区", "休息区"]]

var wifiPassword: String = "9056047398"

var locationWarningText: String =  "律给商支任品老步白治观领打，革提给各自立2下南合整。 情为后种真意话情，压我队目所料百算，这详算转根明。 持验下者改易时，问专音放定候儿，计B严按该。 放这专教百本下称活龙调叫定，使科马物书也多要各备头，月京相陕白身任物列围结。 派所取何本己今时应素，部海广同拉单场回四，细维N青压U低习。 物很也维列快号机他听所已分至，位况需将进极式利识伯但"


var lMoreServiceGrid: [[String]] = [["燃脂团课","燃脂团课"],["塑形团课","塑形团课"], ["精品私教","精品私教"], ["线上健身","线上训练"],["健康配餐","健康配餐"]]



