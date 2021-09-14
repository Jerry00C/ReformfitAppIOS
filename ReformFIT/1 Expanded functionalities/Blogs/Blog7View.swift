//
//  Blog7View.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-09.
//



import SwiftUI

struct Blog7View: View {
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
                    VStack(spacing:24){
                        foodChoices
                        mealPrep

                        slowDown
                        moreVitamin
                        stayActive
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
            
            BlogTitle(content: "Finding Balance During COVID: Food, Lifestyle and Exercise", size: 18)

                
            
            VStack(spacing:6) {
                postedDate
                mainImage
            }
            
            
            
        }
    }
    var postedDate: some View{
        HStack {
            Text("Posted on November 1, 2020")
                .font(.system(size: 6))
                .foregroundColor(Color("rare_gray"))
            Spacer()
        }
    }
    var mainImage: some View{
        Image("Blog7Image")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var description:some View{
        VStack (alignment:.leading,spacing:6){
            
            // content
            Text("Now that we are entering Wave 2 of COVID-19, it is crucial to re-learn how to find balance in our day-to-day life. Many of you can relate to how much life has changed since COVID-19 began and we must put in extra effort to find balance and make life enjoyable and healthy again! In the following, 5 tips and recommendations will be provided to help you maintain and rebuild healthy habits in food choices, lifestyle and exercise! ")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
           
            
            
        }
    }
    
  
    
    
    var foodChoices:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "1. AFTERBURN EFFECT", size: 14)
                HStack{
                    
                       FCpart1
                    +
                        FCpart2
                    +
                        FCpart3
                        
                        Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)

                
            }
            
        }
    }
    
    var FCpart1: Text{
        Text("To maintain a healthy life and healthy weight, it is important to be smart about your food choices. The path to weight loss and management begins with a well-balanced diet of high quality, nutrient dense foods; however, it is also necessary to")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
      
        +
       
            Text(" allow")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
    }
    var FCpart2: Text{
        Text("yourself to eat empty calorie foods in moderation to develop a sustainable, balanced lifestyle.\n\nSo where do you start? First, an easy step is to simply become more aware of each meal and ask yourself, “Is my meal well-balanced with high quality carbohydrates, proteins, and fats?” If not, notice which category is the highest and adjust by following the ")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
      
        +
       
            Text("Magic Plate/Bowl Theory")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
    }
    var FCpart3: Text{
        Text(". This is an easy tool to guide you in making each of your meals more balanced! Eating a balanced diet will help in weight loss and management, and is one way to ensure you are getting enough")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
      
        +
       
            Text(" essential nutrients")
                .foregroundColor(Color("white"))
                .font(.system(size: 12))
        +
            Text(" to stay healthy and strong.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
    }
    
    
    
    var mealPrep:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "2. BURN MORE CALORIES IN A SHORTER TIME", size: 14)
                HStack{
                    
                       MPpart1
                    +
                        MPpart2
                   
                        
                        Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            
            
        }
    }
    var MPpart1: Text{
        Text("If making your own meals is too hard or time consuming, then subscribing to a Meal Prep Service such as")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
      
        +
       
            Text(" ReformFIT EATS")
                .foregroundColor(Color("yellow"))
                .font(.system(size: 12))
    }
    var MPpart2: Text{
        Text(", is a great idea that can be a helpful and healthy way for weight management! Some Meal Prep Services are great at creating meals that are suitable for your body’s unique needs and health goals!\n\nLearn more about")
            .foregroundColor(Color("gray"))
            .font(.system(size: 12))
      
        +
       
            Text(" ReformFIT EATS")
                .foregroundColor(Color("yellow"))
                .font(.system(size: 12))
        +
            Text(" today and receive your first delicious meal!")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
    }
    
    
    
    var slowDown:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "3. WEIGHT LOSS", size: 14)
                HStack{
                Text("We live in such a fast paced society that we often-think moving fast and eating fast is the way to save time and do more. However, the opposite is true! When we move too fast and eat too fast, we end up putting the body into a “stress response” and it actually ends up ")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
              
                +
               
                    Text("slowing your metabolism and digestion")
                        .foregroundColor(Color("white"))
                        .font(.system(size: 12))
                +
                    Text(", which increases fat storage and makes it harder to maintain a healthy weight! So when eating, take your time to chew your food and enjoy it! When doing day-to-day activities, make sure to slow down and take a break to refresh before continuing.")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                    
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)

            }
            
            
        }
    }
    var moreVitamin:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "4. TARGETS MORE MUSCLE GROUPS", size: 14)
                HStack{
                Text("Even with quarantine in effect and many places being shut down, it is ")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
              
                +
               
                    Text(" ESSENTIAL")
                        .foregroundColor(Color("white"))
                        .font(.system(size: 12))
                +
                    Text(" to get outside to connect with nature and get a strong source of Vitamin D. You can simply go for a 15-minute brisk walk and get some fresh air to reduce stress and even boost your immune system! Staying indoors all day can affect your overall health negatively. If getting outside everyday is not possible, add a plant to your home to remove excess CO2 and open windows to allow fresh air to enter!")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                    
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)

                
               
            }
            
            
        }
    }
    
    var stayActive :some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "5. LOWERS BLOOD PRESSURE and BLOOD SUGAR LEVELS", size: 14)
                HStack{
                Text("Physical exercise is proven to provide many health benefits ranging from improving physical, brain, and mental health. All of these are also essential for weight loss and management. Challenge yourself this week and ")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
              
                +
               
                    Text("join one of our virtual workouts at ReformFIT")
                        .foregroundColor(Color("white"))
                        .font(.system(size: 12))
                +
                    Text(" to maintain a healthy balance of movement in your day-to-day routine!")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                    
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)

                
               
               
            }
            
            
        }
    }
    
   
    
    
    
}

struct Blog7View_Previews: PreviewProvider {
    static var previews: some View {
        Blog7View()
    }
}
