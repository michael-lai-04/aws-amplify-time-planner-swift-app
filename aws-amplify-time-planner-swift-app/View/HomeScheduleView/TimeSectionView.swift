//
//  TimeSectionView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import SwiftUI

struct TimeSectionView: View{
    
    let dateHelper = DateHelper()
    
    let morningHours: [String] = ["06","07","08","09","10", "11"]
    let afternoonHours: [String] = ["12", "13","14","15","16", "17", "18"]
    let eveningHours: [String] = ["19","20","21","22","23"]
    let midnightHours: [String] = ["00", "01", "02", "03", "04", "05"]
    
    @ObservedObject var plannedEventViewModel = PlannedEventViewModel()
    @State private var morningPlannedEventsDict: [TimeInterval: String] = [:]
        
    var body: some View {
    ScrollView{
            HStack(alignment: .top){
                VStack(alignment:.center){
                    Text("hello")
                        .opacity(0)
                    ForEach(morningHours, id: \.self){
                        hour in
                        if (
                            morningPlannedEventsDict[dateHelper.formatFromDateToTimestamp(date:"2023-01-18 \(hour)")] != nil) {
                            let eventName =  morningPlannedEventsDict[dateHelper.formatFromDateToTimestamp(date:"2023-01-18 \(hour)")] ?? ""
                            Text(eventName)
                        }
                    }
                }
                .frame(
                    minWidth:0,
                    maxWidth: .infinity
                )
                VStack(spacing:10){
                    Text("Morning")
                    ForEach(morningHours, id: \.self){
                        hour in
                        Text("\(hour):00")
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
        }
    }
}

struct TimeSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScheduleView()
//        TimeSectionView()
    }
}
