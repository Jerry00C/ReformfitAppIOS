//
//  BlogPage.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-06.
//

import SwiftUI

struct BlogPage: View {
    @State var gg:Bool = false
    var body: some View {
//        NavigationView {
            ZStack{
                Color("main_background")
                VStack {
                    TopBar(rootActive: $gg, titleText: "Blog")
                    ScrollView {
                        VStack(spacing:12){
                            ZStack(alignment:.bottomLeading) {
                                Image("Blog1Image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                Text("Muscle Hypertrophy VS Muscle Endurance")
                                    .foregroundColor(Color("white"))
                                    .font(.system(size: 16))
                                    .padding(.leading)
                                    .padding(.bottom,6)
                            }
                            NavigationLink(
                                destination: Blog1View(),
                                label: {
                                    blog1
                                })

                            NavigationLink(
                                destination: Blog2View(),
                                label: {
                                    blog2
                                })
                            NavigationLink(
                                destination: Blog3View(),
                                label: {
                                    blog3
                                })
                            NavigationLink(
                                destination: Blog4View(),
                                label: {
                                    blog4
                                })
                            NavigationLink(
                                destination: Blog5View(),
                                label: {
                                    blog5
                                })
                            NavigationLink(
                                destination: Blog6View(),
                                label: {
                                    blog6
                                })
                            NavigationLink(
                                destination: Blog7View(),
                                label: {
                                    blog7
                                })
    //
                            
                            
                            Spacer()
                            
                        }
                    }
                }
            }
//            .edgesIgnoringSafeArea(.bottom)
            .animation(.default)
            .background(Color("black"))
            .navigationTitle("")
            .navigationBarHidden(true)
            .statusBar(hidden: false)
            .navigationBarBackButtonHidden(true)
            
//        }
    }
    
    var blog1: some View{
        BlogOverview(title: "Muscle Hypertrophy vs Muscle Endurance", imageName: "Blog1Image", description: "In the fitness and weight-training world, people are often wondering how many reps of each exercise they should be doing or how heavy they should be lifting in order to")
    }
    var blog2: some View{
        BlogOverview(title: "Knee Hyperextension: What It is and How To Improve It", imageName: "Blog2Image", description: "WHAT IS IT? Knee Hyperextension happens when the knee joint is excessively straightened, resulting in high stress on the entire knee from the structure to the back of the knee")
    }
    var blog3: some View{
        BlogOverview(title: "Strength Training and Effective Weight Loss", imageName: "Blog3Image", description: "Over the years, most people believed that doing intensive cardio is the only effective way for weight loss. However, new science has shown that")
    }
    var blog4: some View{
        BlogOverview(title: "What is Pelvic Tilt? Learn How to Improve It", imageName: "Blog4Image", description: "PELVIC TILT The pelvic is the lower part of your torso where your mid section connects to your legs. It is an essential body part that helps with day-to-day function")
    }
    var blog5: some View{
        BlogOverview(title: "Squats Vs. Deadlifts – Let’s Talk the Difference", imageName: "Blog5Image", description: "Squats and Deadlifts are both highly effective ways of strength training your lower body muscles. Both exercises are intended to strengthen muscle groups within your legs and glutes, however, depending")
    }

    var blog6: some View{
        BlogOverview(title: "Make the Switch to HIIT, High Intensity Interval Training", imageName: "Blog6Image", description: "Over the years, HIIT has gained a lot of popularity and it’s mainly due to the many benefits it has! HIIT workouts involve short periods (30-60seconds) of intense exercise followed ")
    }
    var blog7: some View{
        BlogOverview(title: "Finding Balance During COVID: Food, Lifestyle and Exercise", imageName: "Blog7Image", description: "Now that we are entering Wave 2 of COVID-19, it is crucial to re-learn how to find balance in our day-to-day life. Many of you can relate to how much")
    }
}






struct BlogOverview:View{
    let title:String
    let imageName:String
    let description:String
    var body:some View{
        ZStack(alignment:.top){
            CardBackground()
            VStack(alignment:.leading){
                titleView
                overview
            }
            .padding()
            
        }
        .padding(.horizontal)
    }
    var titleView: some View{
        Text(title)
            .foregroundColor(Color("yellow"))
            .font(.system(size:16))
    }
    var overview: some View{
        HStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100)
            
            Text(description)
                .font(.system(size:12))
                .foregroundColor(Color("rare_gray"))
        }
    }
}



struct BlogPage_Previews: PreviewProvider {
    static var previews: some View {
        BlogPage()
    }
}
