//
//  VideoCategoryModel.swift
//  ReformFIT
//
//  Created by Chen Chen on 2021-09-19.
//

import Foundation


struct VideoCategoryModel:Identifiable{
    var id: UUID
    
    var categoryName:String
    var description:String
    var listOfVideos:[VideoResourceModel]
    var listOfVideoCaptureImages:[String] {
        var videoStrings:[String] = []
        for video in listOfVideos{
            videoStrings.append(video.videoCaptureImage)
        }
        return videoStrings
    }
    var keyword:[String]
    
}

struct VideoResourceModel:Identifiable{
    var id:UUID = UUID()
    var videoURL:URL
    var videoCaptureImage:String
    var videoTitle:String
    var length:String
    var type: String
    
    init(url:String,imageString:String,videoTitle:String,videoLength:Int,type:String) {
        self.videoURL = URL(string: "url")!
        self.videoCaptureImage = imageString
        self.videoTitle = videoTitle
        self.length = "\(videoLength) Minutes"
        self.type = type
        
    }
    
}



struct VideoData{
    
    static var videoCategories:[VideoCategoryModel]{
        [
            VideoCategoryModel(
                id: UUID(),
                categoryName: "终极核心",
                description: "终极核心训练每节课60分钟，包括热身，训练及拉伸。主要训练核心部分力量及稳定性，让我们一起感受吧！",
                listOfVideos: VideoData.bodyCoreVideoData,
                keyword: ["核心","手臂"]),
            VideoCategoryModel(
                id: UUID(),
                categoryName: "终极核心",
                description: "终极核心训练每节课60分钟，包括热身，训练及拉伸。主要训练核心部分力量及稳定性，让我们一起感受吧！",
                listOfVideos: VideoData.bodyCoreVideoData,
                keyword: ["核心","手臂"]),
            VideoCategoryModel(
                id: UUID(),
                categoryName: "终极核心",
                description: "终极核心训练每节课60分钟，包括热身，训练及拉伸。主要训练核心部分力量及稳定性，让我们一起感受吧！",
                listOfVideos: VideoData.bodyCoreVideoData,
                keyword: ["核心","手臂"]),
            VideoCategoryModel(
                id: UUID(),
                categoryName: "终极核心",
                description: "终极核心训练每节课60分钟，包括热身，训练及拉伸。主要训练核心部分力量及稳定性，让我们一起感受吧！",
                listOfVideos: VideoData.bodyCoreVideoData,
                keyword: ["核心","手臂"]),
            
            
        ]
    }
    static var bodyCoreVideoData:[VideoResourceModel]{
        [
            VideoResourceModel(
                url: "",
                imageString: "CoreTraining",
                videoTitle: "Upper-body COnditioning",
                videoLength: 60,
                type: "Bodyweight"),
            VideoResourceModel(
                url: "",
                imageString: "CoreTraining",
                videoTitle: "Upper-body COnditioning",
                videoLength: 60,
                type: "Bodyweight"),
            VideoResourceModel(
                url: "",
                imageString: "CoreTraining",
                videoTitle: "Upper-body COnditioning",
                videoLength: 60,
                type: "Bodyweight"),
            VideoResourceModel(
                url: "",
                imageString: "CoreTraining",
                videoTitle: "Upper-body COnditioning",
                videoLength: 60,
                type: "Bodyweight")
        ]
    }
}
