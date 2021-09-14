//
//  TDEECalculatorView.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-09-05.
//

import SwiftUI

struct TDEECalculatorView: View {
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
                                    }
                                    
    //
                                    
                                    
                                    
                                    TDEECalculatorDescription(desCollapsed: $descriptionCollapsed)
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
                                    TDEEElementsTable()
                                        .padding(.horizontal)
                                    TDEEEquationDisplay()
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
            TDEECalculationPage(calculatorShown: $showCalculator,offset:40)
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

struct TDEECalculatorDescription: View{
    @Binding var desCollapsed: Bool
    var body: some View{
        ZStack{
            CardBackground()
            VStack(alignment:.leading){
                TitleView(title: "TDEE 计算器",titleSize: Font.title, imageString: "flame.fill", imageSize: 30)
                Spacer().frame(height:12)
                SimpleCollapseText(description: "By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .By typing my name and click the button, I agree that  the text inputted into the field above will be the electronic representation of my signature for the purpose of agreeing to the autopay and the associated terms and conditions alt- just the same as a pen-and paper signature .", isCollapsed: $desCollapsed)
                    .foregroundColor(Color("gray"))
                    .fixedSize(horizontal: false, vertical: true)
            
            }
            .padding()
        }
    }
}

struct TDEEElementsTable: View {
    var body: some View {
        ZStack(){
           CardBackground()
            VStack(alignment:.leading) {
                Text("TDEE构成元素")
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                HStack{
                    VStack(spacing:0){
                        TableItem(text: "元素",
                                  textColor: Color("white"),
                                  backgroundColor: Color("rare_gray"),
                                  font: .system(size: 14)
                                    )
                        TableItem(text: "BMR",
                                  textColor: Color("white"),
                                  font: .system(size: 14)
                                    )
                        TableItem(text: "TEF",
                                  textColor: Color("white"),
                                  font: .system(size: 14)
                                    )
                        TableItem(text: "NEAT",
                                  textColor: Color("white"),
                                  font: .system(size: 14)
                                    )
                        TableItem(text: "TEA",
                                  textColor: Color("white"),
                                  font: .system(size: 14)
                                    )
                        
                        
                    }
                    .frame(width:70)// minimum size to have perfect fit of table
                    VStack(spacing:0){
                        TableItem(text: "全称", textColor: Color("white"),backgroundColor: Color("rare_gray"),font: .system(size: 14))
                        TableItem(text: "Basal Metabolic Rate",
                                  textColor: Color("gray"),
                                  font: .system(size: 14)                        )
                        TableItem(text: "Thermic Effect of Food",
                                  textColor: Color("gray"),
                                  font: .system(size: 14)                                    )
                        TableItem(text: "Non-Exercise Activity Thermogenesis",
                                  textColor: Color("gray"),
                                  font: .system(size: 14)                                    )
                        TableItem(text: "Thermic Effect of Activity",
                                  textColor: Color("gray"),
                                  font: .system(size: 14)                                    )
                       
                        
                    }
                }
            }
            .padding()
        }
    }
}

struct TDEEEquationDisplay: View{
    var body: some View{
        ZStack(){
           CardBackground()
            VStack(alignment:.leading) {
                Text("TDEE公式")
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                
                
                KatchEquationTable
                
                termMeaning
                
                checkBMREquation
            }
            .padding()
        }
    }
    
    
    var KatchEquationTable:some View{
        
            HStack{
                VStack(spacing:0){
                    TableItem(text: "周活动量",
                              textColor: Color("white"),
                              backgroundColor: Color("rare_gray"),
                              font: .system(size: 14)
                                )
                    TableItem(text: "Sedantary",
                              textColor: Color("white"),
                              font: .system(size: 14)
                                )
                    TableItem(text: "Light active",
                              textColor: Color("white"),
                              font: .system(size: 14)
                                )
                    TableItem(text: "Moderately active",
                              textColor: Color("white"),
                              font: .system(size: 14)
                                )
                    
                    TableItem(text: "Very active",
                              textColor: Color("white"),
                              font: .system(size: 14)
                                )
                    TableItem(text: "Extra active",
                              textColor: Color("white"),
                              font: .system(size: 14)
                                )
                    
                    
                }
                VStack(spacing:0){
                    TableItem(text: " ", textColor: Color("white"),backgroundColor: Color("rare_gray"),font: .system(size: 14))
                    TableItem(text: "BMR x 1.2",
                              textColor: Color("gray"),
                              font: .system(size: 14)                        )
                    TableItem(text: "BMR x 1.375",
                              textColor: Color("gray"),
                              font: .system(size: 14)                                    )
                    TableItem(text: "BMR x 1.55",
                              textColor: Color("gray"),
                              font: .system(size: 14)                                    )
                    TableItem(text: "BMR x 1.725",
                              textColor: Color("gray"),
                              font: .system(size: 14)                                    )
                    TableItem(text: "BMR x 1.9",
                              textColor: Color("gray"),
                              font: .system(size: 14)                                    )
                   
                    
                }
            }
       
    }
    
    var termMeaning: some View{
        HStack{
            Spacer()
            BMR
            Spacer()
        }
    }
    var BMR: some View{
        Text("BMR")
            .foregroundColor(Color("white"))
            .fontWeight(.bold)
            .font(.footnote)
            +
        Text(" - Basal Metabolic Rate")
            .foregroundColor(Color("gray"))
            .font(.footnote)
    }
    
    var checkBMREquation: some View{
        HStack {
            Spacer()
            Text("点击查看BMR计算公式").underline().foregroundColor(Color("yellow"))
            Spacer()
        }
        .padding(.top)
    }
    
}


struct TDEECalculationPage: View{
    @Environment(\.openURL) var openURL
    
    @Binding var calculatorShown:Bool
    let offset:CGFloat
    @ObservedObject var TDEEModel:TDEECalculationManager = TDEECalculationManager()
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
    
    @State var selectedOption:String = "sedantary"
    static let options = [
        DropdownOption(key: "sedentary", val: "久坐，没啥运动><"),
        DropdownOption(key: "light", val: "轻量，每周运动1-3次"),
        DropdownOption(key: "moderate", val: "中强度，每周运动3-5次"),
        DropdownOption(key: "high", val: "高强度，每周运动6-7次"),
        DropdownOption(key: "extreme", val: "极强，无时无刻都在运动")
    ]
    
    
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
                    activityField
                        .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        
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
    var activityField:some View{
        VStack {
            HStack{
                Text("*").foregroundColor(.red)
                +
                Text("周活动量:").foregroundColor(Color("main_background"))
                Spacer()
                
                DropdownButton(shouldShowDropdown: false, displayText: "久坐，没啥运动><", selectedKey: $selectedOption, options: TDEECalculationPage.options)
                    .foregroundColor(Color("main_background"))
                    .offset(x: 14)
                
            }
            Divider()
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
                Text("  Your BMR is:").foregroundColor(Color("main_background"))
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
                TDEEModel.setBMRModel(gender: gender, age: age, height: height, weight: weight, bodyFat: bodyFat)
                TDEEModel.calculateTDEE(activityLevel: selectedOption)
                result = TDEEModel.TDEEResult
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
            withAnimation(){
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

struct TDEECalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        TDEECalculatorView()
    }
}
