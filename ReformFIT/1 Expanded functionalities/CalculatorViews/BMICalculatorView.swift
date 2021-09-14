//
//  BMICalculatorView.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-05.
//

import SwiftUI

struct BMICalculatorView: View {
    @State var backToMain = false
    @State var showCalculator = false
    @State var cardDismissal = false
    @State var index:CGFloat = 0
    @State var FAQExpand: Bool = false
    @State var descriptionCollapsed: Bool = true
    
    /* the following to state might not have a effect on making ui look better, trivial, could be deleted */
    @State var transitionToDescription = false
    @State var transitionToFAQ = false
    /*  end of the comment*/
    
    @State var scrollTabsMinY: CGFloat = 160
    @State var descriptionPosition:CGFloat = 0
    @State var faqPosition:CGFloat = 0
    var body: some View {
        ScrollViewReader{ reader in
        ZStack{
            Color("main_background")
                
            VStack {
                
                    VStack {
                        
                        TopBar(rootActive: $backToMain, titleText: "Blog")
                            .opacity(0)
                        ZStack {
                            ScrollView{
                                VStack(spacing:20){
                                    ZStack {
                                        Image("BMICalculatorTopImage")
                                            .resizable()
                //                            .scaledToFit()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height:UIScreen.main.bounds.width*2/3)
                                            .overlay(Rectangle().foregroundColor(Color("main_background"))
                                                        .opacity(1-(Double(scrollTabsMinY)-40)*0.01))
                                            .background(
                                                // originally as a empty view on top of description but there is a unknown space
                                                GeometryReader{
                                                geo -> AnyView in
                                                DispatchQueue.main.async {
                                                    let descriptionTopPosition = geo.frame(in: .named("mainScrollView")).maxY
//                                                    +100
                                                    
                                                    scrollTabsMinY = descriptionTopPosition
                        
                                                    
                                                }
                                                
                                                return AnyView(Rectangle())
                                            })
                                            
    //                                    Rectangle().foregroundColor(Color("main_background"))
    //                                        .opacity(1-(Double(scrollTabsMinY)-40)*0.01)
                                    }
                                    
    //
                                    
                                    
                                    BMICalculatorDescription(desCollapsed: $descriptionCollapsed)
                                        .padding(.horizontal)
                                        .id("description")
                                        .background(
                                            // originally as a empty view on top of description but there is a unknown space
                                            GeometryReader{
                                            geo -> AnyView in
                                            DispatchQueue.main.async {
                                                let descriptionTopPosition = geo.frame(in: .named("mainScrollView")).minY
                                                
//                                                scrollTabsMinY = descriptionTopPosition
                                                descriptionPosition = descriptionTopPosition
                                                // 32 is a custom size space for clarity, helps scrolltabs to locate at better and visible place
                                                if descriptionTopPosition<10 && faqPosition>10 && !transitionToFAQ{
                                                    index = 0
                                                    transitionToDescription = false
                                                }
                                            }
                                            
                                            return AnyView(Rectangle())
                                        })
                                    BMICategoryTable()
                                        .padding(.horizontal)
                                    BMIEquationDisplay()
                                        .padding(.horizontal)
                                    
                                    
    //                                .frame(width:0,height:0)
                                    FAQSectionDisplay( FAQExpand: $FAQExpand)
                                        .padding(.horizontal)
                                        .id("faq")
                                        .background(GeometryReader{ geo -> AnyView in
                                            
                                            DispatchQueue.main.async {
                                                let FAQTopPosition = geo.frame(in: .named("mainScrollView")).minY
                                                faqPosition = FAQTopPosition
                                                if FAQTopPosition<10 && descriptionPosition < -80 && !transitionToDescription{
                                                    index = 1
                                                    transitionToFAQ = false
                                                }
                                            }
                                            
                                            
                                            return AnyView(Spacer().frame(width:0,height:0))
                                        })
                                    
                                    
                                }
                                
                                
                            }
                            .coordinateSpace(name:"mainScrollView")
                            VStack {
                                ScrollTabs(descriptionCollapsed: $descriptionCollapsed, transitionToDescription: $transitionToDescription, transitionToFAQ: $transitionToFAQ, index: $index,proxy: reader, FAQExpand: $FAQExpand)
                                .offset(y: scrollTabsMinY>0 ? scrollTabsMinY : 0 )
                                Spacer()
                            }
                        }
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height/20)
                        
                    }
                    
                }
            VStack{
                Spacer()
                calculationButton
            }
            VStack{
                Rectangle().foregroundColor(Color("main_background"))
                    .frame(height: scrollTabsMinY>40 ? 0 : 40)
                Spacer()
            }
            
            //scroll tab display
            VStack{
                TopBar(rootActive: $backToMain, titleText: "Blog")
                Spacer()
            }
            bottomCalculatorSheet
                
            }
            
            
        }
        .background(Color("black"))
        .navigationTitle("")
        .navigationBarHidden(true)
        .statusBar(hidden: false)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var bottomCalculatorSheet: some View{
        BottomSheetView(
            cardShown: $showCalculator,
            cardDismissal: $cardDismissal,
            offset: UIScreen.main.bounds.height,
            whenExpanded: 40){
            BMICalculationPage(calculatorShown: $showCalculator,offset:40)
        }
    }
    
    var calculationButton: some View{
        Button(action: {
            
            withAnimation{
                showCalculator.toggle()
            }
            
            
        }, label: {
            ZStack {
                Color("yellow")

                    
                Text("前往付款")
                    .layoutPriority(-1)
                    .foregroundColor(Color("main_background"))
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                
            }
        })
        .frame(height: UIScreen.main.bounds.height/20)
    }
}

struct BMICalculatorDescription: View{
    @Binding var desCollapsed:Bool
    var body: some View{
        ZStack{
            CardBackground()
            VStack(alignment:.leading){
                TitleView(title: "BMI 计算器",titleSize: Font.title, imageString: "flame.fill", imageSize: 30)
                Spacer().frame(height:12)
                SimpleCollapseText(description: "This section is not used for muscle builders, long distance athletes, pregnant women, the elderly or young children. This is because BMI does not take into account whether is carried as muscle or fat, just the number.Those with a higher muscle mass, such as athletes, may have a highBMI but not be at greater health risk. Those with a lower muscle mass, such as children who have not completed their growth or elderly who may be losing some muscle mass may have a lower BMI. During pregnancy and lactation, a woman's body composition changes, so using BMI is not appropriate. For more information, visit Health Canada's Canadian Guidelines for Body Weight Classification in Adults", isCollapsed: $desCollapsed)
                    .foregroundColor(Color("gray"))
                    .fixedSize(horizontal: false, vertical: true)
            
            }
            .padding()
        }
    }
}

struct BMICategoryTable: View {
    var body: some View {
        ZStack(){
           CardBackground()
            VStack(alignment:.leading) {
                Text("BMI分类")
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                HStack{
                    VStack(spacing:0){
                        TableItem(text: "BMI",
                                  textColor: Color("white"),
                                  backgroundColor: Color("rare_gray")
                                    )
                        TableItem(text: "18.5 and lower",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "18.5 - 24.9",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "25.0 - 29.9",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "30.0 - 39.9",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "40.0 and up",
                                  textColor: Color("white")
                                    )
                        
                        
                    }
                    VStack(spacing:0){
                        TableItem(text: "Category", textColor: Color("white"),backgroundColor: Color("rare_gray"))
                        TableItem(text: "Underweight",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "Normal Weight",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "Overweight",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "Obese",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "Morbidly Obese",
                                  textColor: Color("white")
                                    )
                        
                        
                    }
                }
            }
            .padding()
        }
    }
}

struct BMIEquationDisplay: View{
    var body: some View{
        ZStack(){
           CardBackground()
            VStack(alignment:.leading) {
                Text("BMI公式")
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                
                AdolpheQueteletTable
                
                termMeaning
            }
            .padding()
        }
    }
    
    
    
    var AdolpheQueteletTable:some View{
        VStack(spacing:0){
            TableItem(text: "Adolphe Quetelet Formula",
                      textColor: Color("white"),
                      backgroundColor: Color("rare_gray")
                        )
            HStack {
                TableItem(text: "Male/Female:", textColor: Color("white"))
                TableItem(text: "W / (H / 100)²", textColor: Color("white"))
            }
        }
    }
    
    var termMeaning: some View{
        HStack{
            Spacer()
            weight
                
                
            
            Spacer()
            height
                
            
            Spacer()
        }
    }
    var weight: some View{
        Text("W")
            .foregroundColor(Color("white"))
            .fontWeight(.bold)
            .font(.footnote)
            +
        Text(" - Weight(kg)")
            .foregroundColor(Color("gray"))
            .font(.footnote)
    }
    var bodyFat: some View{
        Text("BF")
            .foregroundColor(Color("white"))
            .fontWeight(.bold)
            .font(.footnote)
            +
        Text(" - Bodyfat%")
            .foregroundColor(Color("gray"))
            .font(.footnote)
    }
    var height: some View{
        Text("H")
            .foregroundColor(Color("white"))
            .fontWeight(.bold)
            .font(.footnote)
            +
        Text(" - Height(cm)")
            .foregroundColor(Color("gray"))
            .font(.footnote)
    }
    var age : some View{
        Text("A")
            .foregroundColor(Color("white"))
            .fontWeight(.bold)
            .font(.footnote)
            +
        Text(" - Age(year)")
            .foregroundColor(Color("gray"))
            .font(.footnote)
    }
}

struct BMICalculationPage: View{
    @Environment(\.openURL) var openURL
    
    @Binding var calculatorShown:Bool
    let offset:CGFloat
    @ObservedObject var BMIModel:BMICalculationManager = BMICalculationManager()
    @State var age = ""
    @State var height = ""
    @State var weight = ""
    
    // warning states
    @State var ageWarning = false
    @State var heightWarning = false
    @State var weightWarning = false
    
    // empty input field states
    @State var canEmptyAge = false
    @State var canEmptyHeight = false
    @State var canEmptyWeight = false
    @State var canEmptyBodyFat = false
    
    @State var result:Double?
    
    
    var body: some View{
        ZStack(alignment:.topTrailing){
            
            VStack{
                title
                Spacer()
                    .frame(height:32)
                VStack(spacing:16){
                    ageField
                    heightField
                    weightField
                    if  result != nil{
                        BMIResult
                    }
                    BMINote
                    
                }
                Spacer()
                HStack(spacing:0){
                    cancelButton
                    confirmButton
                }
                .offset(y:-offset)// this offset is to show the buttons
                
                
                    
            }
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
            
            
            
        }
        
    }
    
    var closeWindow: some View{
        
        Image(systemName: "xmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 12, height: 12)
            .foregroundColor(.gray)
            .onTapGesture {
                withAnimation(){
                    hideKeyboard()
                    calculatorShown = false
                }
            }
    }
    var title : some View{
        ZStack {
            HStack {
                Text("请输入您的个人信息")
                    .frame(maxWidth:.infinity)
            }
            .padding(32)
            HStack {
                Spacer()
                closeWindow
                    .padding(.horizontal)
            }
        }
        
    }
    
    
    
    var ageField:some View{
        VStack {
            HStack{
                Text("*").foregroundColor(.red)
                +
                Text("年龄:").foregroundColor(Color("main_background"))
                Spacer()
                
                TextField("请输入年龄",text: $age)
                    .fixedSize()
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .emptyButtonToggling(inputText: $age, emptyToggler: $canEmptyAge){
                        canEmptyWeight = false
                        canEmptyHeight = false
                        canEmptyBodyFat = false
                    }
                    .onChange(of: age, perform: { value in
                        if age != "" && ageWarning{
                            withAnimation{
                                ageWarning = false
                            }
                        }
                        if Double(age) ?? 0 < 18 && !ageWarning && age != ""{
                            withAnimation{
                                ageWarning = true
                            }
                        }
                        if age == ""{
                            withAnimation{
                                ageWarning = false
                            }
                        }
                    })
                if canEmptyAge{
                    emptyField
                        .onTapGesture {
                            age = ""
                            canEmptyAge = false
                        }
                }
                
                
                
            }
            Divider()
            if ageWarning{
                HStack{
                    Spacer()
                    Text("请输入正确年龄")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal)
    }
    var heightField:some View{
        VStack {
            HStack{
                Text("*").foregroundColor(.red)
                +
                Text("身高(cm):").foregroundColor(Color("main_background"))
                Spacer()
                
                TextField("请输入身高",text: $height)
                    .fixedSize()
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .emptyButtonToggling(inputText: $height, emptyToggler: $canEmptyHeight){
                        canEmptyWeight = false
                        canEmptyAge = false
                        canEmptyBodyFat = false
                    }
                    .onChange(of: height, perform: { value in
                        if height != "" && heightWarning{
                            withAnimation{
                                heightWarning = false
                            }
                        }
                    })
                if canEmptyHeight{
                    emptyField
                        .onTapGesture {
                            height = ""
                            canEmptyHeight = false
                        }
                }
                
                
            }
            
            Divider()
            if heightWarning{
                HStack{
                    Spacer()
                    Text("请输入正确身高")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal)
    }
    
    var weightField:some View{
        VStack {
            HStack{
                Text("*").foregroundColor(.red)
                +
                Text("体重(kg):").foregroundColor(Color("main_background"))
                Spacer()
                
                TextField("请输入体重",text: $weight)
                    .fixedSize()
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .emptyButtonToggling(inputText: $weight, emptyToggler: $canEmptyWeight){
                        canEmptyAge = false
                        canEmptyHeight = false
                        canEmptyBodyFat = false
                    }
                    .onChange(of: weight, perform: { value in
                        if weight != "" && weightWarning{
                            withAnimation{
                                weightWarning = false
                            }
                        }
                    })
                if canEmptyWeight{
                    emptyField
                        .onTapGesture {
                            weight = ""
                            canEmptyWeight = false
                        }
                }
                
                
            }
            
            Divider()
            if weightWarning{
                HStack{
                    Spacer()
                    Text("请输入正确体重")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal)
    }
    
    
    var BMIResult: some View{
        VStack {
            HStack{
                Text("Your BMI is:").foregroundColor(Color("main_background"))
                Spacer()
                
                
                Text(String(result ?? 0))
                    .foregroundColor(Color("gray"))
                
                
                
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    var BMINote: some View{
        VStack {
            Text("Note: Results of the BMI calculator are based on averages. Keep in mind that the BMI calculator may over-estimate body fat in those with a muscular build. A BMI calculayor is designed yo assess your relative fitness but it is not a calculation of body fat percentage. ")
                .foregroundColor(Color("gray"))
                .font(.caption)
            Divider()
            Text("查看Health Canada官网")
                .underline()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .font(.body)
                .onTapGesture {
                    openURL(URL(string: "https://www.canada.ca/en/health-canada/services/food-nutrition/healthy-eating/healthy-weights/canadian-guidelines-body-weight-classification-adults.html")!)
                }
        }
        .padding(.horizontal)
    }
    
    var confirmButton: some View{
        Button(action: {
            if age == "" || Double(age) ?? 0 < 18{
                withAnimation{
                    ageWarning = true
                }
            }
            if height == ""{
                withAnimation{
                    heightWarning = true
                }
            }
            if weight == ""{
                withAnimation{
                    weightWarning = true
                }
            }
            
            if age != "" && Double(age) ?? 0>=18 && height != "" && weight != ""{
                BMIModel.setBMIModel(height: height, weight: weight)
                BMIModel.calculateBMI()
                result = round((BMIModel.BMIValue ?? 1)*100)/100
            }
            
            
//            print(BMRModel.BMRValue!)
        
        }) {
            ZStack {
                RoundedCorners(color: Color("yellow"),tl: 0,tr: 0,bl: 0,br: 30)
                    .frame(maxWidth:.infinity,maxHeight: UIScreen.main.bounds.height/15)
                Text("提交")
                    .foregroundColor(Color("main_background"))
                    .font(.headline)
                    .padding()
                    .shadow(color: Color.gray.opacity(0.5), radius: 8)
            }
        }
    }
    var cancelButton: some View{
        Button(action: {
            withAnimation(.easeOut(duration: 0.1)){
                calculatorShown.toggle()
            }
            
            print("close modal")
        }) {
            ZStack {
                RoundedCorners(color: Color("gray"),tl: 0,tr: 0,bl: 30,br: 0)
                    .frame(maxWidth:.infinity,maxHeight: UIScreen.main.bounds.height/15)
            Text("关闭")
                .foregroundColor(Color("white"))
                .font(.headline)
                .padding()
                .shadow(color: Color.gray.opacity(0.5), radius: 8)
            }
        }
    }
    
    var emptyField: some View{
        Image(systemName: "multiply.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 12.0, height: 12.0)
            .foregroundColor(Color("gray"))
    }
}



struct BMICalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        BMICalculatorView()
    }
}
