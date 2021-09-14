//
//  Blog4View.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-08.
//

import SwiftUI

struct Blog4View: View {
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
                    
                    
                    VStack(spacing:12) {
                        Image("Blog4_1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
//                            .frame(width:100)
                        thomasTest
                        
                        
                    }
                    
                    
                    VStack {
                        Spacer().frame(height:24)
                        cause
                        Spacer().frame(height:24)

                        howToImprove
                        Spacer().frame(height:24)
                        
                        Image("corrective_exercises")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:150)
                        
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
            Text("Posted on February 10, 2021")
                .font(.system(size: 6))
                .foregroundColor(Color("rare_gray"))
            Spacer()
        }
    }
    var mainImage: some View{
        Image("Blog4Image")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var description:some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "PELVIC TILT", size: 14)
            
            // content
            Text("The pelvic is the lower part of your torso where your mid section connects to your legs. It is an essential body part that helps with day-to-day function such as walking, running, and lifting things off of the ground.  Your pelvis also helps with proper posture and should be in a neutral position.\n\n\nAn anterior pelvic tilt is when your pelvis is misaligned and is rotated forward and causes your spine to curve resulting in an arched back, poor and incorrect posture, tightness in your thighs and pelvis, pains in the lower back, hips, and knees. An anterior pelvic tilt is caused by the shortening of the hip flexors and the lengthening of the hip extensors and is often known as Lower Crossed Syndrome (LCS). If left untreated, it may result long term pains and aches in your lower body muscles.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
           
            
            
        }
    }
    var thomasTest:some View{
        VStack (alignment:.leading,spacing:6){
            BlogTitle(content: "HOW TO SELF-DETERMINE USING THE THOMAS TEST", size: 14)
            
            // content
            Text("Using Thomos test, you can self-determine if you have a pelvic tilt.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
            
            VStack(spacing:3){
                enumeratedItem(number: 1, text: "Lie flat on your back on a table or an elevated flat surface where your legs can hang off of the edge.")
                enumeratedItem(number: 2, text: "Pull one of your legs in towards your chest ")
                enumeratedItem(number: 3, text: "If you have a correct and neutral pelvis, your resting leg will remain on the table with no issues, however if you have trouble keeping your resting leg flat or require adjustments to keep it flat, it may be an indication of a pelvic tilt. Your front thigh muscle will also feel tight. ")
                enumeratedItem(number: 4, text: "Repeat with the other leg.")
                
            }
           
            
            
        }
    }
    
    var cause: some View{
        HStack{
            VStack(spacing:6){
                BlogTitle(content: "CAUSES OF PELVIC TILT", size: 12)
                BlogTextContent(content: "A pelvic tilt is often caused by excessive sitting such as working a desk job that requires being sedentary for long hours or studying for long periods of time without enough exercise or stretching to relieve the tightness of muscles from sitting all day. If left untreated, it may result long term pains and aches in your lower body muscles, bad posture and a curved spine.", size: 12)
            }
            
            Image("pelvic_tilt_cause")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
    }
    
    var howToImprove: some View{
        VStack(spacing:6){
            BlogTitle(content: "HOW TO IMPROVE IT", size: 12)
            BlogTextContent(content: "There are many simple exercises that can be done at home to help improve a pelvic tilt and reverse it back to a neutral position. ", size: 12)
            improvementContent
        }
    }
    
    var improvementContent: some View{
        VStack(spacing:3){
            enumeratedItem(number: 1, text: "Half Kneeling Hip Flexor Stretch")
            VStack{
                enumeratedItem(number: 1, text: "Simply kneel on a soft surface such as a yoga mat where your knee touches the ground and have your forward leg planted in front into a lunge position with front leg in a 90-degree angle.")
                enumeratedItem(number: 2, text: "Having your hands on your hips, tilt and force your pelvis forward while squeezing your glutes and abs. Hold for 30 seconds and repeat 3 times on each side. ")
            }
            .padding(.leading)
            enumeratedItem(number: 2, text: "Glute Bridge")
            VStack{
                enumeratedItem(number: 1, text: "Lie on your back with your back planted flat on the ground and your legs bent with your feet flat to the ground shoulder-width apart.")
                enumeratedItem(number: 2, text: "Have your heels as close to your bum as possible and thrust your hips upwards until your upper body to your knees are in a straight line.")
                enumeratedItem(number: 3, text: "Make sure you are activating your glutes and core muscle by squeezing and tightening them")
                enumeratedItem(number: 4, text: "Hold for 3 seconds and slowly lower the hips back to the ground, repeat 10-15 times")
                
            }
            .padding(.leading)
            enumeratedItem(number: 3, text: "Squat")
            VStack{
                enumeratedItem(number: 1, text: "Stand shoulder width apart with your toes pointed forward")
                enumeratedItem(number: 2, text: "Lower yourself to a sitting position while engaging your core, having your chest tall and keeping your thighs parallel to the ground. ")
                enumeratedItem(number: 3, text: "Push back up to standing and tilting your pelvis forward by tightening and squeezing your glutes together.")
                enumeratedItem(number: 4, text: "Repeat 10-15 times.")
                
            }
            .padding(.leading)
            enumeratedItemModified(number: 4, text:
                                    Text("Join one of our ")
                                    .foregroundColor(Color("gray"))
                                    .font(.system(size: 12))
                                +
                                    Text("virtual workout classes today at ReformFIT ")
                                        .foregroundColor(Color("gray"))
                                        .bold()
                                        .font(.system(size: 12))
                                +
                                    Text("to keep the body moving and in improving a pelvic tilt with our experienced trainers. ")
                                        .foregroundColor(Color("gray"))
                                        .font(.system(size: 12)) )

        }
    }
    
    
}

struct Blog4View_Previews: PreviewProvider {
    static var previews: some View {
        Blog4View()
    }
}

struct enumeratedItem: View{
    let number:Int
    let text :String
    
    var body: some View{
        HStack(alignment:.top){
            HStack {
                Text("\(number).")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 10))
                    .padding(.top,0.5)
            }
                
            
            
             if number != 1{
                Text(text)
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
                
             }
             else{
                Text(text)
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
                    .padding(.leading,2)
             }
            Spacer()
        }
        .padding(.leading)
    }
}

struct enumeratedItemModified: View{
    let number:Int
    let text :Text
    
    var body: some View{
        HStack(alignment:.top){
            HStack {
                Text("\(number).")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 10))
                    .padding(.top,0.5)
            }
                
            
            
             if number != 1{
                text
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
                
             }
             else{
                text
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
                    .padding(.leading,2)
             }
            Spacer()
        }
        .padding(.leading)
    }
}
