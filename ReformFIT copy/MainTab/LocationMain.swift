//
//  ContentView.swift
//  ReformFIT
//
//  Created by J on 2021-07-19.
//

import SwiftUI
import AVKit

struct LocationMain: View {
    
    @ObservedObject var locationViewModel:LocationViewModel
    @State private var rootActive = false
    
    @Binding var fab: Bool
    
    @State var scrollText = false
    
    let player : AVPlayer = AVPlayer(url: URL(string: "https://dcffvbxhml043.cloudfront.net/7d87d189-98b4-47ee-a4b4-1c3fa4df15ad/mp4/60ad9036c346e300011b78e0_Mp4_Avc_Aac_16x9_1280x720p_30Hz_4.5Mbps.mp4")!)
    
    
    var body: some View {
        
        ZStack{
            
               ScrollView{
                        
                VStack(alignment: .center, spacing: 0, content: {
                    
                    HStack{
                        SelectionView(selectionTitle: "全部城市")
                        SelectionView(selectionTitle: "全部城市")
                        Spacer()
                    }
                        .padding(.vertical, 8)
                        
                    VideoPlayer(player: player)
                        .frame(height: 250)
                        .onDisappear{
                            player.pause()
                            player.seek(to: .zero)
                        }
                        .opacity(fab ? 0 : 1)
                        
                    
                    VStack(alignment: .center, spacing: 8, content: {
                        
                        HStack{
                            Spacer().frame(width: 15)
                            
                            Image("向下箭头")
                                .resizable()
                                .frame(width:24, height:24)
                                
                            Text("疫情期间门店暂时关闭，欢迎咨询线上课程dddddddddddddddddddd")
                                .foregroundColor(Color("white"))
                                .offset(x: scrollText ? 20 : UIScreen.main.bounds.width * 0.8)
                                .animation(Animation.linear(duration: 8).repeatForever(autoreverses: false))
                                .onAppear{
                                    self.scrollText.toggle()
                                }
                            
                            Spacer()
                        
            
                        }
                            
                            
                        HStack{
                            
                            NavigationLink(destination: Service1Info(rootActive: $rootActive), isActive: self.$rootActive){
                                ServiceView(serviceIcon: Image("燃脂团课"), serviceName: "燃脂团课")
                                
                                }
                            NavigationLink(destination: LocationInfo(rootActive: $rootActive), isActive: self.$rootActive){
                                ServiceView(serviceIcon: Image("塑形团课"), serviceName: "塑形团课")
                                
                                }
                            NavigationLink(destination: LocationInfo(rootActive: $rootActive), isActive: self.$rootActive){
                                ServiceView(serviceIcon: Image("精品私教"), serviceName: "精品私教")
                                
                                }
                            NavigationLink(destination: LocationInfo(rootActive: $rootActive), isActive: self.$rootActive){
                                ServiceView(serviceIcon: Image("线上健身"), serviceName: "线上健身")
                                
                                }
                            NavigationLink(destination: LocationInfo(rootActive: $rootActive), isActive: self.$rootActive){
                                ServiceView(serviceIcon: Image("健康配餐"), serviceName: "健康配餐")
                                
                                }
                            
                            
                            
                            
                    }
                        
                    })
                    .padding(.vertical, 10)
                    .background(Color("black3"))
                    
                    Divider().frame(height: 12)
                    
                    
                    
                    NavigationLink(destination: LocationInfo(rootActive: $rootActive), isActive: self.$rootActive){
                        LocationExView(locationViewModel: locationViewModel)
                        }
                    
                })
                .background(Color("black"))
                
                Spacer()
                
                
                    
                
            }
                .background(Color("black"))
            
            
        }
        
    }
}









struct SelectionView: View{
    
    var selectionTitle: String
    
    var body: some View{
            
        Spacer()
        
        Text(selectionTitle)
            .foregroundColor(Color("white"))
            
        Image("向下箭头")
                .resizable()
                .frame(width:24, height:24)
    }
}

struct ServiceView : View{
    
    var serviceIcon : Image
    var serviceName : String
    
    
    var body: some View{
        
        HStack{
            
            VStack(alignment: .center, spacing: 2, content: {
                
                serviceIcon
                    .resizable()
                    .frame(width: 24,
                           height: 24,
                           alignment: .center)
                    .foregroundColor(Color("yellow"))
                    
                
                
                Text(serviceName)
                    .font(.callout)
                    .foregroundColor(Color("white"))
            })
        }
        
        
        
    }
}


struct LocationExView: View{
    
    var locationViewModel:LocationViewModel
    
    var body: some View{
        ZStack{
            VStack{
                Image("wifi")
                    .resizable()
                    .frame(height: 150)
                    .foregroundColor(Color("yellow"))
                
                
                HStack{
                    
                    Text("万锦Ferrier试验店")
                        .font(.subheadline)
                        .foregroundColor(Color("yellow"))
                    Spacer()
                    
                    Image("地图")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    
                }
                
                HStack{
                    Text("85 Ferrier Street Unit 3, Markhma ON L3R2Y9")
                        .scaledToFill()
                        .foregroundColor(Color("white"))
                        .font(.body)
                    
                
                    Spacer()
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.95, alignment: .center)
        .cornerRadius(10)
    
    }
    
}





struct LocationMain_Previews: PreviewProvider {
    @State static var fab: Bool = false
    static var previews: some View {
       Main()
    }
}

