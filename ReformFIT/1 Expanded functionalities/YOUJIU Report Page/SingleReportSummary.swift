//
//  SingleReportSummary.swift
//  ChenReformFITPart (iOS)
//
//  Created by Chen Chen on 2021-09-15.
//

import SwiftUI

struct SingleReportSummary: View {
    let dataModel:YOUJIUReportDataModel
    var body: some View {
        HStack{
            VStack(alignment:.leading,spacing:6){
                timeDisplay
                    .foregroundColor(Color("white"))
                strengthIndex
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color("white"))
                starDisplay
                    .foregroundColor(Color("yellow"))
            }
            Spacer(minLength: 70)
            rightSide
                .padding(.trailing,24)
        }
        .padding(24)
        .background(LinearGradient(gradient: Gradient(colors: [Color("main_background"),Color("main_background"), Color("rare_gray"),Color("gray")]), startPoint: .bottomLeading, endPoint: .topTrailing))
        .padding(12)
    }
    var timeDisplay:some View{
        Text(dataModel.reportTime)
            .fixedSize(horizontal: false, vertical: true)
            .font(.system(size: 14))
    }
    var strengthIndex:Text{
        Text("Strength Index: ")
            .bold()
            .font(.system(size: 14))
        +
            Text(dataModel.muscleIndex)
            .font(.system(size: 14))
    }
    
    var starDisplay:some View{
        IndexDisplayer(index: dataModel.muscleIndex)
    }
    
   
    
    var rightSide:some View{
        HStack {
            VStack(spacing:12){
                Image(systemName: "scalemass")
                    .foregroundColor(.white)
                    .background(Circle().foregroundColor(.green).frame(width:24, height:24))
                Image(systemName: "scalemass")
                    .foregroundColor(.white)
                    .background(Circle().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).frame(width:24, height:24))
                Image(systemName: "scalemass")
                    .foregroundColor(.white)
                    .background(Circle().foregroundColor(.yellow).frame(width:24, height:24))
            }
            VStack(alignment:.leading,spacing:12){
                Text(dataModel.weight+"kg")
                Text(String(dataModel.muscleAmt)+"kg")
                Text(String(dataModel.bodyFat)+"%")

                
            }
            .foregroundColor(Color("white"))
        }
    }
}

struct SingleReportSummary_Previews: PreviewProvider {
    static var previews: some View {
        SingleReportSummary(dataModel:YOUJIUReportDataModel(id: 11111,
                                                            weight: "98",
                                                            bodyFat: 19.8,
                                                            muscleAmt: 35,
                                                            muscleIndex: "12",
                                                            reportTime: "04-11-2021-12:30",
                                                            gender: 1))
    }
}


struct IndexDisplayer: View{
    var indexModel:IndexTranslateModel
    init(index:String) {
        self.indexModel = IndexTranslateModel(index: index)
        self.indexModel.convert()
//        print(self.indexModel.scoreArray)
    }
    var body: some View{
        HStack {
            ForEach(self.indexModel.scoreArray,id:\.self){
                data in
                ratingStar(score: data)
            }
        }
    }
}

struct ratingStar: View{
    let score: Double
    var body: some View{
        
        
        if score == 1 {
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        else if score == 0.5{
            Image(systemName: "star.leadinghalf.filled")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        else if score == 0{
            Image(systemName: "star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}


class IndexTranslateModel{
    let index:String
    var indexInDouble:Double
    var scoreArray:[Double] = [0,0,0,0,0]
    
    init(index:String) {
        self.index = index
//        print(index)
        self.indexInDouble = Double(index)!
        
    }
    func convert(){
        var wholeStartCount:Int = 0
        wholeStartCount = Int(floor(indexInDouble/20))
        for i in 0..<wholeStartCount{
            scoreArray[i] = 1
        }
        var leftOver : Double = 0
        leftOver = indexInDouble.truncatingRemainder(dividingBy: 20)
        
        if leftOver >= 5 && leftOver < 15{
            scoreArray[wholeStartCount] = 0.5
        }
        else if leftOver >= 15{
            scoreArray[wholeStartCount] = 1
        }
    }
    
}
