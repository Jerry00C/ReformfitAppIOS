//
//  Blog2View.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-07.
//

import SwiftUI

struct Blog2View: View {
    var body: some View {
        ZStack {
            Color("main_background")
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                
                VStack(spacing:12){
                    
                    VStack(spacing:12){
                        headerPart
                        
                        whatIsIt
                        causes
                    }
                    
                    
                    VStack {
                        symptoms
                        Image("Blog2_1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
//                            .frame(width:100)
                    }
                    VStack(spacing:12){
                        howToImprove
                        
                    }
                    
                    RI
                    CE
                    Image("Blog2_2")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    longTermPrevention
                    tryItOut
                    Spacer().frame(height:10)
                }
                .padding(.horizontal,12)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }
    }
    
    //header part
    var headerPart: some View{
        VStack(spacing:12){
            
            BlogTitle(content: "Knee Hyperextension: What It is and How To Improve It", size: 18)

                
            
            VStack(spacing:6) {
                postedDate
                mainImage
            }
            
            
            
        }
    }
    var postedDate: some View{
        HStack {
            Text("Posted on April 5, 2021")
                .font(.system(size: 6))
                .foregroundColor(Color("rare_gray"))
            Spacer()
        }
    }
    var mainImage: some View{
        Image("Blog2Image")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    }
    
    // what is it
    
    var whatIsIt: some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "WHAT IS IT?", size: 14)
            
            // content
            Text("Knee Hyperextension happens when the knee joint is")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            +
                Text(" excessively straightened, resulting in high stress on the entire knee from the structure to the back of the knee joint.")
                    .foregroundColor(Color("white"))
                    .font(.system(size: 12))
            +
                Text(" This occurs when the knee joint is bent the wrong way and too far backwards. This often occurs in individuals who perform high impact exercises or are athletes. ")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
            
            
        }
    }
    
    var causes: some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "CAUSES", size: 14)
            
            // content
            causes_content
            
            
            
        }
    }
    
    var causes_content: some View{
        Text("The cause of knee hyperextensions often occurs from high impact exercises that require")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
        +
            Text(" jumping and landing hard or abrupt stop")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
        +
            Text(" in running as well as contact sports.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
        +
            Text(" Improper form during exercising")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
        +
            Text(" and")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
        +
            Text(" awkward placement of your knees")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
        +
            Text(" can also increase risk of Knee Hyperextension.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
    }
    
    var symptoms: some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "SYMPTOMS", size: 14)
            
            // content
            Text("Some of the common symptoms of an Extended Knee include")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            +
                Text(" localized knee pain, swelling, bruising, knee instability, limited knee movement and popping sound from knee joint.")
                    .foregroundColor(Color("white"))
                    .font(.system(size: 12))
            +
                Text(" \n\nKnee hyperextension can range from a mild strain to a severe injury to the knee structure. It is important to provide immediate attention to prevent long-term injuries.")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
            
            
            
        }
    }
    
    var howToImprove: some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "HOW TO IMPROVE IT", size: 14)
            
            // content
            Text("If you are experiencing a Hyperextended Knee, you can follow the acronym, RICE that can provide you with some immediate relief.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            
            
            
            
        }
    }
    
    var RI: some View{
        VStack(alignment:.leading,spacing:12){
            Text("R - Rest")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
                .italic()
            Text("Take a break from high intensity/impact training activities and allow the body to rest and recover. Ensure that swelling and pain subsides before resuming. You may perform gentle, low impact activities to keep the body moving during your recovery period.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            Text("I - Ice")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
                .italic()
            Text("Ice the affected knee for 15 minutes multiple times throughout the day. Ice can reduce inflammation by bringing down the swelling and help manage pain. Use a towel to cover ice to prevent direct skin contact, which can cause irritation and discomfort.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            
            
        }
    }
    
    var CE: some View{
        VStack(alignment:.leading,spacing:12){
            Text("C – Compress")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
                .italic()
            Text("Provide compression to the affected knee to improve blood circulation that can help bring down swelling and pain further.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            Text("E – Elevate")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
                .italic()
            Text("Elevate your leg above heart level whenever possible. When sleeping, plop a pillow under your legs to allow elevation. ")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            
            
        }
    }
    
    var longTermPrevention: some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "SYMPTOMS", size: 14)
            
            // content
            Text("To prevent Knee Hyperextension, it is important to be mindful of knee posture when performing everyday activities and exercises. ")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            
            VStack{
                    Text("  \u{2022} Performing strengthening exercises regularly to improve knee flexors and extensors. ")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                +
                    Text("\n  \u{2022} Improving quads and hamstring muscles can also protect the knee joints.")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                +
                    Text("\n  \u{2022} Strengthening your core muscles could also provide more stability and prevention of knee misplacement.")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                +
                    Text("\n  \u{2022} Ensuring that you have an adequate warm up routine before high impact exercises and a good cool down afterwards.")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
            
            }
            .padding(.leading)
            
        }
    }
    
    var tryItOut: some View{
        VStack(alignment: .leading, spacing: 6){
            BlogTitle(content: "TRY IT OUT", size: 14)
            Text("Join one of our")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            +
                Text(" workout classes today at ReformFIT that are lead by our experienced trainers")
                    .foregroundColor(Color("white"))
                    .font(.system(size: 12))
            +
                Text(" to help you prevent and avoid Knee Hyperextension as we always provide proper form correction and clear directions.")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
        }
    }
}

struct Blog2View_Previews: PreviewProvider {
    static var previews: some View {
        Blog2View()
    }
}
