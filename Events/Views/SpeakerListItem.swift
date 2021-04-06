//
//  SpeakerListItem.swift
//  Events
//
//  Created by Ruben on 31/03/21.
//

import SwiftUI

struct SpeakerListItem: View {
    var speaker: Speaker
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(ColorUtils.newColorFromId(userId: speaker.id)) 
                .frame(width: 155, height: 155)
            
            Text(speaker.fields.name)
                .foregroundColor(.white)
        }
    }
}

struct SpeakerListItem_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerListItem(
            speaker: localSpeakers[0]
        )
    }
}