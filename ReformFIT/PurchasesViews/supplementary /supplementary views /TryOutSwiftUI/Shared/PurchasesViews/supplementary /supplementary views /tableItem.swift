//
//  TableView.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-02.
//

import SwiftUI



struct TableItem: View{
    let text:String
    let textColor: Color
    let backgroundColor: Color?
    let font:Font?
    let alignment:HorizontalAlignment?
    let borderColor:Color?
    let borderWidth:CGFloat
    let bold:Bool
    init(text:String, textColor: Color, backgroundColor:Color? = nil,font:Font? = nil,alignment:HorizontalAlignment? = .center,borderColor:Color? = Color("gray"),borderWidth:CGFloat = 1,bold:Bool = false) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.alignment = alignment
        self.borderColor = borderColor
        self.bold = bold
        self.borderWidth = borderWidth
    }
    var body: some View{
        HStack {
            if alignment == .trailing || alignment == .center{
                Spacer()
            }
            if bold{
                Text(text)
                    .bold()
                    .foregroundColor(textColor)
                    .padding(.vertical, 6)
                    .padding(.horizontal,6)
                    .font(font)
                    .lineLimit(1)
                    
            }
            else{
                Text(text)
                    .foregroundColor(textColor)
                    .padding(.vertical, 6)
                    .padding(.horizontal,6)
                    .font(font)
                    .lineLimit(1)
            }
            if alignment == .leading || alignment == .center{
                Spacer()
            }
        }
        .background(Rectangle()
                        .strokeBorder(borderColor!,lineWidth: borderWidth)
                        .background(Rectangle().fill(backgroundColor ?? Color("white").opacity(0)))
                        )
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        BMREnergyConsumationTable()
    }
}



