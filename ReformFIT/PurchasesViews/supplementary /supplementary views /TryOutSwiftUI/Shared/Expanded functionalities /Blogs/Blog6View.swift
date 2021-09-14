//
//  Blog6View.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-09.
//



import SwiftUI

struct Blog6View: View {
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
                        afterBurnEffect
                        burnMoreShortTime

                        weightLoss
                        targetMoreGroup
                        LBP_BSL
                    }
                    VStack{
                        Spacer().frame(height:6)
                        DividerView(width: 2)
                        Spacer().frame(height:6)
                    }
                    citation

                    
                    
                    
                    
                    
                    
                    Spacer().frame(height:10)
                }
                .padding(.horizontal,12)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }
        
    }
    var headerPart: some View{
        VStack(spacing:12){
            
            BlogTitle(content: "Make the Switch to HIIT, High Intensity Interval Training", size: 18)

                
            
            VStack(spacing:6) {
                postedDate
                mainImage
            }
            
            
            
        }
    }
    var postedDate: some View{
        HStack {
            Text("Posted on December 7, 2020")
                .font(.system(size: 6))
                .foregroundColor(Color("rare_gray"))
            Spacer()
        }
    }
    var mainImage: some View{
        Image("Blog6Image")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var description:some View{
        VStack (alignment:.leading,spacing:6){
            
            // content
            Text("Over the years, HIIT has gained a lot of popularity and it’s mainly due to the many benefits it has! HIIT workouts involve short periods (30-60seconds) of intense exercise followed by low intensity recovery periods. In a shorter period of time than your traditional cardio exercise like running, you are able to improve more muscle groups at once, burn more fat, and improve strength, endurance and cardio in a single workout.\n\nAn effective HIIT workout can range from anywhere between 5 to 30 minutes. At ReformFIT, our workouts are 50 minutes in total including a 10-minute warm up and cool down making it an ideal length!\n\nBelow are 5 health-supporting benefits of High-Intensity Interval Training.")
                .foregroundColor(Color("gray"))
                .font(.system(size: 12))
           
            
            
        }
    }
    
  
    
    
    var afterBurnEffect:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "1. AFTERBURN EFFECT", size: 14)
                HStack{
                Text("During a HIIT workout, the goal is to push your heart rate and intensity up to 50-60% VO2 Max. This results in stimulating EPOC (Excess Post-Exercise Oxygen Consumption) and is known as the ")
                    .foregroundColor(Color("gray"))
                    .font(.system(size: 12))
              
                +
               
                    Text("Afterburn Effect")
                        .foregroundColor(Color("white"))
                        .font(.system(size: 12))
                +
                    Text("¹. By stimulating a higher EPOC through HIIT, it consumes more oxygen, which creates a bigger deficit in the body. As a result, your metabolic rates can increase up to 24 hours after a HIIT workout to replenish oxygen, ATP and rebuilding muscles, making it burn more calories and fat long after the workout is over!")
                        .foregroundColor(Color("gray"))
                        .font(.system(size: 12))
                    
                    Spacer()
                }
                .fixedSize(horizontal: false, vertical: true)

                
            }
            .fixedSize(horizontal: false, vertical: true)
            
        }
    }
    
    
    
    var burnMoreShortTime:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "2. BURN MORE CALORIES IN A SHORTER TIME", size: 14)
                BlogTextContent(content: "A study has shown that a 30-minute HIIT workout was able to burn more calories than the traditional weight training, running and biking workout that would last much longer². So not only are you saving time but also being more efficient with your body during a HIIT workout.", size: 12)
                    .fixedSize(horizontal: false, vertical: true)

                
            }
            
            
        }
    }
    
    
    
    var weightLoss:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "3. WEIGHT LOSS", size: 14)
                BlogTextContent(content: "Since HIIT burns more calories during and after the workout in a shorter period of time, it can be a great way to help with weight loss along side proper nutrition and lifestyle changes.", size: 12)
                    .fixedSize(horizontal: false, vertical: true)

                
            }
            
            
        }
    }
    var targetMoreGroup:some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "4. TARGETS MORE MUSCLE GROUPS", size: 14)
                BlogTextContent(content: "Due to the type of exercises used in HIIT, you are more likely to utilize different muscle groups to perform each exercise. For instance, in one single HIIT workout, you will be performing exercises that targets, lower body, upper body, core and full body such as burpees, squats, push-ups etc.", size: 12)
                    .fixedSize(horizontal: false, vertical: true)

                
               
            }
            
            
        }
    }
    
    var LBP_BSL :some View{
        VStack(spacing:12){
            VStack(spacing:6){
                BlogTitle(content: "5. LOWERS BLOOD PRESSURE and BLOOD SUGAR LEVELS", size: 14)
                BlogTextContent(content: "Research has shown that performing HIIT workouts 5 days a week for six weeks resulted in improvements in blood pressure and better control in blood sugar levels³. That being said, this type of exercise can be helpful in improving overall health, and can play a role in preventing chronic illnesses such as cardiovascular disease and diabetes.", size: 12)
                    .fixedSize(horizontal: false, vertical: true)

                
               
            }
            
            
        }
    }
    
    var citation:some View{
        HStack{
        Text("¹LaForgia, J., Withers, R. T., & Gore, C. J. (2006). Effects of exercise intensity and duration on the excess post-exercise oxygen consumption. Journal of sports sciences, 24(12), 1247–1264.")
            .foregroundColor(Color("gray"))
            .font(.system(size:10))
      
        +
       
            Text(" https://doi.org/10.1080/02640410600552064")
                .foregroundColor(Color("yellow"))
                .font(.system(size:10))
        +
            Text("\n\n²Falcone, P. H., Tai, C. Y., Carson, L. R., Joy, J. M., Mosman, M. M., McCann, T. R., Crona, K. P., Kim, M. P., & Moon, J. R. (2015). Caloric expenditure of aerobic, resistance, or combined high-intensity interval training using a hydraulic resistance system in healthy men. Journal of strength and conditioning research, 29(3), 779–785. https://doi.org/10.1519/JSC.\n\n³Fergal Grace, Peter Herbert, Adrian D. Elliott, Jo Richards, Alexander Beaumont, Nicholas F. Sculthorpe. High intensity interval training (HIIT) improves resting blood pressure, metabolic (MET) capacity and heart rate reserve without compromising cardiac function in sedentary aging men (2018).Experimental Gerontology, 109, 75-81,")
                .foregroundColor(Color("gray"))
                .font(.system(size:10))
            
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)

    }
    
    
}

struct Blog6View_Previews: PreviewProvider {
    static var previews: some View {
        Blog6View()
    }
}
