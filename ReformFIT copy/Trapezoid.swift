//
//  SwiftUIView.swift
//  ReformFIT
//
//  Created by J on 2021-09-08.
//

import SwiftUI

struct Trapezoid: Shape {
    
    
    func path(in rect: CGRect) -> Path{
        
        
        
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 25, y: 0))
        path.addLine(to: CGPoint(x: 50, y: 25))
        path.addLine(to: CGPoint(x: 50, y: 50))
        
        path.closeSubpath()
        
        
        return path
    }
    
}

struct WaitlistIndicator: View{
    var text: String
    var body: some View{
        
        Text(text)
            .font(.caption)
            .frame(width: 40, height: 40)
            .offset(x: 6, y: -7)
            .foregroundColor(Color("white"))
            .rotationEffect(Angle(degrees: 45))
            .background(Trapezoid().fill(Color("grey")))
            
            
        
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct VirtualIndicator: View {
    
    
    var body: some View{
        
        
        Text("Virtual")
            .bold()
            .foregroundColor(Color("white"))
            .offset(x: -3)
            .background(Rectangle()
                            .frame(width: 80, height: 30)
                            .foregroundColor(.red)
                            .cornerRadius(20, corners: [.topRight, .bottomRight]))
            
        
            
        
        
    }
    
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}




struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WaitlistIndicator(text: "FULL")
    }
}
