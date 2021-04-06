//
//  ContentView.swift
//  Events
//
//  Created by Gabriel on 30/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            ActivitesList(activities: nil)
                .padding(.all, 0.0)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                    
                }
            SponsorsView()
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Sponsors")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

