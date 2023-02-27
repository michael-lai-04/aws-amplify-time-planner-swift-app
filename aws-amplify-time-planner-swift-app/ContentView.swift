//
//  ContentView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 14/1/2023.
//

import SwiftUI

struct ContentView: View {

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
        .onAppear{
            NotificationManager.instance.requestAuthorization()
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
