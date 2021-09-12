//
//  ProfilePage.swift
//  ReformFIT
//
//  Created by J on 2021-08-04.
//

import SwiftUI
import Firebase

struct ProfilePage: View {
    
    @Binding var rootActive: Bool
    
    
    @State var phoneNum: String = globalVariable.logIn ? (globalVariable.client?.MobilePhone ?? "") : ""
    @State var phoneNumEnteredValue: String = ""
    @State var phoneNumDialogActive: Bool = false
    @State var phoneNumLoadingActive = false
    @State var phoneNumViewModel = PhoneNumViewModel()
    


    @State var gender: String = globalVariable.logIn ? (globalVariable.client?.Gender ?? "") : ""
    @State var genderEnteredValue: String = ""
    @State var genderDialogActive: Bool = false
    @State var genderLoadingActive = false
    @State var genderViewModel = GenderViewModel()



    @State var birthDate: String = globalVariable.logIn ? (globalVariable.client?.BirthDate ?? "") : ""
    @State var birthDateEnteredValue: String = ""
    @State var birthDateDialogActive: Bool = false
    @State var birthDateLoadingActive = false
    @State var birthDateViewModel = BirthDateViewModel()



    @State var height: String = globalVariable.logIn ? (globalVariable.client?.height ?? "") : ""
    @State var heightEnteredValue: String = ""
    @State var heightDialogActive: Bool = false
    @State var heightLoadingActive = false
    @State var heightViewModel = HeightViewModel()



    @State var weight: String = globalVariable.logIn ? (globalVariable.client?.weight ?? "") : ""
    @State var weightEnteredValue: String = ""
    @State var weightDialogActive: Bool = false
    @State var weightLoadingActive = false
    @State var weightViewModel = WeightViewModel()



    @State var postalCode: String = globalVariable.logIn ? (globalVariable.client?.PostalCode ?? "") : ""
    @State var postalCodeEnteredValue: String = ""
    @State var postalCodeDialogActive: Bool = false
    @State var postalCodeLoadingActive = false
    @State var postalCodeViewModel = PostalCodeViewModel()


    
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
    
    @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var bodyInfo: some View{
        VStack{
            VStack{
                HStack{
                    Text("Email:")
                        .foregroundColor(Color("white"))
                    Spacer()
                    
                    Text(globalVariable.client?.Email ?? "")
                        .foregroundColor(Color("white"))
                }
                Spacer().frame(height: 15)
            }
            
            VStack{
            
                HStack{
                    Text("电话:")
                        .foregroundColor(Color("white"))
                    Spacer()
                    
                    if phoneNumLoadingActive{
                        ProgressView()
                            .frame(width: 15, height: 15)
                            .background(Color("black"))
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                    }
                    
                    
                    if phoneNum == "" {
                        Image("向下箭头")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color("yellow"))
                            .onTapGesture {
                                phoneNumDialogActive = true
                            }
                    }
                        
                    if phoneNum != "" {
                        Text(phoneNum)
                            .foregroundColor(Color("white"))
                            .opacity(phoneNum == "" ? 0 : 1)
                            .onTapGesture {
                                phoneNumDialogActive = true
                            }
                    }
                    
                    
                    
                }
                Spacer().frame(height: 15)
            }
            
            VStack{
                HStack{
                    Text("性别:")
                        .foregroundColor(Color("white"))
                    Spacer()
                    ProgressView()
                        .frame(width: 15, height: 15)
                        .background(Color("black"))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                        .opacity(genderLoadingActive ? 1 : 0)

                    Text(gender)
                        .foregroundColor(Color("white"))
                        .opacity(gender == "" ? 0 : 1)
                        .onTapGesture {
                            genderDialogActive = true
                        }

                    Image("向下箭头")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color("yellow"))
                        .opacity(gender == "" ? 1 : 0)
                        .onTapGesture {
                            genderDialogActive = true
                        }


                }
                Spacer().frame(height: 15)
            }

            VStack{

                HStack{
                    Text("出生年月日:")
                        .foregroundColor(Color("white"))
                    Spacer()
                    ProgressView()
                        .frame(width: 15, height: 15)
                        .background(Color("black"))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                        .opacity(birthDateLoadingActive ? 1 : 0)

                    Text(birthDate)
                        .foregroundColor(Color("white"))
                        .opacity(birthDate == "" ? 0 : 1)
                        .onTapGesture {
                            birthDateDialogActive = true
                        }

                    Image("向下箭头")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color("yellow"))
                        .opacity(birthDate == "" ? 1 : 0)
                        .onTapGesture {
                            birthDateDialogActive = true
                        }


                }
                Spacer().frame(height: 15)
            }

            VStack{
                HStack{
                    Text("身高:")
                        .foregroundColor(Color("white"))
                    Spacer()
                    ProgressView()
                        .frame(width: 15, height: 15)
                        .background(Color("black"))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                        .opacity(heightLoadingActive ? 1 : 0)

                    Text(height)
                        .foregroundColor(Color("white"))
                        .opacity(height == "" ? 0 : 1)
                        .onTapGesture {
                            heightDialogActive = true
                        }

                    Image("向下箭头")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color("yellow"))
                        .opacity(height == "" ? 1 : 0)
                        .onTapGesture {
                            heightDialogActive = true
                        }


                }
                Spacer().frame(height: 15)
            }

            VStack{
                HStack{
                    Text("体重:")
                        .foregroundColor(Color("white"))
                    Spacer()
                    ProgressView()
                        .frame(width: 15, height: 15)
                        .background(Color("black"))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                        .opacity(weightLoadingActive ? 1 : 0)

                    Text(weight)
                        .foregroundColor(Color("white"))
                        .opacity(weight == "" ? 0 : 1)
                        .onTapGesture {
                            weightDialogActive = true
                        }

                    Image("向下箭头")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color("yellow"))
                        .opacity(weight == "" ? 1 : 0)
                        .onTapGesture {
                            weightDialogActive = true
                        }


                }
                Spacer().frame(height: 15)
            }

            VStack{

                HStack{
                    Text("邮编:")
                        .foregroundColor(Color("white"))
                    Spacer()
                    ProgressView()
                        .frame(width: 15, height: 15)
                        .background(Color("black"))
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                        .opacity(postalCodeLoadingActive ? 1 : 0)

                    Text(postalCode)
                        .foregroundColor(Color("white"))
                        .opacity(postalCode == "" ? 0 : 1)
                        .onTapGesture {
                            postalCodeDialogActive = true
                        }

                    Image("向下箭头")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color("yellow"))
                        .opacity(postalCode == "" ? 1 : 0)
                        .onTapGesture {
                            postalCodeDialogActive = true
                        }


                }
                Spacer().frame(height: 15)
            }
            
        }
    }
    
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
                        self.presentationMode.wrappedValue.dismiss()
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
                TopBar(rootActive: $rootActive, titleText: "修改个人资料")
                
                ZStack{
                    
                    VStack{
                        HStack{
                            Image("wifi")
                            .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .foregroundColor(Color("yellow"))
                            
                            Spacer()
                            VStack{
                                
                                Image("wifi")
                                    .resizable()
                                    .frame(width: 50, height: 20)
                                    .foregroundColor(Color("yellow"))
                                
                                Text("Christina Chen")
                                    .foregroundColor(Color("white"))
                                
                                
                            }
                            
                        }
                        
                        
                        
                        
                            
                        ZStack{
                            VStack{
                                HStack{
                                    Text("")
                                    Spacer()
                                }
                                        
                                Rectangle().frame(height: 0.5).foregroundColor(Color("grey"))
                                        
                                
                                bodyInfo
                                
                            }
                            .padding()
                            
                            
                        }
                        .background(Color("black3"))
                        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
                        .cornerRadius(10)
                        
                        
                        Spacer()
                        
                    }
                            
                        
                    
                }
            
                Text("")
                
            
            }
                .background(Color("black"))
                .navigationTitle("")
                .navigationBarHidden(true)
                .statusBar(hidden: false)
                .navigationBarBackButtonHidden(true)
            
            
            
            ModalDialogView(
                showModal: $phoneNumDialogActive,
                title: "电话",
                cancelText: "Cancel",
                confirmText:"Confirm",
                content:
                    VStack{
                        
                        TextField("请输入电话:", text: $phoneNumEnteredValue)
                            .multilineTextAlignment(.trailing)
                        
                    },
                onConfirm:{
                    
                    print("电话 :    \(phoneNumEnteredValue)")
                    
                    phoneNumUpdate()
                    
                    
                },
                onCancel:{}
            )
            .opacity(phoneNumDialogActive ? 1 : 0)
            


            ModalDialogView(
                showModal: $genderDialogActive,
                title: "性别",
                cancelText: "Cancel",
                confirmText:"Confirm",
                content:
                    VStack{

                        TextField("请输入性别:", text: $genderEnteredValue)
                            .multilineTextAlignment(.trailing)

                    },
                onConfirm:{

                    print("性别 :    \(genderEnteredValue)")

                    genderUpdate()


                },
                onCancel:{}
            )
            .opacity(genderDialogActive ? 1 : 0)


            ModalDialogView(
                showModal: $birthDateDialogActive,
                title: "出生年月日",
                cancelText: "Cancel",
                confirmText:"Confirm",
                content:
                    VStack{


                        TextField("请输入出生年月日:", text: $birthDateEnteredValue)
                            .multilineTextAlignment(.trailing)

                    },
                onConfirm:{

                    print("出身年月日 :    \(birthDateEnteredValue)")

                    birthDateUpdate()


                },
                onCancel:{}
            )
            .opacity(birthDateDialogActive ? 1 : 0)


            ModalDialogView(
                showModal: $heightDialogActive,
                title: "身高",
                cancelText: "Cancel",
                confirmText:"Confirm",
                content:
                    VStack{


                        TextField("请输入身高:", text: $heightEnteredValue)
                            .multilineTextAlignment(.trailing)

                    },
                onConfirm:{

                    print("身高 :    \(heightEnteredValue)")

                    heightUpdate()


                },
                onCancel:{}
            )
            .opacity(heightDialogActive ? 1 : 0)


            ModalDialogView(
                showModal: $weightDialogActive,
                title: "体重",
                cancelText: "Cancel",
                confirmText:"Confirm",
                content:
                    VStack{

                        Text("请输入体重 " + ":")

                        TextField("请输入体重:", text: $weightEnteredValue)
                            .multilineTextAlignment(.trailing)

                    },
                onConfirm:{

                    print("体重 :    \(weightEnteredValue)")

                    weightUpdate()


                },
                onCancel:{}
            )
            .opacity(weightDialogActive ? 1 : 0)


            ModalDialogView(
                showModal: $postalCodeDialogActive,
                title: "邮编",
                cancelText: "Cancel",
                confirmText:"Confirm",
                content:
                    VStack{


                        TextField("请输入邮编:", text: $postalCodeEnteredValue)
                            .multilineTextAlignment(.trailing)

                    },
                onConfirm:{

                    print("邮编 :    \(postalCodeEnteredValue)")

                    postalCodeUpdate()


                },
                onCancel:{}
            )
            .opacity(postalCodeDialogActive ? 1 : 0)
            
            signInView
        }
            .onAppear{
                if !globalVariable.logIn{
                    signInDialogActive.toggle()
                }
            }
        
        
    }

}


extension ProfilePage{
    
    func phoneNumUpdate() -> Void{
        phoneNumDialogActive.toggle()
        phoneNumLoadingActive.toggle()
        
        phoneNumViewModel.initalize(phoneNum: phoneNumEnteredValue)
        
        phoneNumViewModel.getToken {
            phoneNum = phoneNumEnteredValue
            globalVariable.client?.MobilePhone = phoneNumEnteredValue
            phoneNumLoadingActive.toggle()
            
        } onError: { message in
            print(message)
            
            print("toast message: \(message)")
        }
    }

    func genderUpdate() -> Void{
        genderDialogActive.toggle()
        genderLoadingActive.toggle()

        genderViewModel.initalize(gender: genderEnteredValue)

        genderViewModel.getToken {
            gender = genderEnteredValue
            globalVariable.client?.Gender = genderEnteredValue
            genderLoadingActive.toggle()

        } onError: { message in
            print(message)

            print("toast message: \(message)")
        }
    }


    func birthDateUpdate() -> Void{
        birthDateDialogActive.toggle()
        birthDateLoadingActive.toggle()

        birthDateViewModel.initalize(birthDate: birthDateEnteredValue)

        birthDateViewModel.getToken {
            birthDate = birthDateEnteredValue
            globalVariable.client?.BirthDate = birthDateEnteredValue
            birthDateLoadingActive.toggle()

        } onError: { message in
            print(message)

            print("toast message: \(message)")
        }
    }


    func heightUpdate() -> Void{
        heightDialogActive.toggle()
        heightLoadingActive.toggle()

        heightViewModel.initalize(height: heightEnteredValue)

        heightViewModel.getToken {
            height = heightEnteredValue
            globalVariable.client?.CustomClientFields?[0].Value = heightEnteredValue
            heightLoadingActive.toggle()

        } onError: { message in
            print(message)

            print("toast message: \(message)")
        }
    }


    func weightUpdate() -> Void{
        weightDialogActive.toggle()
        weightLoadingActive.toggle()

        weightViewModel.initalize(weight: weightEnteredValue)

        weightViewModel.getToken {
            weight = weightEnteredValue
            globalVariable.client?.CustomClientFields?[1].Value = weightEnteredValue
            weightLoadingActive.toggle()

        } onError: { message in
            print(message)

            print("toast message: \(message)")
        }
    }


    func postalCodeUpdate() -> Void{
        postalCodeDialogActive.toggle()
        postalCodeLoadingActive.toggle()

        postalCodeViewModel.initalize(postalCode: postalCodeEnteredValue)

        postalCodeViewModel.getToken {
            postalCode = postalCodeEnteredValue
            globalVariable.client?.PostalCode = postalCodeEnteredValue
            postalCodeLoadingActive.toggle()

        } onError: { message in
            print(message)

            print("toast message: \(message)")
        }
    }
    
}


extension ProfilePage{
    
    
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
            
            self.presentationMode.wrappedValue.dismiss()
            
        }
        
        
    }
    
    func signUp() -> Void {
        let auth = Auth.auth()
        auth.createUser(withEmail: emailLogin, password: passwordLogin){authResult, error in
            
            guard authResult != nil, error == nil else{
                self.presentationMode.wrappedValue.dismiss()
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
                
                self.presentationMode.wrappedValue.dismiss()
            }
            
        
            
        }
    }
    
    func signIn() -> Void{
        
        
        let auth = Auth.auth()
        auth.signIn(withEmail: emailLoginn, password: passwordLoginn){authResult, error in
         
            
            guard authResult != nil, error == nil else {
                print("Authentication failed")
                
                self.presentationMode.wrappedValue.dismiss()
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
                    
                    signInMindbody()
                }
                else{
                    print("Something wrong, try again later")
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            
            }
        }
    }
    
    func refresh() -> Void{
        
        phoneNum = globalVariable.logIn ? (globalVariable.client?.MobilePhone ?? "") : ""
        
        gender = globalVariable.logIn ? (globalVariable.client?.Gender ?? "") : ""


        birthDate = globalVariable.logIn ? (globalVariable.client?.BirthDate ?? "") : ""


        height = globalVariable.logIn ? (globalVariable.client?.height ?? "") : ""


        weight = globalVariable.logIn ? (globalVariable.client?.weight ?? "") : ""

        postalCode = globalVariable.logIn ? (globalVariable.client?.PostalCode ?? "") : ""


    }
}

struct ProfilePage_Previews: PreviewProvider {
    
    @State static var rootActive: Bool = false
    
    static var previews: some View {
        ProfilePage(rootActive: $rootActive)
    }
}
