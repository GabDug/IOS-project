//
//  SpeakerRow.swift
//  Events
//
//  Created by user187551 on 4/1/21.
//

import SwiftUI

struct SpeakerRow: View {
    var speakers: [Speaker]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Speakers")
                    .font(.headline)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top ) {
                    ForEach(speakers) { speaker in
                        SpeakerListItem(speaker: speaker)
                    }
                }
            }
            .frame(height:185)
        }
    }
}

struct SpeakerRow_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerRow(speakers: speakers)
    }
}
