//
//  WebView.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-02.
//

import SwiftUI
import WebKit

struct ContentViewWeb: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct WebView: UIViewRepresentable{
    
    let url : URL?
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myURL = url else{
            return
        }
        let request = URLRequest(url: myURL)
        uiView.load(request)
    }
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewWeb()
    }
}
