//
//  ContentView.swift
//  ReformFIT
//
//  Created by J on 2021-07-19.
//

import SwiftUI
import AVKit

struct LocationMain: View {
    
    
    @State var present = false
    @Binding var fab: Bool
    let player : AVPlayer = AVPlayer(url: URL(string: "https://dcffvbxhml043.cloudfront.net/7d87d189-98b4-47ee-a4b4-1c3fa4df15ad/mp4/60ad9036c346e300011b78e0_Mp4_Avc_Aac_16x9_1280x720p_30Hz_4.5Mbps.mp4")!)
    
    
    var body: some View {
        
        
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
                    .opacity(present || fab ? 0 : 1)
                    
                
                VStack(alignment: .center, spacing: 8, content: {
                    
                    HStack{
                        Image("向下箭头")
                            .resizable()
                            .frame(width:24, height:24)
                                
                        Text("疫情期间门店暂时关闭，欢迎咨询线上课程")
                            .lineLimit(1)
                            .foregroundColor(Color("white"))
                    }
                        
                        
                    HStack{
                        
                        
                        ServiceView(serviceIcon: Image("Fat Shredder"), serviceName: "燃脂团课")
                        
                        
                        ServiceView(serviceIcon: Image("Fat Shredder"), serviceName: "燃脂团课")
                        
                        
                        
                        ServiceView(serviceIcon: Image("Fat Shredder"), serviceName: "燃脂团课")
                        
                        
                        
                        ServiceView(serviceIcon: Image("Fat Shredder"), serviceName: "燃脂团课")
                        
                        ServiceView(serviceIcon: Image("Fat Shredder"), serviceName: "燃脂团课")
                        
                        
                }
                    
                })
                .padding(.vertical, 10)
                .background(Color("black3"))
                
                Divider().frame(height: 12)
                
                NavigationLink(destination: LocationInfo(), isActive: $present){
                            LocationExView()
                    }
                
            })
            .background(Color("black"))
            
            Spacer()
            
            
                
            
        }
        .background(Color("black"))
        
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
                .frame(width:32, height:32)
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
                    
                
                
                Text(serviceName)
                    .font(.callout)
                    .foregroundColor(Color("white"))
            })
        }
        
        
        
    }
}


struct LocationExView: View{
    
    var body: some View{
        
            VStack{
                Image("wifi")
                    .resizable()
                    .frame(height: 150)
                
                
                HStack{
                    
                    Text("万锦Ferrier试验店")
                        .font(.subheadline)
                        .foregroundColor(Color("yellow"))
                    Spacer()
                    
                    Image("地图")
                        .resizable()
                        .frame(width: 32, height: 32)
                    
                    
                }
                
                HStack{
                    Text("85 Ferrier Street Unit 3, Markhma ON L3R2Y9")
                        .foregroundColor(Color("white"))
                        .font(.body)
                
                    Spacer()
                }
                
                
                
            }
            .frame(width: UIScreen.main.bounds.width*0.88)
            .padding(.horizontal, 10)
            .background(Color("black4").cornerRadius(15))
            
            
        
        
    }
    
}


struct LocationMain_Previews: PreviewProvider {
    @State static var fab: Bool = false
    static var previews: some View {
        LocationMain(fab: $fab)
    }
}

