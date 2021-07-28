//
//  MineMain.swift
//  ReformFIT
//
//  Created by J on 2021-07-27.
//

import SwiftUI


struct MineMain: View {
    
    
    var body: some View {
        
        ZStack{
            
            Color("white")
            
            VStack{
                
                Text("Mine Main")
                    .foregroundColor(Color("black"))
            
        
            }
        }
        
    }
}

struct MineMain_Previews: PreviewProvider{
    
    
    @State static var fab: Bool = false
    
    static var previews: some View {
        MineMain()
    }
}
