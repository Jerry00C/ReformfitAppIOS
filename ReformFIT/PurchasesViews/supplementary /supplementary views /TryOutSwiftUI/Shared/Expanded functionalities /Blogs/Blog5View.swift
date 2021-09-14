//
//  Blog5View.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-08.
//

import SwiftUI

struct Blog5View: View {
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
                    
                    
                    Spacer().frame(height:12)
                    muscleGroupTargeted
                        
                    Spacer().frame(height:12)
                    deadlift
                    
                    Spacer().frame(height:12)
                    squats
                    
                    Spacer().frame(height:12)
                    VStack(spacing:6){
                    choice
                    tryItOut
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
            
            BlogTitle(content: "Squats Vs. Deadlifts – Let’s Talk the Difference", size: 18)

                
            
            VStack(spacing:6) {
                postedDate
                mainImage
            }
            
            
            
        }
    }
    var postedDate: some View{
        HStack {
            Text("Posted on January 5, 2021")
                .font(.system(size: 6))
                .foregroundColor(Color("rare_gray"))
            Spacer()
        }
    }
    var mainImage: some View{
        Image("Blog5Image")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var description:some View{
        VStack (alignment:.leading,spacing:6){
            
            // content
            Text("Squats and Deadlifts are both highly effective ways of strength training your lower body muscles. Both exercises are intended to strengthen muscle groups within your legs and glutes, however, depending on your positioning and the types of squats or deadlifts being performed, certain muscle groups are more activated than others. Take a look at the following tables to learn more and figure out which forms and exercises are best for you!")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
           
            
            
        }
    }
    
    var muscleGroupTargeted:some View{
        VStack(spacing:12){
            Text("Main Muscle Group Targeted")
                .font(.system(size: 14))
                .foregroundColor(Color("white"))
            
            muscleGroupTable
        }
    }
    
    var muscleGroupTable: some View{
        HStack{
            VStack(spacing:0){
                TableItem(text: "DEADLIFTS",
                          textColor: Color("main_background"),
                          backgroundColor: Color("yellow"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.1,
                          bold: true
                            )
                TableItem(text: "Glutes",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Hips",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Core",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Hamstrings",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Back",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Trapezius",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                
            }
            
            VStack(spacing:0){
                TableItem(text: "SQUATS", textColor: Color("white"),backgroundColor: Color("rare_gray"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("rare_gray"),
                          borderWidth: 1,
                          bold: true)
                TableItem(text: "Glutes",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white")  ,
                          borderWidth: 0.5
                )
                TableItem(text: "Hips",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Core",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Hamstrings",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Quadriceps",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                TableItem(text: "Calves",
                          textColor: Color("white"),
                          font: .system(size: 12),
                          alignment: .leading,
                          borderColor: Color("white"),
                          borderWidth: 0.5
                            )
                
            }
        }
                .overlay(Rectangle().strokeBorder().foregroundColor(Color("main_background")))
    }
    var deadlift:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "DEADLIFTS", size: 14)
                BlogTextContent(content: "Adding deadlifts into your exercise routine not only strengthen your legs and glutes but also activate your back, core and other upper body parts. When compared to a squat, the deadlift is more technical and require more form correction to prevent injuries and ensure the right muscle groups are being used. Depending on which muscle groups you’d like to work on, there are different variations of deadlifts that can greater target certain muscle groups as displayed in the chart below.", size: 12)
                
            }
            .fixedSize(horizontal: false, vertical: true)
            Spacer().frame(height:12)
            deadliftTable
            
        }
    }
    
    var deadliftTable: some View{
        ScrollView(.horizontal) {
            HStack{
                VStack(spacing:0){
                    TableItem(text: "MUSCLE GROUPS",
                              textColor: Color("main_background"),
                              backgroundColor: Color("yellow"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.1,
                              bold: true
                                )
                    TableItem(text: "Lower Back",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Hamstrings",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Quads",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Glutes",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Traps",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Lats",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Forearm",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Core",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Coordination and balance",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                }
                .fixedSize()
                VStack(spacing:0){
                    TableItem(text: "Conventional Deadlift", textColor: Color("white"),backgroundColor: Color("rare_gray"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("rare_gray"),
                              borderWidth: 1,
                              bold: true)
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white")  ,
                              borderWidth: 0.5
                    )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                }
                .fixedSize()

                VStack(spacing:0){
                    TableItem(text: "Sumo Deadlift",textColor: Color("main_background"),
                              backgroundColor: Color("yellow"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.1,
                              bold: true)
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white")  ,
                              borderWidth: 0.5
                    )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                }
                .fixedSize()

                VStack(spacing:0){
                    TableItem(text: "Romanian Deadlift", textColor: Color("white"),backgroundColor: Color("rare_gray"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("rare_gray"),
                              borderWidth: 1,
                              bold: true)
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white")  ,
                              borderWidth: 0.5
                    )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                }
                .fixedSize()

                VStack(spacing:0){
                    TableItem(text: "Single Leg Deadlift", textColor: Color("main_background"),
                              backgroundColor: Color("yellow"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.1,
                              bold: true)
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white")  ,
                              borderWidth: 0.5
                    )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                }
                .fixedSize()

            }
            .overlay(Rectangle().strokeBorder().foregroundColor(Color("main_background")))
        }
    }
    
    var squats:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "SQUATS", size: 14)
                BlogTextContent(content: "Squats are always been the go-to exercise for building stronger legs as it is effective, beginner to expert friendly, and has many variations. Squats can be done with weights or just body weight. Today, we will just talk about the few most popular forms of squats and provide you with the difference between them in terms of targeting certain muscle groups and the difference between hip and quad dominant.", size: 12)
                
            }
            Spacer().frame(height:12)
            squatsTable
            
        }
    }
    
    var squatsTable: some View{
        ScrollView(.horizontal) {
            HStack{
                VStack(spacing:0){
                    TableItem(text: "MUSCLE GROUPS",
                              textColor: Color("main_background"),
                              backgroundColor: Color("yellow"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.1,
                              bold: true
                                )
                    TableItem(text: "Glutes",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                    TableItem(text: "Quads",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                    TableItem(text: "Hips",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "Calves",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                                
                    TableItem(text: "Core",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                   
                    
                }
                .fixedSize()
                VStack(spacing:0){
                    TableItem(text: "Basic Squat (Shoulder width)", textColor: Color("white"),backgroundColor: Color("rare_gray"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("rare_gray"),
                              borderWidth: 1,
                              bold: true)
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white")  ,
                              borderWidth: 0.5
                    )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                    
                }
                .fixedSize()

                VStack(spacing:0){
                    TableItem(text: "Sumo Squat (Wide stance)",textColor: Color("main_background"),
                              backgroundColor: Color("yellow"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.1,
                              bold: true)
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white")  ,
                              borderWidth: 0.5
                    )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    
                    
                }
                .fixedSize()

                VStack(spacing:0){
                    TableItem(text: "Jump Squat", textColor: Color("white"),backgroundColor: Color("rare_gray"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("rare_gray"),
                              borderWidth: 1,
                              bold: true)
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white")  ,
                              borderWidth: 0.5
                    )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                    TableItem(text: "✓✓✓",
                              textColor: Color("white"),
                              font: .system(size: 10),
                              alignment: .leading,
                              borderColor: Color("white"),
                              borderWidth: 0.5
                                )
                   
                    
                }
                .fixedSize()

                

            }
            .overlay(Rectangle().strokeBorder().foregroundColor(Color("main_background")))
        }
    }
    
    var choice:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "Quad or Hip Dominant Squats?", size: 14)
                BlogTextContent(content: "There are two types of popular squat, Quad or Hip dominant squats. When doing a Quad dominant squat, your torso is more upright and your glutes are angled straight to the ground and more pressure is on the quads. When doing a Hip dominant squat, your torso is more forward and you’re sitting your glutes more behind the body and pushing your hips back. Try the 2 variations yourself and feel the difference in muscle engagement!", size: 12)
                
            }
            Spacer().frame(height:12)
            
            
        }
    }
    var tryItOut:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "Try it out!", size: 14)
                HStack{
                Text("Now that you know the difference between deadlifts and squats, it is time to put it into action! Join one of our workout classes today at")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
              
                +
               
                    Text(" ReformFIT")
                        .foregroundColor(Color("yellow"))
                        .font(.system(size: 12))
                        .underline()
                +
                    Text(" to experience the different forms and types taught by our knowledgeable trainers! In our Bootcamp classes, proper form correction and clear directions are given to give you the best workout and prevent injuries.")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                    Spacer()
                }
                
               
            }
            
            
        }
    }
    
    
}

struct Blog5View_Previews: PreviewProvider {
    static var previews: some View {
        Blog5View()
    }
}
