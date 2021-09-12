//
//  MainMain1.swift
//  ReformFIT
//
//  Created by J on 2021-08-04.
//

import SwiftUI

struct MineMain1: View {
    @Binding var wristBandBrand: String
    
    @Binding var wristBandNum: String
    @State var wristBandNumEnteredValue: String = ""
    @State var wristBandNumDialogActive: Bool = false
    @State var wristBandNumLoadingActive = false
    @State var wristBandNumViewModel = WristBandNumViewModel()
    
    
    
    
    
    var body: some View {
        
        ZStack{
            VStack{
                
                Spacer().frame(height: 15)
                
                
                 ZStack{
                    VStack{
                            
                        HStack{
                            Text("我的设备")
                                .foregroundColor(Color("yellow"))
                            Spacer()
                        }
                            
                        Rectangle()
                            .stroke()
                            .frame(height: 0.5)
                            .foregroundColor(Color("grey"))
                        HStack{
                            Text("手环品牌")
                                .foregroundColor(Color("white"))
                            Spacer()
                            Text(wristBandBrand)
                                .foregroundColor(Color("white"))
                        }
                        
                        
                        
                        
                        HStack{
                            Text("手环号码:")
                                .foregroundColor(Color("white"))
                            Spacer()
                            
                            if wristBandNumLoadingActive{
                                ProgressView()
                                    .frame(width: 15, height: 15)
                                    .background(Color("black"))
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
                            }
                            if wristBandNum == "" {
                                Image("向下箭头")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color("yellow"))
                                    .onTapGesture {
                                        wristBandNumDialogActive = true
                                    }
                            }
                                
                            if wristBandNum != "" {
                                Text(wristBandNum)
                                    .foregroundColor(Color("white"))
                                    .opacity(wristBandNum == "" ? 0 : 1)
                                    .onTapGesture {
                                        wristBandNumDialogActive = true
                                    }
                            }
                            
                        }
                        
                            
                       
                
                        
                        
                    }
                    .padding()
                }
                .background(Color("black3"))
                .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
                .cornerRadius(10)
            
            ExtentedFuncView()
            
            Spacer()
                
                
                
            
        }
            ModalDialogView(
                showModal: $wristBandNumDialogActive,
                title: "电话",
                cancelText: "Cancel",
                confirmText:"Confirm",
                content:
                    VStack{
                        
                        TextField("请输入电话:", text: $wristBandNumEnteredValue)
                            .multilineTextAlignment(.trailing)
                        
                    },
                onConfirm:{
                    
                    print("电话 :    \(wristBandNumEnteredValue)")
                    
                    wristBandNumUpdate()
                    
                    
                },
                onCancel:{}
            )
            .opacity(wristBandNumDialogActive ? 1 : 0)
            
            
            
            
        
        }
    }
}

extension MineMain1{
    
    
    func refreshing() -> Void {
        
        print("MineMain1 refreshing")
        
        print("wristband brand  \(globalVariable.client?.wristBandBrand)")
        
        wristBandBrand = globalVariable.client?.wristBandBrand ?? ""
        
        
        wristBandNum = globalVariable.client?.wristBandNum ?? ""
        
    }
    
    
    func wristBandNumUpdate() -> Void{
        wristBandNumDialogActive.toggle()
        wristBandNumLoadingActive.toggle()
        
        wristBandNumViewModel.initalize(wristBandNum: wristBandNumEnteredValue)
        
        wristBandNumViewModel.getToken {
            wristBandNum = wristBandNumEnteredValue
            globalVariable.client?.CustomClientFields?[3].Value = wristBandNumEnteredValue
            wristBandNumLoadingActive.toggle()
            
        } onError: { message in
            print(message)
            
            print("toast message: \(message)")
        }
    }
}




struct ExtentedFuncView: View{
    var extendedFuncGrid1 = [["wifi","体测数据"],["wifi","更衣室"],["wifi","健康配餐"],["wifi","BMI计算"]]
    
    var extendedFuncGrid2 = [["wifi","购买课包"],["wifi","最新Blog"],["wifi","BMR计算"],["wifi","TDEE计算"]]
    
    
    var body: some View{
        
        
        
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    ForEach(0..<extendedFuncGrid1.count){ row in
                            
                            VStack{
                                Image(extendedFuncGrid1[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(extendedFuncGrid1[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
                
                HStack{
                    Spacer()
                    ForEach(0..<extendedFuncGrid1.count){ row in
                            
                            VStack{
                                Image(extendedFuncGrid1[row][0])
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(Color("yellow"))
                                Text(extendedFuncGrid1[row][1])
                                    .foregroundColor(Color("white"))
                                    .font(.caption)
                            }
                            Spacer()
                            
                    }
                }
            }
            .padding()
            .padding(.horizontal, 0)
        }
        .background(Color("black3"))
        .frame(width: UIScreen.main.bounds.width*0.92, alignment: .center)
        .cornerRadius(10)
    }
}





struct MineMain1_Previews: PreviewProvider {
    @State static var fab: Bool = false
    
    
    static var previews: some View {
        MineMain(bottomView: $fab)
    }
}
