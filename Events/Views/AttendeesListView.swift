//
//  AttendeesListView.swift
//  Events
//
//  Created by Ruben on 06/04/2021.
//

import SwiftUI

struct AttendeesListView: View {
    @State private var attendees: Array<Speaker> = []
    
    private var twoColumnsGrid: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        NavigationView {
            HStack {
                ZStack {
                    BackgroundView()
                    
                    ScrollView {
                        LazyVGrid(columns: twoColumnsGrid) {
                            ForEach(attendees) { attendee in
                                SpeakerListItem(speaker: attendee)
                            }
                        }
                    }
                    
                    .navigationTitle("Attendees")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            ApiService.call(RootSpeaker.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees?filterByFormula=SEARCH(%22Attendee%22%2CType)") { data in
                attendees = data?.speakers ?? []
            }
        })
    }
}

struct AttendeesListView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeesListView()
    }
}
