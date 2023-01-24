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
    
    @ObservedObject var plannedEventViewModel = PlannedEventViewModel()
    @State private var morningPlannedEventsDict: [TimeInterval: String] = [:]
    @State private var selectedDate: Hour? = nil
    
    var body: some View {
    ScrollView{
            HStack(alignment: .top){
                VStack(alignment:.center, spacing:10){
                    Text("hello")
                        .opacity(0)
                    ForEach(morningHours){
                        hour in
//                        if (
//                            morningPlannedEventsDict[dateHelper.formatFromDateStringToTimestamp(date:"2023-01-18 \(hour)")] != nil) {
//                            let eventName =  morningPlannedEventsDict[dateHelper.formatFromDateStringToTimestamp(date:"2023-01-18 \(hour)")] ?? ""
////                            Text(eventName)
                        Button(action:{
                            selectedDate = hour
                        },label:{
                            Text("2023-01-18 \(hour.value)")
                        }
                        )
                    }
                }
                .sheet(item: $selectedDate){
                    date in
                    EditPlannedEventSheet(date: date)
                }
                .frame(
                    minWidth:0,
                    maxWidth: .infinity
                )
//                .sheet(isPresented: $showSheet){
//                    hour in
//                   EditPlannedEventSheet(date: "2023-01-18 \(hour)")
//                }
               
                
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
           morningPlannedEventsDict = plannedEventViewModel.generatePlannedMorningEventsDict()
            print(plannedEventViewModel.plannedMorningEvents)
        }
    }
}

struct EditPlannedEventSheet: View{
    
   var date: Hour
    
    var body: some View{
        Text(date.value)
    }
}

struct TimeSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScheduleView()
//        TimeSectionView()
    }
}
