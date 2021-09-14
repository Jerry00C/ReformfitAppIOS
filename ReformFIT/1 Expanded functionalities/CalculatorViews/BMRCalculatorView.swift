//
//  BMICalculatorView.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-02.
//

import SwiftUI

struct BMRCalculatorView: View {
    @State var backToMain = false
    @State var showCalculator = false
    @State var cardDismissal = false
    @State var index:CGFloat = 0
    @State var FAQExpand: Bool = false
    @State var descriptionCollapsed = true
    
    /* the following to state might not have a effect on making ui look better, trivial, could be deleted */
    @State var transitionToDescription = false
    @State var transitionToFAQ = false
    /*  end of the comment*/
    
    @State var scrollTabsMinY: CGFloat = 140
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
                                        Image("BMR")
                                            .resizable()
                //                            .scaledToFit()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height:UIScreen.main.bounds.width*1/2)
                                            // change to any other number would expand other sub view,( combined effect of this and faqsection of text content)
                                            .overlay( Rectangle().foregroundColor(Color("main_background"))
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
                                        // cannot purely use aspectRatio because this page is expandable in height
                                        //this apply for other calculation page too
                    
                                        
                                        
    //                                    Rectangle().foregroundColor(Color("main_background"))
    //                                        .opacity(1-(Double(scrollTabsMinY)-40)*0.01)
                                    }
    //                                GeometryReader{ geo -> AnyView in
    //
    //            //                        print(geo.frame(in: .global).minY)
    //                                    DispatchQueue.main.async {
    //
    //
    //
    //                                    }
    //                                    return AnyView(Color("yellow").frame(width:0,height:0))
    //                                }
    //                                .frame(width:0, height: 0)
                                    
                                    
                                    
                                        
                                    
    //                                Spacer()
    //                                    .frame(height:1)
                                    
                                    BMRCalculatorDescription(desCollapsed: $descriptionCollapsed)
                                        .padding(.horizontal)
                                        .id("description")
                                        .background(
                                            // originally as a empty view on top of description but there is a unknown space
                                            GeometryReader{
                                            geo -> AnyView in
                                            DispatchQueue.main.async {
                                                let descriptionTopPosition = geo.frame(in: .named("mainScrollView")).minY
                                                
    //                                            scrollTabsMinY = descriptionTopPosition
                                                descriptionPosition = descriptionTopPosition
                                                // 32 is a custom size space for clarity, helps scrolltabs to locate at better and visible place
                                                if descriptionTopPosition<10 && faqPosition>10 && !transitionToFAQ{
                                                    index = 0
                                                    transitionToDescription = false
//                                                    print(transitionToDescription)
                                                }
                                            }
                                            
                                            return AnyView(Rectangle())
                                        })
                                    BMREnergyConsumationTable()
                                        .padding(.horizontal)
                                    BMREquationDisplay()
                                        .padding(.horizontal)
                                    
                                    
    //                                .frame(width:0,height:0)
                                    FAQSectionDisplay( FAQExpand: $FAQExpand)
                                        .padding(.horizontal)
                                        .id("faq")
                                        .background(GeometryReader{ geo -> AnyView in
                                            
                                            DispatchQueue.main.async {
                                                let FAQTopPosition = geo.frame(in: .named("mainScrollView")).minY
                                                faqPosition = FAQTopPosition
                                                print(transitionToFAQ)
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
                    .frame(height: scrollTabsMinY>60 ? 0 : 60)
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
//        .animation(.default) // this makes scrolltab act with animation
        .background(Color("black"))
        .navigationTitle("")
        .navigationBarHidden(true)
        .statusBar(hidden: false)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.bottom)

    }
//    var scrollTabs: some View{
//
//    }
    var bottomCalculatorSheet: some View{
        BottomSheetView(
            cardShown: $showCalculator,
            cardDismissal: $cardDismissal,
            offset: UIScreen.main.bounds.height,
            whenExpanded: 40){
            BMRCalculationPage(calculatorShown: $showCalculator,offset:40)
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

struct BMRCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        BMRCalculatorView()
    }
}

struct ScrollTabs: View{
    @Binding var descriptionCollapsed:Bool
    @Binding var transitionToDescription:Bool // might be useless
    @Binding var transitionToFAQ:Bool   // might be useless
    @Binding var index:CGFloat
    var proxy:ScrollViewProxy
    @Binding var FAQExpand:Bool
    var body: some View{
        HStack {
            HStack(spacing:10){
                Text("工具介绍")
                    .font(.title2)
                    .foregroundColor(self.index == 0 /*&& !transitionToDescription*/ ? Color("white") : Color("gray"))
                    .onTapGesture {
                        if self.index != 0{
                            self.index = 0
                            transitionToDescription = true
                            withAnimation{
                                var additionalPoint :CGFloat = 0
                                if descriptionCollapsed{
                                    additionalPoint = +0.03
                                }
                                else {
                                    additionalPoint = +0.04
                                }
                                proxy.scrollTo("description", anchor: .init(x:UnitPoint.top.x,y:UnitPoint.top.y+additionalPoint))
                                
//                                proxy.scrollTo("description", anchor:.top)
                                //+0.1 is obtained by trial, must investigate more into this
                            }
                        }
                        
                    }
                Text("常见问题")
                    .font(.title2)
                    .foregroundColor(self.index == 1  ? Color("white") : Color("gray"))
                    .onTapGesture {
                        if self.index != 1{
                            self.index = 1
                            transitionToFAQ = true
                            withAnimation{
                                proxy.scrollTo("faq", anchor: .init(x:UnitPoint.top.x,y:UnitPoint.top.y-0.01))
//                                proxy.scrollTo("faq", anchor:.top)
                                // temporarily change to -0.05 to make the view slightly looks more correct
                                //-0.1 is obtained by trial, must investigate more into this
                                FAQExpand = false // means expanded
                            }
                        }
                    }
            }
            .background(Color("card_background").opacity(0.8))
            Spacer()
        }
        .background(Color("main_background").opacity(0.8))
    }
}

struct BMRCalculatorDescription: View{
    @Binding var desCollapsed:Bool
    var body: some View{
        ZStack{
            CardBackground()
            VStack(alignment:.leading){
                TitleView(title: "BMR 计算器",titleSize: Font.title, imageString: "flame.fill", imageSize: 30)
                Spacer().frame(height:12)
                SimpleCollapseText(description: "By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .", isCollapsed: $desCollapsed)
                    .foregroundColor(Color("gray"))
                    .fixedSize(horizontal: false, vertical: true)
            
            }
            .padding()
        }
    }
}
struct BMREnergyConsumationTable: View {
    var body: some View {
        ZStack(){
           CardBackground()
            VStack(alignment:.leading) {
                Text("能量消耗占比")
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                HStack{
                    VStack(spacing:0){
                        TableItem(text: "部位",
                                  textColor: Color("white"),
                                  backgroundColor: Color("rare_gray")
                                    )
                        TableItem(text: "肝",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "大脑",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "骨髓肌",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "肾",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "心脏",
                                  textColor: Color("white")
                                    )
                        TableItem(text: "其他器官",
                                  textColor: Color("white")
                                    )
                        
                    }
                    VStack(spacing:0){
                        TableItem(text: "消耗比例", textColor: Color("white"),backgroundColor: Color("rare_gray"))
                        TableItem(text: "27%",
                                  textColor: Color("gray")
                                    )
                        TableItem(text: "19%",
                                  textColor: Color("gray")
                                    )
                        TableItem(text: "18%",
                                  textColor: Color("gray")
                                    )
                        TableItem(text: "10%",
                                  textColor: Color("gray")
                                    )
                        TableItem(text: "7%",
                                  textColor: Color("gray")
                                    )
                        TableItem(text: "19%",
                                  textColor: Color("gray")
                                    )
                        
                    }
                }
//                .overlay(Rectangle().strokeBorder().foregroundColor(.black))
            }
            .padding()
        }
    }
}

struct BMREquationDisplay: View{
    var body: some View{
        ZStack(){
           CardBackground()
            VStack(alignment:.leading) {
                Text("BMR公式")
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                mufflinEquationTable
                
                KatchEquationTable
                
                termMeaning
            }
            .padding()
        }
    }
    
    var mufflinEquationTable: some View{
        VStack (spacing:0){
            TableItem(text: "Mifflin - St Jeor formula (1990)",
                      textColor: Color("white"),
                      backgroundColor: Color("rare_gray")
                        )
            HStack{
                VStack(spacing:0){
                    // M:
                    HStack {
                        Text("M:")
                            .foregroundColor(Color("white"))
                            .padding(6)}
                    .background(Rectangle()
                                    .strokeBorder(Color("gray"))
                                    .background(Rectangle().fill( Color("white").opacity(0)))
                                    )
                    // W:
                    HStack {
                        Text("W:")
                            .foregroundColor(Color("white"))
                            .padding(6)
                    }
                    .background(Rectangle()
                                    .strokeBorder(Color("gray"))
                                    .background(Rectangle().fill( Color("white").opacity(0)))
                                    )
                    
                   
                    
                }
                VStack(spacing:0){
                    TableItem(text: "(10 x W)+(6.25 x H)-(5 x A)+5", textColor: Color("gray"))
                    TableItem(text: "(10 x W)+(6.25 x H)-(5 x A)-161",
                              textColor: Color("gray")
                                )
                    
                    
                }
            }
        }
    }
    
    var KatchEquationTable:some View{
        VStack(spacing:0){
            TableItem(text: "The Katch-McArdle formula",
                      textColor: Color("white"),
                      backgroundColor: Color("rare_gray")
                        )
            TableItem(text: "370+(21.6 x (W x (100 - BF)/100", textColor: Color("gray"))
        }
    }
    
    var termMeaning: some View{
        HStack{
            Spacer()
            VStack(alignment:.leading,spacing:6){
                weight
                bodyFat
                
            }
            Spacer()
            VStack(alignment:.leading,spacing:6){
                height
                age
            }
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


struct TitleView: View{
    var title :String
    var titleSize:Font
    var imageString : String
    var imageSize: CGFloat
    
    var body: some View{
        
        HStack(alignment: .center) {
            if imageString != ""{
                Image(systemName: imageString)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30.0)
            }
            Text(title)
                .font(.title)
            
        }
        .foregroundColor(Color("yellow"))
    }
}

struct FAQSectionDisplay: View{
    @Environment(\.openURL) var openURL
    @Binding var FAQExpand:Bool
    var body: some View{
        ZStack{
            CardBackground()
            VStack {
                VStack(alignment:.leading){
                    TitleView(title: "FAQ",titleSize: Font.title, imageString: "questionmark.circle", imageSize: 30)
                    Spacer().frame(height:12)
                    CollapseTextView(isCollapsed: $FAQExpand){
                        fullFAQSession
                    }

                }
                bottomNotification
                
            }
            .padding()
        }
    }
    var bottomNotification: some View{
        VStack(alignment:.center){
            Text("*Visit ").foregroundColor(Color("gray"))
            +
            Text("Canadian Guidelines for Body Weight Classification in Adults")
                .foregroundColor(Color("yellow"))
                .underline()
                
            +
            Text(" for complete Question and Answer(Q & A)")
                .foregroundColor(Color("gray"))
        }.onTapGesture {
            openURL(URL(string: "https://www.canada.ca/en/health-canada/services/food-nutrition/healthy-eating/healthy-weights/canadian-guidelines-body-weight-classification-adults.html")!)
        }
    }
    var fullFAQSession: some View{
        
            Text("Q: What is the Canadian body weight classification system?\n").foregroundColor(Color("white"))
            +
            Text("A: The Canadian body weight classification system uses the body mass index (BMI) and the waist circumference (WC) to assess the risk of developing health problems associated with overweight or underweight.The system is for use with adults age 18 years and over with the exception of pregnant and lactating women.\n").foregroundColor(Color("gray"))
            +
            Text("Q: What does a high or low BMI mean?\n").foregroundColor(Color("white"))
            +

            Text("Most adults with a high BMI (overweight or obese) have a high percentage of body fat. Extra body fat is associated with increased risk of health problems such as diabetes, heart disease, high blood pressure, gallbladder disease and some forms of cancer.\n\nA low BMI (underweight) is associated with health problems such as osteoporosis, undernutrition and eating disorders.\n\nThe risk of developing weight-related health problems increases the further one's BMI falls outside the 'normal weight' category. It is important to note that sudden or considerable weight gains or weight losses may also indicate health risk, even if this occurs within the 'normal weight' BMI category.\n").foregroundColor(Color("gray"))
            +
            Text("Q: Are there limitations to the body weight classification system?\n").foregroundColor(Color("white"))
                +

            Text("A: The classification system may underestimate or overestimate health risks in certain adults, such as, highly muscular adults, adults who naturally have a very lean body build, young adults who have not reached full growth, and adults over 65 years of age.\n\nVery muscular adults, such as athletes, may have a low percentage of body fat but a large amount of muscle tissue. This can result in a BMI in the overweight range which may over estimate the risk of developing health problems.\n\nFor people who naturally have a very lean body build or for young adults who have not attained their full growth, a BMI just below the 'normal weight' range may not indicate an increased health risk.\n\nFor adults over age 65, more research is needed to determine if the cut-off points for the 'normal weight' range differ in any way from those for younger adults.\n\nIt is also important to note that BMI and WC are only one part of a health risk assessment. To further clarify risk, other factors need to be considered as well.\n").foregroundColor(Color("gray"))
    }
}


struct BMRCalculationPage: View{
    @Environment(\.openURL) var openURL
    
    @Binding var calculatorShown:Bool
    let offset:CGFloat
    @ObservedObject var BMRModel:BMRCalculationManager = BMRCalculationManager()
    @State var gender = "男"
    @State var age = ""
    @State var height = ""
    @State var weight = ""
    @State var bodyFat = ""
    
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
                    genderField
                    ageField
                    heightField
                    weightField
                    bodyFatField
                    if  result != nil{
                        BMRResult
                    }
                    BMRNote
                    
                }
                Spacer()
                HStack(spacing:0){
                    cancelButton
                    confirmButton
                }
                .offset(y:-offset)
                
                
                    
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
    
    var genderField:some View{
        VStack {
            HStack{
                Text("*").foregroundColor(.red)
                +
                Text("性别:").foregroundColor(Color("main_background"))
                Spacer()
                RadioGroup(
                    buttonNames: ["男","女"],
                    selectedButton: $gender)
                
            }
            Divider()
        }
        .padding(.horizontal)
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
    var bodyFatField:some View{
        
        VStack {
            HStack{
                Text("  体脂率(%):").foregroundColor(Color("main_background"))
                Spacer()
                
                TextField("请输入体脂率",text: $bodyFat)
                    .fixedSize()
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.numberPad)
                    .emptyButtonToggling(inputText: $bodyFat, emptyToggler: $canEmptyBodyFat){
                        canEmptyWeight = false
                        canEmptyHeight = false
                        canEmptyAge = false
                    }
                if canEmptyBodyFat{
                    emptyField
                        .onTapGesture {
                            bodyFat = ""
                            canEmptyBodyFat = false
                        }
                }
                
            }
            Divider()
        }
        .padding(.horizontal)
    
    }
    
    var BMRResult: some View{
        VStack {
            HStack{
                Text("Your BMR is:").foregroundColor(Color("main_background"))
                Spacer()
                
                
                Text(String(result ?? 0))
                    .foregroundColor(Color("gray"))
                
                
                
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    var BMRNote: some View{
        VStack {
            Text("Note: If bodyfat is entered, Katch-McArdle formula will be used, otherwise Mifflin - St Jeor formula will be used. ")
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
            if age == ""{
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
            
            if age != "" && height != "" && weight != ""{
                BMRModel.setBMRModel(gender: gender, age: age, height: height, weight: weight, bodyFat: bodyFat)
                BMRModel.calculateBMR()
                result = BMRModel.BMRValue
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


struct EmptyButtonToggling:ViewModifier{
    @Binding var inputText:String
    @Binding var emptyToggler:Bool
    var action:()->Void
    func body(content: Content) -> some View {
        content
            .onChange(of: inputText){ value in
                if inputText != ""{
                    withAnimation{
                        emptyToggler = true
                    }
                }
                else if inputText == ""{
                    withAnimation{
                        emptyToggler = false
                    }
                }
            }
            .onTapGesture {
                if inputText != ""{
                    withAnimation{
                        emptyToggler = true
                        
                    }
                }
                withAnimation{
                    action()
                }
            }
//            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
//
//            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)){_ in
                withAnimation{
                    emptyToggler = false
                }
            }
    }
    
}


extension View{
    func emptyButtonToggling(inputText: Binding<String>,emptyToggler: Binding<Bool>,action:@escaping()->Void) -> some View{
        self.modifier(EmptyButtonToggling(inputText: inputText, emptyToggler: emptyToggler,action: action))
    }
}
