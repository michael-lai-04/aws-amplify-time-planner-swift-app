//
//  HomeScheduleView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 23/1/2023.
//

import SwiftUI

struct SectionTitle: Identifiable{
let id = UUID()
let name: String
}

struct HomeScheduleView: View {
    @State private var selection = 1
    @State private var scheduleDate = Date()
    
    let dateHelper = DateHelper()
    
    let sectionTitles:[SectionTitle] = [
        SectionTitle(name: "Planned"),
        SectionTitle(name: "Time"),
        SectionTitle(name: "Actual")
]
    
    func addOneDayToScheduleDate() {

        var dateComponent = DateComponents()
        dateComponent.day = 1
        let newDate = Calendar.current.date(byAdding: dateComponent, to: scheduleDate)
        scheduleDate = newDate!
    }
    
    func subtractOneDayToScheduleDate(){

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
                PlannedEventSectionView()
                    .tag(0)
                TimeSectionView(scheduleDate: $scheduleDate)
                    .tag(1)
                ActualEventSectionView()
                    .tag(2)

            }
            .tabViewStyle(
                .page(indexDisplayMode: .never))
        }
            }

                    .toolbar{
                        ToolbarItem(placement: .principal){
                            HStack{
                                DatePicker(selection:$scheduleDate, displayedComponents: .date){
                                    Button{
                                        subtractOneDayToScheduleDate()
                                    }label:{
                                        Image(systemName:"arrow.left")
                                    }.buttonStyle(.plain)
                                }.fixedSize().frame(alignment:.leading).id(scheduleDate)
                                   
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

struct HomeScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScheduleView()
    }
}
