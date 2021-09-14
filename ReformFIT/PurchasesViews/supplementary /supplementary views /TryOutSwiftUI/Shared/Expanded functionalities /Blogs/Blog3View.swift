//
//  Blog3View.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-07.
//

import SwiftUI

struct Blog3View: View {
    var body: some View {
        ZStack {
            Color("main_background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                
                VStack(spacing:12){
                    
                    VStack(spacing:12){
                        
                        headerPart
                        description
                    }
                    
                    
                    VStack {
                        Image("Blog1Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
//                            .frame(width:100)
                        afterBurn
                    }
                    VStack {
                        Image("BMR")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
//                            .frame(width:100)
                        BMRetc
                    }
                    
                    
                    
                    
                    VStack {
                        Image("Blog1_2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        prevention
                    }
                    
                    Spacer().frame(height:10)
                }
                .padding(.horizontal,12)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }
        
    }
    var headerPart: some View{
        VStack(spacing:12){
            
            BlogTitle(content: "Strength Training and Effective Weight Loss", size: 18)

                
            
            VStack(spacing:6) {
                postedDate
                mainImage
            }
            
            
            
        }
    }
    var postedDate: some View{
        HStack {
            Text("Posted on March 9, 2021")
                .font(.system(size: 6))
                .foregroundColor(Color("rare_gray"))
            Spacer()
        }
    }
    var mainImage: some View{
        Image("Blog3Image")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var description:some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "WHAT IS IT?", size: 14)
            
            // content
            Text("Over the years, most people believed that doing intensive cardio is the only effective way for weight loss. However, new science has shown that effective healthy weight loss requires burning fat while gaining muscle mass and weight training is the way to achieve this. Well, you may say:")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            +
                Text("“I seem to burn more calories in a cardio workout versus a weight training workout.”")
                    .foregroundColor(Color("white"))
                    .font(.system(size: 12))
            +
                Text("Yes, you’re right! If you were to compare a 30-minute high intensity cardio to a 30-minute weight training session, you would most likely burn more calories for the same amount of time and effort. However, weight training provides more of the long-term benefits to weight loss rather than just the workout itself. For instance you are often times burning more calories after the workout from weight training than cardio. \n\nBelow are a few important benefits of weight training for weight loss.")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
            
            
        }
    }
    
    var afterBurn: some View{
        VStack(alignment: .leading, spacing:6 ){
            BlogTitle(content: "AFTERBURN", size: 14)
            VStack(alignment:.leading, spacing:0){
           
                ABsub1
                +
               ABsub2
                +
                ABsub3
            + ABsub4
                
               
                
                        
            }
        }
    }
    var ABsub1: Text{
        Text("A few posts back, we talked about what the ")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
        +
            Text("Afterburn Effect ")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
        +
            Text("is (Click ")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
    }
    var ABsub2: Text{
        Text("here ")
            .foregroundColor(Color("yellow"))
            .font(.system(size: 12))
            .underline()
        +
            Text("to read) and how when your ")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
        +
            Text("EPOC, Excess Post Exercise Oxygen Consumption ")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
    }
    var ABsub3: Text{
        Text("increases, it creates the Afterburn Effect resulting in an increased metabolic rate for up to 24 hours after your strength training workout, hence burning more calories! So, hitting the weight section at the gym can not only help you burn calories from the workout but you are greatly benefiting from the Afterburn Effect so essentially you are burning more calories and fat effectively to support your weight loss journey in the long run.")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
        
    }
    var ABsub4: Text{
        
            Text("\n\nIf you haven’t already,")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
        +
            Text("sign up")
                .foregroundColor(Color("yellow"))
                .font(.system(size: 12))
                .underline()
        +
            Text(" for a ")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
        +
            Text("ReformFIT ")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
                .bold()
        +
            Text("Bootcamp Class today where we combine strength, cardio and HIIT into one workout so that you can gain all the benefits possible from exercising.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
        
    }
    
    var BMRetc: some View{
        VStack(alignment: .leading, spacing:6 ){
            BlogTitle(content: "INCREASE LEAN MUSCLE MASS, BASAL METABOLIC RATE & LONG TERM FAT LOSS", size: 14)
            VStack(alignment:.leading, spacing:0){
           
              BMRsub1
                +
               
                BMRsub2
                
               
                
                        
            }
        }
    }
    var BMRsub1: Text{
        Text("When consistently incorporating weight training into your exercise routine, it has shown that your lean muscle mass increases.")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
        +
            Text(" As we age, our lean muscle mass decreases and if we don’t do anything about it, we start to lose muscle and it will be replaced by fat.")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
        +
            Text(" So without much diet changes, if you were to strength train consistently, it will be beneficial in weight loss and maintaining the body shape you want by building more muscle and preventing fat gain.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
    }
    var BMRsub2: Text{
        Text("\n\nAnother great benefit related to increased muscle mass is that ")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
        +
            Text("the more lean muscle mass you have, the greater your basal metabolic rate.")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
        +
            Text("Your basal metabolic rate is the amount of calories your body burns naturally without moving your body. So if you weight train consistently, you will be burning more calories on your rest day, then the average person who does not weight train.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
    }
    
    var prevention: some View{
        VStack(alignment: .leading, spacing:6 ){
            BlogTitle(content: "PREVENT OSTEOPOROSIS OR BONE CONDITIONS", size: 14)
            VStack(alignment:.leading, spacing:0){
                Text("Strength training not only builds your muscles but it also helps build stronger and denser bones! It has some incredible benefits on bone health by increasing bone density, improving joint flexibility, and also reduces risk of fractures.\n\n")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
              
                +
               
                    Text("Join")
                        .foregroundColor(Color("yellow"))
                        .font(.system(size: 12))
                        .underline()
                +
                    Text(" one of our workout classes today at ReformFIT lead by our experienced trainers to help you consistently strength train in a way and effective way.")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                
               
                
                        
            }
        }
    }
    
}

struct Blog3View_Previews: PreviewProvider {
    static var previews: some View {
        Blog3View()
    }
}
