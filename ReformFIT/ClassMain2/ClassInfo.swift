//
//  SwiftUIView.swift
//  ReformFIT
//
//  Created by J on 2021-08-03.
//

import SwiftUI
import Firebase

private struct OffsetPreferenceKey: PreferenceKey{
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat){}
}

struct ClassInfo: View {
    @State var classInfo: Class
    @Binding var rootActive: Bool
    
    @State var screenActive: Bool = true
    
    
    
    @State var scrollViewOverFlow: Bool = false
    
    @State var thresh0: CGFloat = 0
    @State var thresh1: CGFloat = 0
    @State var thresh2: CGFloat = 0
    
    @State var scrollPos: Int = 0
    
    @State var bookActive: Bool = true
    @State var bookingProgress: Bool = false
    @State var cLabel1: String = "立即预约"
    
    
    
    @State var signInDialogActive = false
    @State var signUpDialogActive = false
    @State var agreementDialogActive = false
    
    @State var signupViewModel = SignupViewModel()
    @State var signinViewModel = SigninViewModel()
    
    
    @State var emailLoginn: String = ""
    @State var passwordLoginn: String = ""
    
    @State var emailLogin: String = ""
    @State var passwordLogin: String = ""
    @State var confirmPasswordLogin: String = ""
    @State var lNameLogin: String = ""
    @State var fNameLogin: String = ""
    @State var heightLogin: String = ""
    @State var weightLogin: String = ""
    @State var phoneNumLogin: String = ""
    @State var postalCodeLogin: String = ""
     
    var agreementText = "OUR CONDITION We highly recommend you to consult a qualified physician before engaging in training.You warrant and represent that you are not subject to any illness or condition, which may make the participation of fitness activity dangerous or harmful to you. you agree to disclose to our trainer of any conditions or changes in your health while participating in your training that may affect your ability to exercise safely and with minimal risk or injury. You acknowledge that our trainer cannot provide medical advice. You agree that if you feel dizziness, nauseous, or experience pain or discomfort at any time during training, you will immediately stop  and infom our trainer. DEFAULT if you breach any payment on time, you will be in default and your right to receive classes will be suspended immediately. ReformFIT reserves the right to immediately cancel your"
    
    
    @State var progressActive: Bool = false
    @State var checked: Bool = false
    
    
    
    var signInView: some View{
        ZStack{
            
            if signInDialogActive {
                ModalDialogView(
                    showModal: $signInDialogActive,
                    title: "登陆",
                    cancelText: "Cancel",
                    confirmText:"Confirm",
                    content:
                        VStack {
                            HStack{
                                Text("Email: ")
                                TextField("Enter your email", text: $emailLoginn)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.emailAddress)
                            }
                            HStack{
                                Text("密码: ")
                                SecureField("Enter your password", text: $passwordLoginn)
                                    .multilineTextAlignment(.trailing)
                                
                            }
                            
                            HStack{
                                Spacer()
                                Text("注册新用户")
                                    .underline()
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        signUpDialogActive.toggle()
                                    }
                                Spacer()
                            }

                        },
                    onConfirm:{
                        
                        print("email: \(emailLoginn)")
                        print("password: \(passwordLoginn)")
                        signInDialogActive.toggle()
                        progressActive.toggle()
                        signIn()
                        
                    },
                    onCancel:{
                        
                    }
                )
                .frame(width: UIScreen.main.bounds.width)
            }
                
            
            if signUpDialogActive {
                ModalDialogView(
                    showModal: $signUpDialogActive,
                    title: "新用户注册",
                    cancelText: "Cancel",
                    confirmText:"Confirm",
                    content:
                        VStack {
                            Spacer().frame(height: 10)
                            VStack{
                                HStack{
                                    Text("Email: ")
                                    TextField("Enter your email", text: $emailLogin)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.emailAddress)
                                    
                                        
                                }
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                            }
                            
                            VStack{
                                HStack{
                                    Text("密码:")
                                    SecureField("请设置密码", text: $passwordLogin)
                                        
                                        .multilineTextAlignment(.trailing)
                                    
                                }
                            
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                            }
                            
                            VStack{
                                HStack{
                                    Text("确认密码:")
                                    SecureField("确认密码", text: $confirmPasswordLogin)
                                        
                                        .multilineTextAlignment(.trailing)
                                }
                                    
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                                
                                
                            }
                            VStack{
                                HStack{
                                    Text("Last Name: ")
                                    TextField("请输入姓", text: $lNameLogin)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.namePhonePad)
                                }
                                
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                            }
                            
                            VStack{
                                HStack{
                                    Text("First Name: ")
                                    TextField("请输入名", text: $fNameLogin)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.namePhonePad)
                                }
                                
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                            }
                            VStack{
                            
                                HStack{
                                    Text("身高: ")
                                    TextField("请输入身高", text: $heightLogin)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.decimalPad)
                                }
                                
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                            }
                            
                            VStack{
                                HStack{
                                    Text("体重: ")
                                    TextField("请输入体重", text: $weightLogin)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.decimalPad)
                                }
                                
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                            }
                            
                            VStack{
                                HStack{
                                    Text("电话: ")
                                    TextField("请输入电话", text: $phoneNumLogin)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.phonePad)
                                }
                                
                                Spacer().frame(height: 0)
                                Rectangle()
                                    .stroke()
                                    .frame(height: 0.5)
                                    .foregroundColor(Color("grey"))
                            }
                            VStack{
                                VStack{
                                    HStack{
                                        Text("邮编")
                                        TextField("请输入邮编", text: $postalCodeLogin)
                                            .multilineTextAlignment(.trailing)
                                            .keyboardType(.namePhonePad)
                                    }
                                    
                                    Spacer().frame(height: 0)
                                    Rectangle()
                                        .stroke()
                                        .frame(height: 0.5)
                                        .foregroundColor(Color("grey"))
                                }
                                
                                HStack{
                                    Spacer()
                                    Text("我己阅读并同意相关")
                                    
                                    Text("服务条款")
                                        .underline()
                                        .foregroundColor(.blue)
                                        .onTapGesture {
                                            agreementDialogActive.toggle()
                                            print("toggled")
                                        }
                                    
                                    CheckView(checked: $checked)
                                    
                                    
                                    Spacer()
                                }
                                
                            }

                        }.frame(height: UIScreen.main.bounds.height * 0.4),
                    onConfirm:{
                        
                        
                        if checked{
                            if passwordLogin == confirmPasswordLogin{
                                if passwordLogin.count >= 6{
                                    print("email: \(emailLogin)")
                                    print("password: \(passwordLogin)")
                                    print("confirm password: \(confirmPasswordLogin)")
                                    print("last name: \(lNameLogin)")
                                    print("first name: \(fNameLogin)")
                                    print("height: \(heightLogin)")
                                    print("weight: \(weightLogin)")
                                    print("phone number: \(phoneNumLogin)")
                                    print("postal code: \(postalCodeLogin)")
                                    
                                    
                                    signInDialogActive.toggle()
                                    signUpDialogActive.toggle()
                                    progressActive.toggle()
                                    
                                   signUp()
                                }
                                else{
                                    print("password does not matched")
                                }
                            }
                            else{
                                print("password does not matched")
                            }
                            
                        }
                        else{
                            print("toast message: check to continue")
                        }
                        
                    }
                    ,
                    onCancel:{}
                )
            }
            
            
            if agreementDialogActive {
                
                ModalDialogView(
                    showModal: $agreementDialogActive,
                    title: "Agreement",
                    cancelText: "关闭",
                    confirmText:"发送至邮件",
                    content:
                        ScrollView{
                            Text(agreementText)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(100)
                                
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4),
                    onConfirm:{
                        
                    },
                    onCancel:{}
                )
                .frame(width: UIScreen.main.bounds.width)
            }
            
            if progressActive {
                
                ModalDialogView(
                    showModal: $progressActive,
                    title: "",
                    cancelText: "",
                    confirmText: "",
                    content:
                        ProgressView()
                            .frame(width: 30, height: 30)
                            .background(Color("black"))
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow)),
                    onConfirm:{},
                    onCancel:{}
                )
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
    
    var body: some View {
        
        ZStack{
            VStack{
                TopBar(rootActive: $rootActive, titleText: "万锦试验点")
                
                
                ScrollViewReader{proxy in
                    
                    if scrollViewOverFlow{
                        HStack{
                            Text("场地信息")
                                .foregroundColor(scrollPos == 1 ? Color("white") : Color("grey"))
                                .onTapGesture {
                                    
                                    withAnimation{
                                        proxy.scrollTo("thresh1", anchor: .top)
                                        
                                    }
                                    
                                }
                            Text("注意事项")
                                .foregroundColor(scrollPos == 2 ? Color("white") : Color("grey"))
                                .onTapGesture {
                                    
                                    withAnimation{
                                        proxy.scrollTo("thresh2", anchor: .top)
                                    }
                                
                                    
                                }
                            Spacer()
                        }
                    }
                    
                    
                    GeometryReader{geometry in
                        ScrollView{
                            VStack{
                                
                                TabView(){
                                    Image("wifi")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color("yellow"))
                                    
                                    Image("wifi")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color("yellow"))
                                        
                                    
                                    Image("wifi")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color("yellow"))
                                    
                                        
                                    
                                    Image("wifi")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color("yellow"))
                                    
                                }
                                .tabViewStyle(PageTabViewStyle())
                                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                                
                                
                                GeometryReader{geo in
                                    Text("")
                                        .frame(height: 1)
                                        .onAppear{
                                            thresh0 = geo.frame(in: .named("scroll")).origin.y
                                            
                                    }
                                        
                                }
                                .frame(height: 1)
                                if !scrollViewOverFlow{
                                    HStack{
                                        Text("场地信息")
                                            .foregroundColor(scrollPos == 1 ? Color("white") : Color("grey"))
                                            .onTapGesture {
                                                
                                                withAnimation{
                                                    proxy.scrollTo("thresh1", anchor: .top)
                                                    
                                                }
                                                
                                            }
                                        Text("注意事项")
                                            .foregroundColor(scrollPos == 2 ? Color("white") : Color("grey"))
                                            .onTapGesture {
                                               
                                                withAnimation{
                                                    proxy.scrollTo("thresh2", anchor: .top)
                                                }
                                            
                                                
                                            }
                                        Spacer()
                                    }
                                }
                                
                                VStack{
                                    GeometryReader{geo in
                                        Text("")
                                            .frame(height: 1)
                                            .onAppear{
                                                thresh1 = geo.frame(in: .named("scroll")).origin.y
                                            
                                        }
                                        
                                    }
                                    .frame(height: 1)
                                    
                                    
                                    CHeaderView(classInfoEx: $classInfo)
                                        .id("thresh1")
                                            
                                            
                                    CIntroView(classInfoEx: $classInfo)
                                            
                                    CEffectView()
                                    
                                    CHeartRateView()
                                    
                                    CClientView()
                                    
                                    GeometryReader{geo in
                                        Text("")
                                            .frame(height: 1)
                                            .onAppear{
                                                thresh2 = geo.frame(in: .named("scroll")).origin.y
                                                
                                        }
                                            
                                    }
                                    .frame(height: 1)
                                    
                                    CStepView()
                                        .id("thresh2")
                                    
                                    CFaqView()
                                    
                                    VStack{
                                        CWarningView()
                                
                                            
                                        CMoreServiceView()
                                    }
                                        
                                }
                                Spacer().frame(height: 30)
                                Spacer()
                                
                            
                            }
                                .background(GeometryReader {
                                    Color.clear.preference(key: OffsetPreferenceKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                                })
                                .onPreferenceChange(OffsetPreferenceKey.self){value in
                                    print("\(value)--thresh 0: \(thresh0+4)--thresh 2: \(thresh2 - 25)")
                                    //print("thresh 1: \(threshView1)")
                                    
                                    if value < (thresh0+4){
                                        scrollPos = 0
                                    }
                                    else if value > (thresh0+4) && value < (thresh2-25) {
                                        scrollPos = 1
                                    }
                                    else if value > (thresh2-25) {
                                        scrollPos = 2
                                    }
                                    
                                    
                                    if value <= (thresh0+4) {
                                        scrollViewOverFlow = false
                                    }
                                    else{
                                        scrollViewOverFlow = true
                                    }
                                    
                            
                            
                                }
                        }
                        
                        .overlay(
                            HStack(alignment: .bottom, spacing: 0, content: {
                                
                                Text("免费体验")
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("yellow"))
                                Text("购买课包")
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("yellow"))
                                Text(cLabel1)
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("yellow"))
                                //if bookActive{
                                    .onTapGesture {
                                        bookStart()
                                    //}
                                }
                                    .allowsHitTesting(bookActive)
                                    .onAppear {
                                        print("classInfo.over: \(classInfo.over)")
                                        print("classInfo.lateCancel: \(String(describing: classInfo.lateCancel))")
                                        if classInfo.over || (classInfo.lateCancel ?? false){
                                            cLabel1 = "Over"
                                            bookActive = false
                                        }
                                        
                                        else if classInfo.isCancel ?? false{
                                            cLabel1 = "Canceled"
                                            bookActive = false
                                            
                                        }
                                        
                                        else if(classInfo.totalBooked == classInfo.maxCapacity && !(classInfo.isWaitlistAvailable ?? false)){
                                            cLabel1 = "Full"
                                            bookActive = false
                                            
                                        }
                                        else {
                                            cLabel1 = "立即预约"
                                        }
                                    }
                            })
                        , alignment: .bottom)
                        
                           
                    
                        
                    }
                    .coordinateSpace(name: "scroll")
                        
                        
                    
                
                    
                }
        
            
            
                Text("")
            }
            
            .background(Color("black"))
            .navigationTitle("")
            .navigationBarHidden(true)
            .statusBar(hidden: true)
            .navigationBarBackButtonHidden(true)
                
            
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("black"))
                .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                .opacity(!screenActive ? 1 : 0)
            
            
            ProgressView()
                
                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.6)
                .background(Color("black"))
                .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                .opacity(bookingProgress ? 1 : 0)
            
            
            
            signInView

            
        }
        
    }
}

extension ClassInfo{
    
    func bookStart() -> Void{
        if globalVariable.logIn {
            
        
            if classInfo.totalBooked == classInfo.maxCapacity && (classInfo.isWaitlistAvailable ?? false){
                
                cLabel1 = "Add to waitlist"
                
                
                if globalVariable.logIn{
                    
                    bookingProgress = true
                    
                    let addClientViewModel: AddClientViewModel = AddClientViewModel(clientId: globalVariable.clientId ?? "", classId: "\(String(describing: (classInfo.classId)!))" )
                    
                    addClientViewModel.addClientToWaitlist{
                        if !addClientViewModel.loading{
                            bookingProgress = false
                        }
                    }
                    
                    
                }
                
            }
            else{
                
                bookingProgress = true
                    
                let addClientViewModel: AddClientViewModel = AddClientViewModel(clientId: globalVariable.clientId ?? "", classId: "\(String(describing: (classInfo.classId)!))" )
                    
                addClientViewModel.addClientToClass {
                    if !addClientViewModel.loading{
                        bookingProgress = false
                    }
                    
                    
                    
                }
                
                
            }
        }
        else{
            signInDialogActive.toggle()
        }
        
    }
    
    
        
        
}

extension ClassInfo{
    
    
    func signInMindbody() -> Void{
        
        signinViewModel.getToken {
            
            let clientEx = globalVariable.client
            print("BirthDate: \(String(describing: clientEx?.BirthDate))")
            print("Country: \(String(describing: clientEx?.Country))")
            print("CreationDate \(String(describing: clientEx?.CreationDate))")
            print("FirstName \(String(describing: clientEx?.FirstName))")
            print("Id    \(String(describing: clientEx?.Id))")
            print("LastName  \(String(describing: clientEx?.LastName))")
            print("UniqueId   \(String(describing: clientEx?.UniqueId))")
            print("Email    \(String(describing: clientEx?.Email))")
            print("MobilePhone:  \(String(describing: clientEx?.MobilePhone))")
            print("AddressLine1:   \(String(describing: clientEx?.AddressLine1))")
            print("AddressLine2:   \(String(describing: clientEx?.AddressLine2))")
            print("City:    \(String(describing: clientEx?.City))")
            print("PostalCode:   \(String(describing: clientEx?.PostalCode))")
            print("Phote:  \(String(describing: clientEx?.PhotoUrl))")
            print("Gender:  \(String(describing: clientEx?.Gender))")
            print("CustomClientFields1: \(String(describing: clientEx?.CustomClientFields![0].Name)) ")
            print("CustomClientFields2: \(String(describing: clientEx?.CustomClientFields![1].Name)) ")
            print("CustomClientFields3: \(String(describing: clientEx?.CustomClientFields![2].Name)) ")
            print("CustomClientFields4: \(String(describing: clientEx?.CustomClientFields![3].Name)) ")
            print("height:   \(String(describing: clientEx?.height))")
            print("weight: \(String(describing: clientEx?.weight))")
            print("wristBandBrand:  \(String(describing: clientEx?.wristBandBrand))")
            print("wristBandNum:    \(String(describing: clientEx?.wristBandNum))")
            
            
            globalVariable.client = clientEx
            globalVariable.logIn = true
            globalVariable.clientId = clientEx?.Id ?? ""
            
            
            
            refresh()
            
            withAnimation(.easeOut(duration: 0.1)){
                progressActive.toggle()
            }
        }
        onError: {message in
            print(message)
            
            
        }
        
        
    }
    
    func signUp() -> Void {
        let auth = Auth.auth()
        auth.createUser(withEmail: emailLogin, password: passwordLogin){authResult, error in
            
            guard authResult != nil, error == nil else{
                print("Something wrong, try again later")
                print(error ?? "")
                return
            }
            
            let userId = auth.currentUser?.uid
            let db = Firestore.firestore()
            
            let documentReference = db.collection("clientId").document(userId ?? "")
            
            
            signupViewModel.initalize(email: emailLogin, height: heightLogin, weight: weightLogin, fName: fNameLogin, lName: lNameLogin, phoneNum: phoneNumLogin, postalCode: postalCodeLogin)
            
            signupViewModel.getToken {
                let clientEx = globalVariable.client
                
                print("BirthDate: \(String(describing: clientEx?.BirthDate))")
                print("Country: \(String(describing: clientEx?.Country))")
                print("CreationDate \(String(describing: clientEx?.CreationDate))")
                print("FirstName \(String(describing: clientEx?.FirstName))")
                print("Id    \(String(describing: clientEx?.Id))")
                print("LastName  \(String(describing: clientEx?.LastName))")
                print("UniqueId   \(String(describing: clientEx?.UniqueId))")
                print("Email    \(String(describing: clientEx?.Email))")
                print("MobilePhone:  \(String(describing: clientEx?.MobilePhone))")
                print("AddressLine1:   \(String(describing: clientEx?.AddressLine1))")
                print("AddressLine2:   \(String(describing: clientEx?.AddressLine2))")
                print("City:    \(String(describing: clientEx?.City))")
                print("PostalCode:   \(String(describing: clientEx?.PostalCode))")
                print("Phote:  \(String(describing: clientEx?.PhotoUrl))")
                print("Gender:  \(String(describing: clientEx?.Gender))")
                print("CustomClientFields1: \(String(describing: clientEx?.CustomClientFields![0].Name)) ")
                print("CustomClientFields2: \(String(describing: clientEx?.CustomClientFields![1].Name)) ")
                print("CustomClientFields3: \(String(describing: clientEx?.CustomClientFields![2].Name)) ")
                print("CustomClientFields4: \(String(describing: clientEx?.CustomClientFields![3].Name)) ")
                print("height:   \(String(describing: clientEx?.height))")
                print("weight: \(String(describing: clientEx?.weight))")
                print("wristBandBrand:  \(String(describing: clientEx?.wristBandBrand))")
                print("wristBandNum:    \(String(describing: clientEx?.wristBandNum))")
                
                let clientId = clientEx?.Id ?? ""
                globalVariable.clientId = clientId
                globalVariable.client = clientEx
                globalVariable.logIn = true
                
                
                documentReference.setData(["ClientId": clientId])
                
                
                refresh()
                
                withAnimation(.easeOut(duration: 0.1)){
                    progressActive.toggle()
                }
               
            }onError: {message in
                print(message)
                print("Something wrong, try again later")
                
                let user = auth.currentUser
                user?.delete(completion: { error in
                    guard error == nil else {
                        print("firebase deleted")
                        return
                    }
                })
                
            }
            
        
            
        }
    }
    
    func signIn() -> Void{
        
        
        let auth = Auth.auth()
        auth.signIn(withEmail: emailLoginn, password: passwordLoginn){authResult, error in
         
            
            guard authResult != nil, error == nil else {
                print("Authentication failed")
                
                return
            }
            
            
            let userId = auth.currentUser?.uid
            
            let firebaseFirestore = Firestore.firestore()
            let docRef = firebaseFirestore.collection("clientId").document(userId ?? "")
            
            docRef.getDocument(){(document, err) in
                if let document = document{
                    
                    let clientId = document.data()!["ClientId"]!
                    print("clientId: \(clientId)")
                    
                    globalVariable.clientId = clientId as! String
                    
                    signInMindbody()                }
                else{
                    print("Something wrong, try again later")
                }
                
            
            }
        }
    }
    
    func refresh() -> Void{
        print("classInfo.over: \(classInfo.over)")
        print("classInfo.lateCancel: \(String(describing: classInfo.lateCancel))")
        if classInfo.over || (classInfo.lateCancel ?? false){
            cLabel1 = "Over"
            bookActive = false
        }
        
        else if classInfo.isCancel ?? false{
            cLabel1 = "Canceled"
            bookActive = false
            
        }
        
        else if(classInfo.totalBooked == classInfo.maxCapacity && !(classInfo.isWaitlistAvailable ?? false)){
            cLabel1 = "Full"
            bookActive = false
            
        }
        else {
            cLabel1 = "立即预约"
        }
    }
}


struct CHeaderView: View{
    
    
    @Binding var classInfoEx: Class
    
    var body: some View{
        
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "Fat Shredder", titleText: classInfoEx.className ?? "")
                
                
                
                HStack{
                        
                    if classInfoEx.staff?.staffImage != nil {
                        
                        AsyncImage(url: URL(string: (classInfoEx.staff?.staffImage)!)!,
                                       placeholder: { ProgressView() },
                                       image: { Image(uiImage: $0).resizable()
                                        })
                            .frame(width: 70, height: 70, alignment: .center)
                            .clipShape(Circle())
                    }
                    else{
                        
                        Text("loading")
                            .frame(width: 70, height: 70, alignment: .center)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                    VStack{
                        Text(classInfoEx.staff?.staffName ?? "")
                            .foregroundColor(Color("white"))
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                       
                }
                
                
                
                HStack{
                    
                    Image("时间")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                    
                    Text("时间:")
                        .foregroundColor(Color("white"))
                    
                    Spacer().frame(width: 3)
                    
                    Text(classInfoEx.startDate + classInfoEx.startTime + "-" + classInfoEx.endTime)
                        .foregroundColor(Color("grey"))
                    
                }
                
                Image("wifi")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width*0.84, height: 200)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color("yellow"))
                
                
                HStack{
                    
                    
                    Image("地图")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                    Text("地点")
                        .foregroundColor(Color("white"))
                    
                    Text(classInfoEx.location?.address ?? "")
                        .foregroundColor(Color("grey"))
                    Spacer()
                    
                }
                
                
                HStack{
                    Spacer()
                    Text("查看地图")
                        .underline()
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            let urlO = URL(string: "http://maps.apple.com/?q=ReformFit")
                            print(urlO)
                            if(UIApplication.shared.canOpenURL(urlO!)){
                                UIApplication.shared.open(urlO!, options: [:], completionHandler: nil)
                            }
                        }
                }
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
    
}
struct CIntroView: View{
    
    
    @Binding var classInfoEx: Class
    
    @State var limitActive: Bool = false
    var body: some View{
        
        
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "课程介绍", titleText: "课程介绍")
                HStack{
                    Text(classInfoEx.classDes ?? "")
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}

struct CEffectView: View{
    
    @State var limitActive: Bool = false
    var body: some View{
        
        
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "课程效果", titleText: "课程效果")
                
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
                
                HStack{
                    Spacer()
                    ForEach(0..<effectGrid.count){ row in
                            
                            VStack{
                                Image(effectGrid[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(effectGrid[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}


struct CHeartRateView: View{
    
    @State var limitActive: Bool = false
    var body:some View{
        ZStack{
            VStack{
                
                CardViewTitleBar(iconText: "心率监测", titleText: "心率监测")
                
                
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
                
                
                HeartRateEx(imageText: "Zone 1", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 2", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 3", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 4", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                HeartRateEx(imageText: "Zone 5", text1: "51-60%", text2: "热身｜训练恢复", text3: "低强度")
                
                
                
                
                
                Text("链接")
                    .underline()
                    .foregroundColor(Color("yellow"))
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}

struct HeartRateEx: View{
    var imageText: String
    var text1: String
    var text2: String
    var text3: String
    
    var body: some View{
        HStack{
            
            Image(imageText)
                .resizable()
                .frame(width: 15, height: 15)
            
            Text(text1)
                .foregroundColor(Color("grey"))
            
            Spacer().frame(width: 5)
            
            Text(text2)
                .foregroundColor(Color("white"))
            
            Spacer().frame(width: 5)
            
            
            Text(text3)
                .foregroundColor(Color("white"))
                .background(RoundedCorner(radius: 5, corners: [.allCorners]).fill(Color("grey")))
            
                
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(RoundedCorner(radius: 12, corners: [.allCorners]).stroke(lineWidth: 2).fill(Color("grey")))
        
        
    }
}

struct CClientView: View{
    var body:some View{
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "适合人群", titleText: "适合人群")
                
                HStack{
                    Spacer()
                    ForEach(0..<lMoreServiceGrid.count){ row in
                            
                            VStack{
                                Image(lMoreServiceGrid[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(lMoreServiceGrid[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
                
                
                
                
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}


struct CStepView: View{
    var body: some View{
        ZStack{
            VStack{
                
                
                CardViewTitleBar(iconText: "上课步骤", titleText: "健身步骤")
                
                CStepElementView(stepNum: "1", stepContent: "联系客服领取免费体验")
                
                
                CStepElementView(stepNum: "2", stepContent: "购买课包或加入会员")
                
                
                CStepElementView(stepNum: "3", stepContent: "预约正式上课时间")
                
                
                CStepElementView(stepNum: "4", stepContent: "到店入场上课")
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}

struct CStepElementView: View{
    
    var stepNum: String
    var stepContent: String
    
    
    var body: some View{
        ZStack{
            HStack{
                Spacer().frame(width: 3)
                Text(stepNum)
                    .padding(5)
                    .foregroundColor(Color("yellow"))
                    .background(Circle().stroke(Color("yellow"), lineWidth: 1))
                
                Spacer()
                
                
            }
            .padding(2)
            
            HStack(alignment: .center, spacing: 0, content: {
                    Spacer()
                    
                
                    Text(stepContent)
                        .foregroundColor(Color("white"))
                    
                    if(stepNum == "1"){
                        Text("新人专享")
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .foregroundColor(Color("yellow"))
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color("yellow"), lineWidth: 1))
                       
                    }
                    
                    Spacer()
            })
            .padding(2)
            
        }
        .background(Color("black4"))
        .cornerRadius(10)
    }
}





struct CFaqView: View{
   
        
    @State var limitActive: Bool = false
    var body: some View{
        
        
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "FAQ", titleText: "FAQ")
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}
struct CWarningView: View{
   
        
    @State var limitActive: Bool = false
    var body: some View{
        
        
        ZStack{
            
            VStack{
                
                CardViewTitleBar(iconText: "注意事项", titleText: "注意事项")
                Text(descText)
                    .foregroundColor(Color("grey"))
                    .lineLimit(!limitActive ? 3 : 100)
                    .onTapGesture {
                        limitActive.toggle()
                    }
                
                HStack{
                    Spacer()
                    Image("向下箭头")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("yellow"))
                        .onTapGesture {
                            limitActive.toggle()
                        }

                    Spacer()
                }
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
        
        
    }
}

struct CMoreServiceView: View{
    
    
    
    var body: some View{
        
        
        ZStack{
            VStack{
                CardViewTitleBar(iconText: "更多服务", titleText: "更多服务")
                
                HStack{
                    Spacer()
                    ForEach(0..<lMoreServiceGrid.count){ row in
                            
                            VStack{
                                Image(lMoreServiceGrid[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(lMoreServiceGrid[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
                
                
                
                
                
            }
            .padding()
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}




struct ClassInfo_Previews: PreviewProvider {
    
    @State static var classEx: Class = load("classInfoEx.json")
    @State static var rootActive: Bool = false
    static var previews: some View {
        ClassInfo(classInfo: classEx, rootActive: $rootActive)
    }
}



func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}



var cIntroText:String = ""

var descText: String = "律给商支任品老步白治观领打，革提给各自立2下南合整。 情为后种真意话情，压我队目所料百算，这详算转根明。 持验下者改易时，问专音放定候儿，计B严按该。 放这专教百本下称活龙调叫定，使科马物书也多要各备头，月京相陕白身任物列围结。 派所取何本己今时应素，部海广同拉单场回四，细维N青压U低习。 物很也维列快号机他听所已分至，位况需将进极式利识伯但"


var effectGrid: [[String]] = [["燃烧脂肪","燃烧脂肪"],["锻炼心肺","锻炼心肺"], ["后燃效应","后燃效应"],["Muscle_Tone","健康配餐"]]




