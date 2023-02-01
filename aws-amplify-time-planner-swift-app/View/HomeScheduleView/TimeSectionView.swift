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
    @State private var selectedDate: Hour? = nil
    
    @Binding var scheduleDate:Date
    
    var body: some View {
        ScrollView{
            HStack(alignment: .top){
                VStack(alignment:.center, spacing:10){
                    Text("Dummy Text")
                        .opacity(0)
                    ForEach(morningHours){
                        hour in
                        Button(action:{
                            selectedDate = hour
                        },label:{
                            Text(plannedEventViewModel.plannedMorningEventsDict[dateHelper.formatFromDateStringToTimestamp(date:  "\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")] ??
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
                    
                    Text("Dummy Text")
                        .opacity(0)
                    
                }
                .sheet(item: $selectedDate){
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
                        ForEach(scheduleHours[index]){
                            hour in
                            Text("\(hour.value):00")
                        }
                    }
                }
                VStack(alignment:.center){
                    Text("hello")
                }
                .frame(
                    minWidth:0,
                    maxWidth: .infinity
                )
            }
        }
        .padding()
        .onAppear{
            plannedEventViewModel.updatePlannedMorningEventsDict()
        }
    }
}

struct EditPlannedEventSheet: View{
    
    var hour: Hour
    @Binding var scheduleDate: Date
    
    let dateHelper = DateHelper()
    
    let coreDM = CoreDataManager()
    
    @State var eventName: String = ""
    
    @EnvironmentObject var plannedEventViewModel: PlannedEventViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        VStack{
            Text("\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")
            TextField("Event Name", text: $eventName)
                .padding()
            Button {
                
                coreDM.savePlannedEvent(name: eventName, date: dateHelper.formateFromDateWithHourStringToDate(dateString: "\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")!
                )
                plannedEventViewModel.updatePlannedMorningEventsDict()
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Text("Submit")
                    .padding()
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
