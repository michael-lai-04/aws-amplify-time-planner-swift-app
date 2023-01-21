//
//  ContentView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 14/1/2023.
//

import SwiftUI

struct SectionTitle: Identifiable{
let id = UUID()
let name: String
}

struct ContentView: View {
    @State private var selection = 1
    @State private var scheduleDate = Date()
    
    let dateHelper = DateHelper()
    
    let sectionTitles:[SectionTitle] = [
        SectionTitle(name: "Planned"),
        SectionTitle(name: "Time"),
        SectionTitle(name: "Actual")
]
    
    func addOneDayToScheduleDate() {
//        let date = dateHelper.formateFromDateStringToDate(dateString: scheduleDate)
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let newDate = Calendar.current.date(byAdding: dateComponent, to: scheduleDate)
        scheduleDate = newDate!
    }
    
    func subtractOneDayToScheduleDate(){
//        let date = dateHelper.formateFromDateStringToDate(dateString: scheduleDate)
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let newDate = Calendar.current.date(byAdding: .day,value: -1, to: scheduleDate)
   
        scheduleDate = newDate!
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("#F8F5ED")
                    .ignoresSafeArea()
                    VStack{
            HStack{
                ForEach(sectionTitles.indices, id: \.self){
                    i in
                    Text(sectionTitles[i].name)
                        .padding()
                        .overlay(
                               Rectangle()
                                .frame(height: i == selection ? 4 :0)
                                   .foregroundColor(Color("#e3d8b8")),
                               alignment: .bottom
                       )
                }
            }
            TabView(selection: $selection){
                PlannedEventSection()
                    .tag(0)
                TimeSection()
                    .tag(1)
                ActualEventSection()
                    .tag(2)

            }
            .tabViewStyle(
                .page(indexDisplayMode: .never))
            .border(Color.blue, width: 2)
    //        .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
            }
//                    .background{
//                        Color("#F8F5ED")
//                        }
//                    .navigationTitle(scheduleDate)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            HStack{
                                Button{
                                    subtractOneDayToScheduleDate()
                                }label:{
                                    Image(systemName:"arrow.left")
                                }.buttonStyle(.plain)
                                DatePicker("", selection:$scheduleDate, displayedComponents: .date)
                                   
//                                Text(scheduleDate)
                                Button{
                                    addOneDayToScheduleDate()
                                }label:{
                                    Image(systemName: "arrow.right")
                                }.buttonStyle(.plain)
                               
                            }      .frame(
                                minWidth:0,
                                maxWidth: .infinity,
                                alignment: .leading
                                )
                        }
                    }
        }
    }
}

struct PlannedEvent: Identifiable {
    let id = UUID()
    let name: String
    let timestamp:TimeInterval
}

class PlannedEventViewModel: ObservableObject {
    
    @Published var plannedMorningEvents: [PlannedEvent]

    let dateHelper = DateHelper()
    
    init(){
        plannedMorningEvents = [
            PlannedEvent(name: "起床", timestamp:dateHelper.formatFromDateToTimestamp(date: "2023-01-18 06") )
        ]
    }
        
    func generatePlannedMorningEventsDict () -> [TimeInterval: String] {
        var dict: [TimeInterval: String]   = [:]
        for event in plannedMorningEvents{
            dict[event.timestamp] = event.name
        }
        return dict
    }
    
}

struct TimeSection: View{
    
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

struct PlannedEventSection: View{
    
    var body: some View{
        HStack{
            VStack{
                Text("hello")
            }
            VStack{
                
            }
            VStack{
                
            }
        }

    }
}

struct ActualEventSection: View{
    
    var body: some View{
        Text("SleepingWorld")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
