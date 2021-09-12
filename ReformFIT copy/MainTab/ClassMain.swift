//
//  ClassMain.swift
//  ReformFIT
//
//  Created by J on 2021-07-26.
//

import SwiftUI

struct ClassMain: View {
    
    @State var dataLoaded: Bool = false
    var body: some View {
        ZStack{
            Color("black")
            VStack{
                Text("Class Main")
                    .foregroundColor(Color("white"))
            
                
                ClassExView(dataLoaded: $dataLoaded)
                
                
            }
            
        }
    }
}

struct ClassExView: View{
    @Binding var dataLoaded: Bool
    
    var body: some View{
        
        Text("Class Detail")
            .onTapGesture {
                fetchData()
            }
            
        
    }
    
}

extension ClassExView{
    
    
    func fetchData() -> Void {
        
        
        dataLoaded = true
    }
}

struct ClassMain_Previews: PreviewProvider {
    
    static var previews: some View {
        ClassMain()
    }
}
