//
//  TimeSectionView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import SwiftUI

struct Hour: Identifiable {
    let id = UUID()
    let value: String
}

let morningHours: [Hour] = [
    Hour(value: "06"),
    Hour(value: "07"),
    Hour(value: "08"),
    Hour(value: "09"),
    Hour(value: "10"),
    Hour(value: "11"),
]

let afternoonHours: [Hour] = [
    Hour(value:"12" ),
    Hour(value: "13"),
    Hour(value: "14"),
    Hour(value: "15"),
    Hour(value: "16"),
    Hour(value: "17"),
    Hour(value: "18"),
]

let eveningHours: [Hour] = [
    Hour(value:"19" ),
    Hour(value: "20"),
    Hour(value: "21"),
    Hour(value: "22"),
    Hour(value: "23"),
]

let midnightHours: [Hour] = [
    Hour(value:"00" ),
    Hour(value: "01"),
    Hour(value: "02"),
    Hour(value: "03"),
    Hour(value: "04"),
    Hour(value: "05"),
]


struct TimeSectionView: View{
    
    let dateHelper = DateHelper()
    
    let scheduleTimes = ["Morning", "Afternoon", "Evening", "Midnight"]
    let scheduleHours = [morningHours, afternoonHours, eveningHours, midnightHours ]
    
    @StateObject var plannedEventViewModel = PlannedEventViewModel()
    @StateObject var actualEventViewModel = ActualEventViewModel()
    
    @Binding var scheduleDate:Date

    @State private var selectedPlannedEventHour: Hour? = nil
    @State private var selectedActualEventHour:Hour? = nil
    
    var body: some View {
        ScrollView{
            HStack(alignment: .top){
                VStack(alignment:.center, spacing:10){
                    ForEach(scheduleHours.indices, id: \.self){
                        index in
                        Text("Dummy Text")
                            .opacity(0)
                        
                            ForEach(scheduleHours[index]){
                                hour in
                                Button(action:{
                                    selectedPlannedEventHour = hour
                                },label:{
                                    Text(plannedEventViewModel.plannedEventsDict[dateHelper.formatFromDateStringToTimestamp(date:  "\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")] ??
                                         " ")
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity
                                    )
                                    .overlay(
                                        Rectangle()
                                            .frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("#B1B2B4")),
                                        alignment: .bottom
                                    )
                                }
                                )
                                .buttonStyle(.plain)
                            }
                    }
                    
                }
                .sheet(item: $selectedPlannedEventHour){
                    hour in
                    EditPlannedEventSheet(hour: hour, scheduleDate: $scheduleDate)
                        .environmentObject(plannedEventViewModel)
                }
                .frame(
                    minWidth:0,
                    maxWidth: .infinity
                )
                
                VStack(spacing:10){
                    ForEach(scheduleTimes.indices, id: \.self){
                        index in
                        Text(scheduleTimes[index])
                            .fontWeight(Font.Weight.bold)
                        ForEach(scheduleHours[index]){
                            hour in
                            Text("\(hour.value):00")
                        }
                    }
                }
                
                VStack(alignment:.center,  spacing:10){
                    ForEach(scheduleHours.indices, id: \.self){
                        index in
                        Text("Dummy Text")
                            .opacity(0)
                        
                            ForEach(scheduleHours[index]){
                                hour in
                                Button(action:{
                                    selectedActualEventHour = hour
                                },label:{
                                    Text(
                                        actualEventViewModel.actualEventsDict[dateHelper.formatFromDateStringToTimestamp(date:  "\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")] ??
                                         " ")
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity
                                    )
                                    .overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("#B1B2B4")), alignment: .bottom)
                                }
                                )
                                .buttonStyle(.plain)
                            }
                    }
                }
                .sheet(item: $selectedActualEventHour){
                    hour in
                    EditActualEventSheet(hour: hour, scheduleDate: $scheduleDate)
                        .environmentObject(actualEventViewModel)
                        .environmentObject(plannedEventViewModel)
                }
                .frame(
                    minWidth:0,
                    maxWidth: .infinity
                )
            }
        }
        .padding()
        .onAppear{
            plannedEventViewModel.updatePlannedEventsDict()
        }
    }
}

struct EditActualEventSheet: View {
    
    var hour: Hour
    @Binding var scheduleDate: Date
    
    let dateHelper = DateHelper()
    let actualEventManager = ActualEventManager()
        
    @EnvironmentObject var actualEventViewModel: ActualEventViewModel
    @EnvironmentObject var plannedEventViewModel: PlannedEventViewModel

    @State var eventName: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("#F6F3F3")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack{
                VStack{
                    Text("\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value):00")
                        .padding(5)
                        .background(Color("#e3d8b8"))
                        .cornerRadius(10)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(
                    Rectangle()
                        .frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("#B1B2B4")),
                    alignment: .bottom
                )
                
                VStack{
                    Text("Actual Event :")
                        .frame(
                            maxWidth:.infinity, alignment: .leading)
                    TextField("Event Name", text: $eventName)
                    Button {
                        
                        actualEventManager.saveActualEvent(name: eventName, date: dateHelper.formateFromDateWithHourStringToDate(dateString: "\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")!
                        )
                        actualEventViewModel.updateActualEventsDict()
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Submit")
                            .padding()
                    }
                }
                .padding()
            }
        }
        .onAppear{
            var dateComponents = Calendar.current.dateComponents([.year,.month, .day,.hour,.minute], from: scheduleDate)
                dateComponents.hour = Int(hour.value)!
                dateComponents.minute = 0
            
            let date = Calendar.current.date(from: dateComponents)

            guard let timeInterval = date?.timeIntervalSince1970 else{return}
 
            eventName = plannedEventViewModel.getPlannedEventBy(timestamp:timeInterval)
        }
    }
}

struct EditPlannedEventSheet: View{
    
    var hour: Hour
    @Binding var scheduleDate: Date
    
    let dateHelper = DateHelper()
    let notificationManager = NotificationManager()
    let plannedEventManager = PlannedEventManager()
    
    @State private var eventName: String = ""
    @State private var isReahedFinishTimeReminderSet: Bool = false
    @State private var beforeStartTimeReminderSelection = 0
    
    @EnvironmentObject var plannedEventViewModel: PlannedEventViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    let beforeStartTimeReminderMinutes = [0, 5, 10 , 15, 30]
    
    var body: some View{
        
        ZStack(alignment: .topLeading) {
            Color("#F6F3F3")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            VStack{
                VStack{
                    Text("\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value):00")
                        .padding(5)
                        .background(Color("#e3d8b8"))
                        .cornerRadius(10)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(
                    Rectangle()
                        .frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color("#B1B2B4")),
                    alignment: .bottom
                )
                
                VStack{
                    Text("Planned Event :")
                        .frame(
                            maxWidth:.infinity,
                            alignment: .leading
                        )
                    
                    TextField("Event Name", text: $eventName)
                        .padding(.horizontal)
                    
                    Toggle("Reminder When Finish Time Reached", isOn: $isReahedFinishTimeReminderSet)
                    
                    HStack{
                        Text("Reminder Before Start Time")
                        Spacer()
                        Menu{
                            Picker(selection: $beforeStartTimeReminderSelection){
                                ForEach(beforeStartTimeReminderMinutes.indices, id: \.self){
                                    i in
                                    Text(beforeStartTimeReminderMinutes[i] > 0 ?
                                         String(beforeStartTimeReminderMinutes[i]) :
                                            "not selected"
                                    )
                                    .padding()
                                }
                            }label: {
                            }
                        }label: {
                            Text(beforeStartTimeReminderMinutes[beforeStartTimeReminderSelection] > 0 ?
                                 String(beforeStartTimeReminderMinutes[beforeStartTimeReminderSelection]) :
                                    "not selected"
                            )
                            .foregroundColor(.black)
                            .padding()
                        }
                    }
                    
                    Button {
                        let scheduleDateString = dateHelper.formatFromDateToDateString(date: scheduleDate)
                        let eventDateString = "\(scheduleDateString) \(hour.value)"
                        let eventDate =           dateHelper.formateFromDateWithHourStringToDate(dateString: eventDateString)
                        
                        plannedEventManager.savePlannedEvent(name: eventName, date: eventDate!
                        )
                        
                        plannedEventViewModel.updatePlannedEventsDict()
                        
                        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: scheduleDate)
                        
                        if(beforeStartTimeReminderSelection > 0){
                            dateComponents.hour = Int(hour.value)! - 1
                            dateComponents.minute = 60 - Int(beforeStartTimeReminderMinutes[beforeStartTimeReminderSelection])
                            
                            NotificationManager.instance.scheduleNotification(notificationContent: NotificationContent(title: eventName, subtitle: "", dateComponents: dateComponents))
                        }
                        
                        if(isReahedFinishTimeReminderSet){
                            dateComponents.hour = Int(hour.value)! + 1
                            NotificationManager.instance.scheduleNotification(notificationContent: NotificationContent(title: eventName, subtitle: "Reahed Finish Time!", dateComponents: dateComponents))
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Submit")
                            .padding()
                    }
                }.padding()
            }
        }
        
    }
}

struct TimeSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScheduleView()
        //        TimeSectionView()
    }
}
