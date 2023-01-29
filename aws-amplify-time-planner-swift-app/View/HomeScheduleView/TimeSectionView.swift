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
struct TimeSectionView: View{
    
    let dateHelper = DateHelper()
    
    let morningHours: [Hour] = [
        Hour(value: "06"),
        Hour(value: "07"),
        Hour(value: "08"),
        Hour(value: "09"),
        Hour(value: "10"),
        Hour(value: "11"),
]
    let afternoonHours: [String] = ["12", "13","14","15","16", "17", "18"]
    let eveningHours: [String] = ["19","20","21","22","23"]
    let midnightHours: [String] = ["00", "01", "02", "03", "04", "05"]
    
    @StateObject var plannedEventViewModel = PlannedEventViewModel()
    @State private var selectedDate: Hour? = nil
    
    @Binding var scheduleDate:Date
    
    var body: some View {
    ScrollView{
            HStack(alignment: .top){
                VStack(alignment:.center, spacing:10){
                    Text("hello")
                        .opacity(0)
                    ForEach(morningHours){
                        hour in
                        Button(action:{
                            selectedDate = hour
                        },label:{
                            Text(plannedEventViewModel.plannedMorningEventsDict[dateHelper.formatFromDateStringToTimestamp(date:  "\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")] ??
                                "\(dateHelper.formatFromDateToDateString(date: scheduleDate)) \(hour.value)")
                        }
                        )
                    }
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
                    Text("Morning")
                    ForEach(morningHours){
                        hour in
                        Text("\(hour.value):00")
                    }
                    Text("Afternoon")
                    ForEach(afternoonHours, id: \.self){
                        hour in
                        Text("\(hour):00")
                    }
                    Text("evening")
                    ForEach(eveningHours, id: \.self){
                        hour in
                        Text("\(hour):00")
                    }
                    Text("midnight")
                    ForEach(midnightHours, id: \.self){
                        hour in
                        Text("\(hour):00")
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
        }.onAppear{
            plannedEventViewModel.updatePlannedMorningEventsDict()
        }
    }
}

struct EditPlannedEventSheet: View{
    
    var hour: Hour
    @Binding var scheduleDate: Date

    let dateHelper = DateHelper()
        
    let coreDM = CoreDataManager()

//    let updatePlannedEvent: () -> Void
    
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
