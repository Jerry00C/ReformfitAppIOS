//
//  MineMain.swift
//  ReformFIT
//
//  Created by J on 2021-07-27.
//

import SwiftUI


struct MineMain: View {
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            
            Divider().frame(height: UIScreen.main.bounds.height*0.08).opacity(0.96)
            
            ZStack{
                Color(.black)
                Text("Mine Main")
                    .foregroundColor(Color("white"))
                
            }
            .padding(0)
        })
            
            
        
        
    }
}

struct MineMain_Previews: PreviewProvider{
    
    
    @State static var fab: Bool = false
    
    static var previews: some View {
        MineMain()
    }
}
