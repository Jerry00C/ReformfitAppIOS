//
//  Blog1View.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-07.
//

import SwiftUI

struct Blog1View: View {
    var body: some View {
        ZStack {
            Color("main_background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                
                VStack(spacing:12){
                    
                    headerPart
                    muscleHypertrophy
                    image1// added the view in parent vstack will not mess up the view
//                    Spacer().frame(height:1)
                    muscleEndurance
                    image2
                    
                    comparisonTable
                    conclusion
                    Spacer().frame(height:10)
                }
                .padding(.horizontal,12)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }
        
    }
    
    // header and its components
    var headerPart: some View{
        VStack(spacing:12){
            
            title
                
            
            VStack(spacing:6) {
                postedDate
                mainImage
            }
            
            intro
            
        }
    }
    
    var title: some View{
        
        BlogTitle(content: "Muscle Hypertrophy vs Muscle Endurance", size: 18)
    }
    var postedDate: some View{
        HStack {
            Text("Posted on May 12, 2021")
                .font(.system(size: 6))
                .foregroundColor(Color("rare_gray"))
            Spacer()
        }
    }
    var mainImage: some View{
        Image("Blog1Image")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    }
    
    var intro: some View{
        
        BlogTextContent(content: "In the fitness and weight-training world, people are often wondering how many reps of each exercise they should be doing or how heavy they should be lifting in order to achieve their goal. These goals often include muscle hypertrophy or muscle endurance. Understanding the difference between the two can help you decide which is right for you. ", size: 12)
    }
    
    // muscle hyertrophy
    
    var muscleHypertrophy: some View{
        VStack(spacing:6){
            title1
            content1
//            image1   // cannot and the image here, it will mess up the view
            
        }
    }
    
    var title1 : some View{
        BlogTitle(content: "Muscle Hypertrophy", size: 16)
    }
    var content1: some View{
        BlogTextContent(content: "Muscle hypertrophy refers to an increase in your muscle mass overtime, in particular the physical size and strength of your muscles. For instance, measuring the circumference of your arms in week 1 of your training and seeing physical growth in measurement the following weeks is an indication of muscle hypertrophy. Exercises that help with muscle hypertrophy (growth) is by lifting heavier weights at least 2-3 days a week and alternating between upper-body and lower-body days. However, allowing your body recovery time in between is important because rest and recovery is essential for muscle growth. Lifting heavy weights consistently along with proper nutrition and lifestyle can help increase your overall physical body size.", size: 12)
    }
    var image1:some View{
        Image("Blog1_1")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            
    }
    
    var muscleEndurance: some View{
        VStack(spacing:6) {
            
            BlogTitle(content: "Muscle Endurance", size: 16)
            BlogTextContent(content: "Muscle endurance is the ability of a muscle or group of muscles to perform a repeated activity for an extended period of time. Therefore, the higher your muscle endurance, the greater number of repetitions you could do in a particular exercise. For instance, on week 1 you were able to perform 15 push ups straight and on week 2 you can now complete 20 push ups straight. This is an indication of your muscle endurance improving. Lacking muscle endurance can be seen when your muscles tire out easily and a reduced amount of work those muscle groups can perform. Exercises that often involve muscle endurance include but not limited to: walking, cycling, resistance training, swimming, circuit training, holding a plank etc. ", size: 12)
        }
    }
    var image2:some View{
        Image("Blog1_2")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    }
    
    var comparisonTable:some View{
        VStack(alignment:.center){
            
            Text("Hypertrophy vs Endurance Sets and Reps")
                .foregroundColor(Color("white"))
                .font(.system(size:10))
            
            tableGrid
            termDefine
            example
//            conclusion
        }
        .padding(.top,12)
    }
    
    var termDefine: some View{
        HStack{
            Text("One Rep Max:")
                .bold()
                .foregroundColor(Color("white"))
                .font(.system(size:10))
            +
            Text("The maximum amount of weight you can lift from one single repetition of a certain exercise.")
                .foregroundColor(Color("gray"))
                .font(.system(size:10))
            Spacer()
        }
    }
    var example: some View{
        HStack{
            Text("Example:")
                .bold()
                .foregroundColor(Color("white"))
                .font(.system(size:10))
            +
            Text("50% of 1 RM = RM x 0.5 will give you the weight you should be lifting at to improve muscle endurance. Complete 3 sets of 15-20 reps at 50% of your 1 Rep Max. Circuit training and HIIT workouts at ReformFIT is a great way to improve your muscle endurance.")
                .foregroundColor(Color("gray"))
                .font(.system(size:10))
            Spacer()
        }
        .padding(.top,6)
    }
    
    var conclusion: some View{
        HStack{
            Text("At ")
                .foregroundColor(Color("gray"))
                .font(.system(size:12))
            +
            Text("ReformFIT, ")
                .bold()
                .foregroundColor(Color("yellow"))
                .font(.system(size:12))
            +
            Text("we offer a variety of classes with an extensive selection of fitness equipment and weights that can help you achieve your goals of muscle hypertrophy or muscle endurance! Our experienced instructors can help you figure out what exercise is best for your fitness goals.")
                .foregroundColor(Color("gray"))
                .font(.system(size:12))
        }
        .padding(.top,6)
    }
    var tableGrid:some View{
        ScrollView(.horizontal){
            HStack(spacing:0){
                VStack(spacing:0){
                    TableItem(
                        text: "Type of Training",
                        textColor: Color("main_background"),
                        backgroundColor: Color("yellow"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "Hypertrophy",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "Endurance",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                }
                .fixedSize()
    //            .frame(width:70)
                VStack(spacing:0){
                    TableItem(
                        text: "% of 1 Rep-Max(RM)*",
                        textColor: Color("main_background"),
                        backgroundColor: Color("yellow"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "60 – 75%",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "50 – 60%",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                }
                .fixedSize()
                VStack(spacing:0){
                    TableItem(
                        text: "Sets",
                        textColor: Color("main_background"),
                        backgroundColor: Color("yellow"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "3-5",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "3",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                }
                .fixedSize()
                VStack(spacing:0){
                    TableItem(
                        text: "Reps",
                        textColor: Color("main_background"),
                        backgroundColor: Color("yellow"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "8-12",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "15-20",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                }
                .fixedSize()
                VStack(spacing:0){
                    TableItem(
                        text: "Type of Exercise",
                        textColor: Color("main_background"),
                        backgroundColor: Color("yellow"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "lternating between upper-body lifting and lower-body lifting",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                    TableItem(
                        text: "Circuit training, HIIT, full body, body weight exercises",
                        textColor: Color("white"),
                        font: .system(size: 6),
                        alignment: .leading
                    )
                }
                .fixedSize()
            }
        }
    }
    
   
}

struct Blog1View_Previews: PreviewProvider {
    static var previews: some View {
        Blog1View()
    }
}

struct BlogTitle: View{
    let content:String
    let size :CGFloat
    var body: some View{
        HStack {
            Text(content)
                .font(.system(size: size))
                .foregroundColor(Color("yellow"))
            Spacer()
        }
    }
}

struct BlogTextContent:View {
    let content:String
    let size :CGFloat
    var body: some View{
        HStack {
            Text(content)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("gray"))
                .font(.system(size: size))
//                .frame(maxWidth:.infinity)
            Spacer()
        }
    }
}
