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
    
    let sectionTitles:[SectionTitle] = [
        SectionTitle(name: "Planned"),
        SectionTitle(name: "Time"),
        SectionTitle(name: "Actual")
]
    
    var body: some View {
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
        .background{
            Color("#F8F5ED")
    }
    }
}

struct TimeSection: View{
    
    var body: some View {
            HStack(alignment: .top, spacing: 100){
                VStack(){
                    Text("hello")
                }
                VStack{
                    Text("hello")
                    Text("hello")
                    Text("hello")

                }
                VStack{
                    Text("hello")

                }
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
