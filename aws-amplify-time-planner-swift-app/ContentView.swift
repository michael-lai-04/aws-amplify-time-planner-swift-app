//
//  ContentView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 14/1/2023.
//

import SwiftUI

struct ContentView: View {
    let coreDM = CoreDataManager()
    
    var body: some View {
        TabView{
            HomeScheduleView()
                .tabItem{
                    Image(systemName:"clock")
                    Text("Schedule")
                }
            SettingView()
                .tabItem{
                    Image(systemName: "gearshape")
                    Text("Setting")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
