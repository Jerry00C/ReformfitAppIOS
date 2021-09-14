//
//  MineMain.swift
//  ReformFIT
//
//  Created by J on 2021-07-27.
//

import SwiftUI
import Firebase


struct MineMain: View {
    
    @State private var rootActive = false
    @State var selectedPage: Int = 1
    
    @State var index = 1
    @State var offset : CGFloat = 0
    
    @State var signInDialogActive = false
    @State var signUpDialogActive = false
    @State var agreementDialogActive = false
    
    @State var signupViewModel = SignupViewModel()
    @State var signinViewModel = SigninViewModel()
    
    
    @State var emailLogin: String = ""
    @State var passwordLogin: String = ""
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var lName: String = ""
    @State var fName: String = ""
    @State var height: String = ""
    @State var weight: String = ""
    @State var phoneNum: String = ""
    @State var postalCode: String = ""
    
    var agreementText = "OUR CONDITION We highly recommend you to consult a qualified physician before engaging in training.You warrant and represent that you are not subject to any illness or condition, which may make the participation of fitness activity dangerous or harmful to you. you agree to disclose to our trainer of any conditions or changes in your health while participating in your training that may affect your ability to exercise safely and with minimal risk or injury. You acknowledge that our trainer cannot provide medical advice. You agree that if you feel dizziness, nauseous, or experience pain or discomfort at any time during training, you will immediately stop  and infom our trainer. DEFAULT if you breach any payment on time, you will be in default and your right to receive classes will be suspended immediately. ReformFIT reserves the right to immediately cancel your"
    
    
    @State var loginText: String =  globalVariable.logIn ? (globalVariable.client?.FirstName ?? "" + " " +  (globalVariable.client?.LastName ?? "")) : "Log In"
    @State var refreshing: Bool = false
    @State var progressActive: Bool = false
    
    @State var checked: Bool = false
    
    
    
    @State var wristBandBrand: String = globalVariable.logIn ? (globalVariable.client?.wristBandBrand ?? "") : ""
    
    @State var wristBandNum: String = globalVariable.logIn ? (globalVariable.client?.wristBandNum ?? "") : ""
    
    
    
    
    @State var refreshingHistoryViewModel = RefreshingHistoryViewModel()
    
    @State var refreshingProgressViewModel = RefreshingProgressViewModel()
    
    @State var classInfoHistory: [Class] = []
    
    @State var classInfoProgress: [Class] = []
    
    
    @State var screenActiveMine3: Bool = true
    @State var stoppedOnce = false
    
    //@State var mineMain1: MineMain1
    //@State var mineMain3: MineMain3
    
    @Binding var bottomView: Bool
    
    
    var body: some View {
            ZStack{
                VStack{
                    Color.black.opacity(0.5)
                        .frame(height: 30)
                    
                    
                    
                    HStack{
                        Spacer().frame(width: 15)
                        
                        Image("wifi")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                            .foregroundColor(Color("yellow"))
                          
                                
                        Spacer().frame(width: 30)
                        VStack{
                            HStack{
                                Text(loginText)
                                    .foregroundColor(Color("yellow"))
                                    .font(.title2)
                                    .onTapGesture {
                                        
                                        if !globalVariable.logIn{
                                            signInDialogActive = true
                                        }
                                            
                                    }
                                Spacer()
                            }
                            HStack{
                                Text("Welcome Back")
                                    .foregroundColor(Color("white"))
                                Spacer()
                            }
                            
                        }
                        Spacer()
                        
                       
                            
                        VStack{
                            NavigationLink(destination: ProfilePage(rootActive: $rootActive), isActive: $rootActive){
                                
                                Image("场地设施")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color("yellow"))
                            }
                            
                        
                    }
                        Spacer().frame(width: 20, height: 0)
                    }
                    
                    VStack {
                        TabBars2(index:self.$index, offset: self.$offset, signInDialogActive: $signInDialogActive)
                         GeometryReader{ g in
                             HStack(alignment: .top, spacing:0){
                                                     
                             // this is where u put the main views under the tab bar
                                 
                                MineMain1(wristBandBrand: $wristBandBrand, wristBandNum: $wristBandNum)
                                     .frame(width: g.frame(in: .global).width)
                                 
                                 Text("MineMainTab2")
                                     .frame(width: g.frame(in: .global).width)
                                 
                                    
                                MineMain3(stoppedOnce: $stoppedOnce, screenActive: $screenActiveMine3,refreshingHistoryViewModel: $refreshingHistoryViewModel, refreshingProgressViewModel: $refreshingProgressViewModel, classInfoHistory: $classInfoHistory, classInfoProgress: $classInfoProgress, rootActive: $rootActive, bottomView: $bottomView)
                                     .frame(width: g.frame(in: .global).width)
                                     
                                 
                             }
                         .offset(x: self.offset)
                         }
                                             
                     }
                     .animation(.default)
                    
                    
                       
                    
                    
                }
                .background(Color("black"))
                
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
                                    TextField("Enter your email", text: $emailLogin)
                                        .multilineTextAlignment(.trailing)
                                        .keyboardType(.emailAddress)
                                }
                                HStack{
                                    Text("密码: ")
                                    SecureField("Enter your password", text: $passwordLogin)
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
                            
                            print("email: \(emailLogin)")
                            print("password: \(passwordLogin)")
                            signInDialogActive.toggle()
                            progressActive.toggle()
                            signIn()
                            
                        },
                        onCancel:{
                            self.index = 1
                            self.offset = 0
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
                                        TextField("Enter your email", text: $email)
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
                                        SecureField("请设置密码", text: $password)
                                            
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
                                        SecureField("确认密码", text: $confirmPassword)
                                            
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
                                        TextField("请输入姓", text: $lName)
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
                                        TextField("请输入名", text: $fName)
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
                                        TextField("请输入身高", text: $height)
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
                                        TextField("请输入体重", text: $weight)
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
                                        TextField("请输入电话", text: $phoneNum)
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
                                            TextField("请输入邮编", text: $postalCode)
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
                                if password == confirmPassword{
                                    if password.count >= 6{
                                        print("email: \(email)")
                                        print("password: \(password)")
                                        print("confirm password: \(confirmPassword)")
                                        print("last name: \(lName)")
                                        print("first name: \(fName)")
                                        print("height: \(height)")
                                        print("weight: \(weight)")
                                        print("phone number: \(phoneNum)")
                                        print("postal code: \(postalCode)")
                                        
                                        
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
}

extension MineMain{
    
    
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
            
            
            loginText = globalVariable.client?.FirstName ?? "" + " " +  (globalVariable.client?.LastName ?? "")
        
            
            refresh()
            
            withAnimation(.easeOut(duration: 0.1)){
                progressActive.toggle()
            }
        }
        onError: {message in
            print(message)
            
            withAnimation(.easeOut(duration: 0.1)){
                self.index = 1
                self.offset = 0
                withAnimation(.easeOut(duration: 0.1)){
                    progressActive.toggle()
                }
            }
        }
        
        
    }
    
    
    
    func signUp() -> Void {
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password){authResult, error in
            
            guard authResult != nil, error == nil else{
                print("Something wrong, try again later")
                print(error ?? "")
                return
            }
            
            let userId = auth.currentUser?.uid
            let db = Firestore.firestore()
            
            let documentReference = db.collection("clientId").document(userId ?? "")
            
            
            signupViewModel.initalize(email: email, height: height, weight: weight, fName: fName, lName: lName, phoneNum: phoneNum, postalCode: postalCode)
            
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
                
                
                loginText = globalVariable.client?.FirstName ?? "" + " " +  (globalVariable.client?.LastName ?? "")
            
                
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
                
                withAnimation(.easeOut(duration: 0.1)){
                    self.index = 1
                    self.offset = 0
                    withAnimation(.easeOut(duration: 0.1)){
                        progressActive.toggle()
                    }
                }
            }
            
        
            
        }
    }
    
    func signIn() -> Void{
        
        
        let auth = Auth.auth()
        auth.signIn(withEmail: emailLogin, password: passwordLogin){authResult, error in
         
            
            guard authResult != nil, error == nil else {
                print("Authentication failed")
                self.index = 1
                self.offset = 0
                withAnimation(.easeOut(duration: 0.1)){
                    progressActive.toggle()
                }
                return
            }
            
            
            let userId = auth.currentUser?.uid
            
            let firebaseFirestore = Firestore.firestore()
            let docRef = firebaseFirestore.collection("clientId").document(userId ?? "")
            
            docRef.getDocument(){(document, err) in
                if let document = document{
                    
                    let clientId = document.data()!["ClientId"]!
                    print("clientId: \(clientId)")
                    
                    globalVariable.clientId = clientId as? String
                    
                    signInMindbody()
                }
                else{
                    print("Something wrong, try again later")
                    self.index = 1
                    self.offset = 0
                    withAnimation(.easeOut(duration: 0.1)){
                        progressActive.toggle()
                    }
                }
                
            
            }
        }
    }
    
    func refresh() -> Void{
        
        loginText =  globalVariable.client?.FirstName ?? "" + " " +  (globalVariable.client?.LastName ?? "")
        wristBandBrand = globalVariable.client?.wristBandBrand ?? ""
        
        
        wristBandNum = globalVariable.client?.wristBandNum ?? ""
        
        //mineMain1.refreshing()
        //mineMain2.refreshing()
        //mineMain3.refreshing()
        screenActiveMine3.toggle()
        fetchData(){
            
            
            self.classInfoHistory = refreshingHistoryViewModel.classInfoResponse
                
            print("history count after \(classInfoHistory.count)")
        }
    }
}

extension MineMain{
    
    func fetchData(onCompletion:@escaping()->Void) -> Void{
        print("fetching")
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let auth = Auth.auth()
        let date = auth.currentUser?.metadata.creationDate ?? Date()
        let startDate = formatter.string(from: date)
        
        
        
        let date2 = Date()
        let endDate = formatter.string(from: date2)
        
        let date3 = Calendar.current.date(byAdding: .month, value: 12, to: date2) ?? Date()
        let endDate2 = formatter.string(from: date3)
        
        
        print("Start date:  \(startDate)")
        print("end date:   \(endDate)")
        print("end date 2:   \(endDate2)")
        
        
        
        refreshingHistory(startDate: startDate, endDate: endDate){
            if !stoppedOnce {
                stoppedOnce = true
            }
            else{
                screenActiveMine3.toggle()
                stoppedOnce = false
                onCompletion()
            }
        }
        
        
        refreshingProgressing(startDate: endDate, endDate: endDate2){
            
            
            
            if !stoppedOnce {
                stoppedOnce = true
            }
            else{
                screenActiveMine3.toggle()
                stoppedOnce = false
                onCompletion()
            }
        }
        
       
        

    }
    
    func refreshingHistory(startDate: String, endDate: String, onCompletion:@escaping()->Void) -> Void{
        
        
        print("refreshingHistory")
        self.refreshingHistoryViewModel.initialize(startDate: startDate, endDate: endDate, limited: true)
        
        self.refreshingHistoryViewModel.getToken {
            if !refreshingHistoryViewModel.loading{
                print("history count \(refreshingHistoryViewModel.classInfoResponse.count)")
                onCompletion()
            }
        }
       
   }
    
    
    func refreshingProgressing(startDate: String, endDate: String, onCompletion:@escaping()->Void) -> Void{
       
        print("refreshingProgressing")
        self.refreshingProgressViewModel.initialize(startDate: startDate, endDate: endDate, limited: true)
        
        self.refreshingProgressViewModel.getToken {
            
            if !refreshingProgressViewModel.loading{
                print("progress count \(refreshingProgressViewModel.classInfoResponse.count)")
                self.classInfoProgress = refreshingProgressViewModel.classInfoResponse
                
                print("progress classInfoResponse  \(refreshingProgressViewModel.classInfoResponse)")
                
                print("progress  self.classInfoProgress  \( self.classInfoProgress)")
                print("progress count after \(classInfoProgress.count)")
                onCompletion()
            }
        }
       
       
   }
}

struct TabBars2: View {
    @Binding var index: Int
    @Binding var offset : CGFloat
    @Binding var signInDialogActive: Bool
    var tabsCount = 3
    var width = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack (spacing:0){
            HStack(alignment: .center){
                Spacer()
                
                Text("Tab 1")
                    .foregroundColor(self.index == 1 ? Color("white") : Color("grey"))
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .onTapGesture {
                        self.index = 1
                        self.offset = 0
                        
                        
                    }
              
                
                Spacer()
                
                Text("Tab 2")
                    .foregroundColor(self.index == 2 ? Color("white") : Color("grey"))
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .onTapGesture {
                        self.index = 2
                        self.offset = -self.width
                        
                        if !globalVariable.logIn{
                            signInDialogActive = true
                                
                        }
                    }
                    
                
                Spacer()
                
                Text("Tab 3")
                    .foregroundColor(self.index == 3 ? Color("white") : Color("grey"))
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .onTapGesture {
                        self.index = 3
                        self.offset = -self.width*2
                        
                        if !globalVariable.logIn{
                            signInDialogActive = true
                                
                        }
                            
                    }
                    
                Spacer()
                
            }
            
            
            GeometryReader{ g in
                Capsule()
                    .fill(Color("yellow"))
                    .frame(width: self.tabWidth(from: g.size.width)-50, height: 4, alignment: .center)
                    .offset(x: self.selectionBarXOffset(from: g.size.width)+28, y: 2)
                
                
            }.frame(height: 4)
        }
    }
    
    private func selectionBarXOffset(from totalWidth: CGFloat)->CGFloat{
        return self.tabWidth(from: totalWidth) * CGFloat(index-1)
    }
    private func tabWidth(from totalWidth: CGFloat)-> CGFloat{
        return totalWidth/CGFloat(tabsCount)
    }
}


struct MineMain_Previews: PreviewProvider{
    
    
    @State static var fab: Bool = false
    
    
    static var previews: some View {
        MineMain(bottomView: $fab)
    }
}
