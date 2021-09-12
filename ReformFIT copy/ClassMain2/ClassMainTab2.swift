//
//  ClassMainTab2.swift
//  ReformFIT
//
//  Created by J on 2021-08-11.
//

import SwiftUI

struct ClassMainTab2: View {
    var body: some View {
        VStack{
            
            privateCardView()
            
            Spacer()
        }
    }
}


struct privateCardView: View{
    
    @State var expanded: Bool = false
    var body: some View{
        
        
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Color("black3")
                        .frame(width: UIScreen.main.bounds.width * 0.76, height: CGFloat(expanded ? 270 : 230))
                    
                }
            }
            
            HStack{
                VStack{
                    Image("wifi")
                        .resizable()
                        .frame(width: 100, height: CGFloat(expanded ? 270 : 230))
                        .foregroundColor(Color("yellow"))
                        
                       
                    Spacer()
                }
                
                VStack{
                    Spacer().frame(height: 60)
                        
                    HStack{
                        Text("Cindy Sun")
                            .bold()
                            .foregroundColor(Color("white"))
                        Spacer()
                    }
                    Spacer().frame(height: 8)
                    
                    Text(introString)
                        .foregroundColor(Color("grey"))
                        .lineLimit(expanded ? 150 : 3)
                        .onTapGesture {
                            expanded.toggle()
                        }
                    
                    Image("向下箭头")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .onTapGesture {
                            expanded.toggle()
                        }
                        
                    
                    HStack{
                        Spacer()
                        
                        NavigationLink(destination: PrivateTrainerInfo()){
                                Text("查看")
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .foregroundColor(Color("black"))
                                    .background(Color("yellow"))
                                    .cornerRadius(10)
                            
                            }
                        Spacer().frame(width: 5)
                        
                    }
                        
                    Spacer()
                        
                }
                
                
                Spacer()
            }
            
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.88, height: CGFloat(expanded ? 320 : 280))
    }
}

struct ClassMainTab2_Previews: PreviewProvider {
    static var previews: some View {
        ClassMainTab2()
    }
}

var introString: String = "律给商支任品老步白治观领打，革提给各自立2下南合整。 情为后种真意话情，压我队目所料百算，这详算转根明。 持验下者改易时，问专音放定候儿，计B严按该。"
