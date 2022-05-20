//
//  AnotherCalendar.swift
//  TryOutSwiftUI (iOS)
//
//  Created by Chen Chen on 2021-08-23.
//

//MARK: dont forget to Implement calendar positioning for ranger picker from my own version

import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    static var monthInNumber: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        return formatter
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    private var days: [Date] {
        guard
            let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let month: Date
    let showHeader: Bool
    let content: (Date) -> DateView

    init(
        month: Date,
        showHeader: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.month = month
        self.content = content
        self.showHeader = showHeader
    }

    private var weeks: [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    private var header: some View {
        _ = calendar.component(.month, from: month)
//        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
        let formatter = DateFormatter.monthAndYear
        return Text(formatter.string(from: month))
            .font(.title3)
            .padding()
    }
    private var backgroundMonth: some View{
        _ = calendar.component(.month, from: month)
        let formatter = DateFormatter.monthInNumber
        return Text(formatter.string(from: month))
            .font(.system(size: 100))
            .padding()
            .foregroundColor(Color("white"))
    }

    
    var body: some View {
            
        VStack {
            if showHeader {
                header
            }

            ZStack {
                backgroundMonth
                VStack{
                    ForEach(weeks, id: \.self) { week in
                        WeekView(week: week, content: self.content)
                    }
                }
            }
        }
        
    }
}

struct CalendarView2<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let content: (Date) -> DateView

    init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.content = content
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, content: self.content)
                }
            }
        }
    }
}

struct DatePicker: View {
    @Environment(\.calendar) var calendar
    
    @State var tapped:Bool = false
    @State var selectedDate: Date = Date()
    @Binding var dateSelectorCardShown:Bool
    
    let action: (_ selectedDate:Date)->Void

    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    private var halfYear: DateInterval {
        
        let currentDate = Date()
        let endDate = currentDate + 6*30*24*60*60
//        print(DateInterval(start: currentDate, end: endDate).contains(Date()))
        return DateInterval(start: currentDate, end: endDate)
    }
    
    var closeWindow: some View{
        
        Image(systemName: "xmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 16, height: 16)
            .foregroundColor(.gray)
            .onTapGesture {
                withAnimation(){
                    dateSelectorCardShown = false
                }
            }
    }
    
    var weekdaysIndication: some View{
        HStack{
            Text("Mon")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Tue")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Wed")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Thu")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Fri")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Sat")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Sun")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
        }
        .frame(maxWidth:.infinity)
    }
    
    var confirmationButton: some View{
        Button(action: {
            withAnimation(){
                dateSelectorCardShown = false
                
            }
            action(selectedDate)
            
        },
               label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                                    .accentColor(Color("yellow"))
                    Text("Confirm start date")
                        .frame(maxWidth:.infinity)
                        .foregroundColor(.black)
                }
                .frame(height: UIScreen.main.bounds.height/20)
                .padding()
        })
    }
    
    var calendarDisplayer: some View{
        CalendarView2(interval: halfYear) { date in
           
            if calendar.isDate(self.selectedDate, equalTo: date, toGranularity: .day){
                Text("30")
                    .hidden()
                    .padding(8)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(self.calendar.component(.day, from: date)))
                    )
                    .frame(maxWidth: .infinity)
                
            }
            
            
            else if halfYear.contains(date) || calendar.isDate(Date(), equalTo: date, toGranularity: .day) {
                Text("30")
                    .hidden()
                    .padding(8)
                    .foregroundColor(.black)
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(self.calendar.component(.day, from: date)))
                    )
                    .frame(maxWidth: .infinity)
                        .onTapGesture {
                            withAnimation{
                                selectedDate = date
                            }
                        }
            }
            
            else{
                Text("30")
                    .hidden()
                    .padding(8)
                    
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(self.calendar.component(.day, from: date)))
                            .foregroundColor(.gray)
                    )
                    .frame(maxWidth: .infinity)
                    .onTapGesture(perform: {
//                        print(date == Date())
//                        print(date)
//                        print(Date())
                    })
            }
           
            
            
        }
    }

    var body: some View {
        ZStack (alignment:.topTrailing){
            
            closeWindow
                .padding()
            VStack {
                Text("Select start date")
                    .padding()
                weekdaysIndication
                
                
                calendarDisplayer
                
                confirmationButton
                
            }
        }
    }
}

struct DateRangePicker: View {
    @Environment(\.calendar) var calendar
    
    @State var tapped:Bool = false
    @State var selectedDate: Date = Date()
    @State var selectedDate2: Date?
    @State var selectedInterval: DateInterval?
    @State var bothDateSelected: Bool = false
    @Binding var dateSelectorCardShown:Bool
    
    let action: (_ selectedDate:Date, _ selectedDate2:Date)->Void

    
    private var halfYear: DateInterval {
        
        let currentDate = Date()
        let endDate = currentDate + 6*30*24*60*60
//        print(DateInterval(start: currentDate, end: endDate).contains(Date()))
        return DateInterval(start: currentDate, end: endDate)
    }
    
    var closeWindow: some View{
        
        Image(systemName: "xmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 16, height: 16)
            .foregroundColor(.gray)
            .onTapGesture {
                withAnimation(){
                    dateSelectorCardShown = false
                }
            }
    }
    
    var weekdaysIndication: some View{
        HStack{
            Text("Mon")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Tue")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Wed")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Thu")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Fri")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Sat")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
            Text("Sun")
                .foregroundColor(.black)
                .frame(maxWidth:.infinity)
        }
        .frame(maxWidth:.infinity)
    }
    
    var confirmationButton: some View{
        Button(action: {
            if selectedDate2 != nil{
                withAnimation(){
                    dateSelectorCardShown = false
                    
                }
                action(selectedDate, selectedDate2!)
            }
            
        },
               label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                                    .accentColor(Color("yellow"))
                    Text("Confirm start date")
                        .frame(maxWidth:.infinity)
                        .foregroundColor(.black)
                }
                .frame(height: UIScreen.main.bounds.height/20)
                .padding()
        })
    }
    
    var calendarDisplayer: some View{
        CalendarView2(interval: halfYear) { date in
           
            if calendar.isDate(self.selectedDate, equalTo: date, toGranularity: .day){
                Text("30")
                    .hidden()
                    .padding(8)
                    .foregroundColor(.black)
                    .background(Color.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(self.calendar.component(.day, from: date)))
                    )
                    .frame(maxWidth: .infinity)
                
            }
            else if selectedDate2 != nil &&
                 calendar.isDate(self.selectedDate2!, equalTo: date, toGranularity: .day){
                    Text("30")
                        .hidden()
                        .padding(8)
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical, 4)
                        .overlay(
                            Text(String(self.calendar.component(.day, from: date)))
                        )
                        .frame(maxWidth: .infinity)
                    
                
            }
            
            else if selectedInterval != nil &&
                selectedInterval!.contains(date){
                    Text("30")
                        .hidden()
                        .padding(8)
                        .foregroundColor(.black)
                        .background(Color("gray"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.vertical, 4)
                        .overlay(
                            Text(String(self.calendar.component(.day, from: date)))
                        )
                        .frame(maxWidth: .infinity)
                            .onTapGesture {
                                if !bothDateSelected{
                                    bothDateSelected.toggle()
                                    withAnimation{
                                        selectedDate2 = date
                                        
                                    }
                                    
                                    if selectedDate > selectedDate2!{
//                                        (selectedDate,selectedDate2) = (selectedDate2!,selectedDate)
                                        let holdvalue = selectedDate2!
                                        selectedDate2 = selectedDate
                                        selectedDate = holdvalue
                                    }
                                    
                                    withAnimation{
                                    selectedInterval = DateInterval(start: selectedDate, end: selectedDate2!)
                                    }
                                    
                                }
                                else if bothDateSelected{
                                    bothDateSelected.toggle()
                                    selectedDate2 = nil
                                    withAnimation{
                                        selectedDate = date
                                    }
                                    selectedInterval = nil
                                    
                                }
                            }
                
            }
            
            
            else if halfYear.contains(date) || calendar.isDate(Date(), equalTo: date, toGranularity: .day) {
                Text("30")
                    .hidden()
                    .padding(8)
                    .foregroundColor(.black)
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(self.calendar.component(.day, from: date)))
                    )
                    .frame(maxWidth: .infinity)
                        .onTapGesture {
                            if !bothDateSelected{
                                bothDateSelected.toggle()
                                withAnimation{
                                    selectedDate2 = date
                                    
                                }
                                if selectedDate > selectedDate2!{
//                                        (selectedDate,selectedDate2) = (selectedDate2!,selectedDate)
                                    let holdvalue = selectedDate2!
                                    
                                    selectedDate2 = selectedDate
                                    selectedDate = holdvalue
                                }
                                
                                withAnimation{
                                    selectedInterval = DateInterval(start: selectedDate, end: selectedDate2!)
                                }
                            }
                            else if bothDateSelected{
                                bothDateSelected.toggle()
                                selectedDate2 = nil
                                withAnimation{
                                    selectedDate = date
                                    selectedInterval = nil
                                }
                                
                                
                            }
                        }
            }
            
            else{
                Text("30")
                    .hidden()
                    .padding(8)
                    
                    .padding(.vertical, 4)
                    .overlay(
                        Text(String(self.calendar.component(.day, from: date)))
                            .foregroundColor(.gray)
                    )
                    .frame(maxWidth: .infinity)
                    .onTapGesture(perform: {
//                        print(date == Date())
//                        print(date)
//                        print(Date())
                    })
            }
           
            
            
        }
    }

    var body: some View {
        ZStack (alignment:.topTrailing){
            
            closeWindow
                .padding()
            VStack {
                Text("Select start date")
                    .padding()
                weekdaysIndication
                
                
                calendarDisplayer
                
                confirmationButton
                    .opacity(bothDateSelected ? 1 : 0.2)
                
            }
        }
    }
}



struct RootView_Previews: PreviewProvider {
    static var previews: some View {
    contentViewCalendar()
        
    }
}
struct contentViewCalendar: View{
    @State var shown = true
    var body: some View{
        DateRangePicker(dateSelectorCardShown: $shown){ selectedDate,selected2 in
        
        }
    }
}

