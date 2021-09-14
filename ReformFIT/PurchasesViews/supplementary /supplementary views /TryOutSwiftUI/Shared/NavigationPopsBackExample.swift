//
//  NavigationPopsBackExample.swift
//  TryOutSwiftUI
//
//  Created by Chen Chen on 2021-08-04.
//

import SwiftUI

public struct FirstScreen: View {
  public init() {}
  public var body: some View {
    NavigationView {
      List {
        row
        row
        row
      }
    }
  }
  private var row: some View {
    NavigationLink(destination: SecondScreen()) {
      Text("Row")
    }
  }
}
struct SecondScreen: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  public var body: some View {
    VStack(spacing: 10) {
      NavigationLink(destination: thirdScreenA) {
        Text("Link to Third Screen A")
      }
      NavigationLink(destination: thirdScreenB) {
        Text("Link to Third Screen B")
      }
      Button("Go back", action: { presentationMode.wrappedValue.dismiss() })
    }
  }
  var thirdScreenA: some View {
    Text("thirdScreenA")
  }
  var thirdScreenB: some View {
    Text("thirdScreenB")
  }
}
struct FirstScreen_Previews: PreviewProvider {
  static var previews: some View {
    FirstScreen()
  }


}
