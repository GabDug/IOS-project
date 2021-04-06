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
        NavigationLink(destination: PersonView(person: speaker)) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .fill(ColorUtils.newColorFromId(userId: speaker.id))
                        .frame(width: 155, height: 155)
                    
                    Text(NameUtils.initialsFromName(name: speaker.fields.name))
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Text(speaker.fields.name)
                    .foregroundColor(.primary)
                    .frame(width: 155)
                    .lineLimit(1)
            }
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
