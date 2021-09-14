//
//  collpaseTextExample.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-02.
//

import SwiftUI



public struct SimpleCollapseText: View {
    private let description: String
    
    @Binding private var isCollapsed: Bool
    @State private var isExpandeButtonShow: Bool = false
    
    public init(description: String, isCollapsed:Binding<Bool>) {
        self.description = description
        self._isCollapsed = isCollapsed
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            text
                .lineLimit(isCollapsed ? 3 : nil)
                .background(
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            truncateIfNeeded(withGeometry: geometry)
                        }
                    }
                )
//                .font(Font.system(size: 12))
            if isExpandeButtonShow {
                HStack {
                    Spacer()
                    collapseButton.padding(.top, 9)
                    Spacer()
                }
            }
            
            Spacer()
        }
//        .padding(.horizontal, 16)
    }

    // MARK: - Private

    private var text: some View {
        Text(description)
        /*+ Text("\n\t"+description)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)*/
            
//            .animation(.linear(duration: 0.5))
//            .transition(.opacity)
    }

    private func truncateIfNeeded(withGeometry geometry: GeometryProxy) {
        let total = description.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 12)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            isExpandeButtonShow = true
        }
    }

    private var collapseButton: some View {
        button(title: collapseButtonTitle()) {
            withAnimation{
                isCollapsed.toggle()
            }
        }
    }
    
    private func button(title: String, handler: @escaping () -> Void) -> some View {
        Button(action: handler) {
            Image(systemName: title)
                .foregroundColor(Color("yellow"))
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func collapseButtonTitle() -> String {
        
        isCollapsed ? "arrow.down" : "arrow.up"
    }
}

struct collpaseTextExample_Previews: PreviewProvider {
    static var previews: some View {
//        CollapseText(description: "By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .")
//        CollapseTextView{
//            Text("By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .")
//            + Text("\n\t"+"By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .")
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//        }
        EmptyView()
    }
}


public struct CollapseTextView<Content:View>: View {
    // for longer block of texts that have different colors and styles 
    private let content: Content

    @Binding private var isCollapsed: Bool
    @State private var isExpandeButtonShow: Bool = true
    
    public init(isCollapsed:Binding<Bool>,@ViewBuilder contentText: ()-> Content) {
        self._isCollapsed = isCollapsed
        self.content = contentText()
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            text
                .lineLimit(isCollapsed ? 3 : nil)
//                .background(
//                    GeometryReader { geometry in
////                        Color.clear.onAppear {
////                            truncateIfNeeded(withGeometry: geometry)
////                        }
//                    }
//                )
                
//                .font(Font.system(size: 12))
            if isExpandeButtonShow {
                HStack {
                    Spacer()
                    collapseButton.padding(.top, 9)
                    Spacer()
                }
            }
            
            Spacer()
        }
//        .padding(.horizontal, 16)
    }

    // MARK: - Private

    private var text: some View {
        content
        
    }

    

    private var collapseButton: some View {
        button(title: collapseButtonTitle()) {
            withAnimation{
                isCollapsed.toggle()
            }
        }
    }
    
    private func button(title: String, handler: @escaping () -> Void) -> some View {
        Button(action: handler) {
            Image(systemName: title)
                .foregroundColor(Color("yellow"))
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func collapseButtonTitle() -> String {
        
        isCollapsed ? "arrow.down" : "arrow.up"
    }
    

    
}
