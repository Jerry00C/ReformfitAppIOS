//
//  VideoPageOverview.swift
//  ReformFIT
//
//  Created by Chen Chen on 2021-09-19.
//

import SwiftUI

struct VideoPageOverview: View {
    @State var showVideos:Bool = false
    @State var dismiss:Bool = false
    @State var videosResource: [VideoResourceModel] = []
    @State var videoCategoryTitle:String = ""

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing:12) {
                    ForEach(VideoData.videoCategories){
                        data in
                        
                        
                        VideoCategory(title: data.categoryName, description: data.description, keywords: data.keyword, videoModel: data.listOfVideos, showVideos: $showVideos,categoryTitle: $videoCategoryTitle,videosResource: $videosResource)
                    }
                }
            }
            .background(Color("main_background").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            bottomVideoSheet
        }
        
    }
    var bottomVideoSheet: some View{
        BottomSheetView(
            cardShown: $showVideos,
            cardDismissal: $dismiss,
            offset: UIScreen.main.bounds.height,
            whenExpanded: 40){
            VideoListDisplay(categoryTitle: $videoCategoryTitle, shownVideos: $showVideos, videosResource: $videosResource)
        }
    }
}

struct VideoListDisplay: View{
    @Binding var categoryTitle:String
    @Binding var shownVideos:Bool
    @Binding var videosResource:[VideoResourceModel]
    var body: some View{
        ZStack{
            Color("main_background")
            VStack{
                ZStack {
                    RoundedCorners(color: Color("gray"),tl: 20,tr: 20,bl: 0,br: 0)
                        .frame(maxWidth:.infinity,maxHeight: UIScreen.main.bounds.height/15)
                    Text(categoryTitle)
                        .foregroundColor(Color("white"))
                    HStack{
                        Spacer()
                        closeWindow
                    }
                    .padding(.horizontal)
                    
                }
                ScrollView{
                    VStack{
                        ForEach(videosResource){
                            video in
                            VideoPreview(
                                title: video.videoTitle,
                                length: video.length,
                                type: video.type,
                                image: video.videoCaptureImage)
                        }
                        
                    }
                }
                Spacer()
            }
        }
        
    }
    var closeWindow: some View{
        Image(systemName: "xmark.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 12, height: 12)
            .foregroundColor(Color("white"))
            .onTapGesture {
                withAnimation(){
                    shownVideos = false
                }
            }
    }
}

struct VideoPreview:View{
    
    var title:String
    var length:String
    var type:String
    var image:String
    var body: some View{
        ZStack{
            CardBackground(cornerRadius: 5)
            HStack{
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:90)
                description
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    var description: some View{
        VStack(alignment:.leading){
            Text(title)
                .foregroundColor(Color("white"))
                .bold()
                .font(.system(size: 16))
            Text(length + " - "+type)
                .foregroundColor(Color("white"))
                .font(.system(size: 16))
            
            
        }
    }
}

struct VideoPageOverview_Previews: PreviewProvider {
    static var previews: some View {
        VideoPageOverview()
    }
}


struct VideoCategory: View{
    
    var title:String
    var description:String
    var keywords:[String]
    var videoModel:[VideoResourceModel]
    @Binding var showVideos:Bool
    @Binding var categoryTitle:String
    @Binding var videosResource:[VideoResourceModel]
    var body: some View{
        ZStack{
            CardBackground(cornerRadius: 5)
            VStack{
                HStack{
                    VideosInfoTitle(title: title, imageString: "list.bullet")
                    Spacer()
                    checkAll
                }
                Text(description)
                    .foregroundColor(Color("gray"))
                    .fixedSize(horizontal: false, vertical: true)
                ScrollView(.horizontal){
                    HStack(spacing:12){
                        ForEach(videoModel){
                            video in
                            Image(video.videoCaptureImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height:90)
                        }
                    }
                }
                HStack{
                    ForEach(keywords,id:\.self){
                        word in
                        KeywordView(word: word)
                    }
                    Spacer()
                }
                .padding(.top,12)
            }
            .padding()
        }
        .padding(.horizontal)
    }
    
    var checkAll: some View{
        Text("查看全部")
            .underline()
            .foregroundColor(Color("white"))
            .font(.system(size: 14))
            .onTapGesture {
                withAnimation{
                    showVideos = true
                    categoryTitle = title
                    videosResource = videoModel
                }
            }
    }
    
    
}

struct VideosInfoTitle: View{
    
    var title :String
    var imageString : String
    
    var body: some View{
        
        HStack(alignment: .center) {
            Image(systemName: imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                
            Text(title)
                .font(.system(size: 20))
            
        }
        .foregroundColor(Color("yellow"))
    }
    
    
    
}

struct KeywordView:View{
    let word:String
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .strokeBorder()
                
            Text(word)
                .padding(5)
                
            
        }
        .fixedSize()
        .foregroundColor(Color("yellow"))
    }
}
