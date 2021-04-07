//
//  SpeakersAttendeesView.swift
//  Events
//
//  Created by user187551 on 3/31/21.
//

import SwiftUI

struct SpeakersAttendeesView: View {
    var speakers: [Speaker]
    
    var body: some View {
        ZStack {
            BackgroundView()
        ScrollView {
            HStack {
                ForEach(speakers, id: \.self) { speaker in
                    SpeakerListItem(speaker: speaker)
                }
            }
        }
        }}
}

struct SpeakersAttendeesView_Previews: PreviewProvider {
    // Fake local data JSON
    static var previews: some View {
        SpeakersAttendeesView(speakers: localSpeakers)
    }
}
