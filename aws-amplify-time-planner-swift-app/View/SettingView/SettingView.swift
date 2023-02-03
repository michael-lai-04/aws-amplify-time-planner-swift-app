//
//  SettingView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 31/1/2023.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List{
    
            Button{
                print("pressed")
            }label: {
                Text("Theme")
            }
            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
