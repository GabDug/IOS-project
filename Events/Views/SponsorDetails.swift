//
//  SponsorDetails.swift
//  Events
//
//  Created by Thibault Lepez on 31/03/2021.
//

import SwiftUI

struct SponsorDetails: View {
    var sponsor: Sponsor
    @State private var contact: [Speaker] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(sponsor.fields.name)
                        .font(.title)
                    
                    if (sponsor.fields.previousSponsor != nil) {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }
                
                
                Text("Sponsor for " + String(sponsor.fields.sponsoredAmount ?? 0) + " $")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                // TODO: transform contact ids into real contacts
                Group {
                    if (contact.count > 0) {
                        SpeakerRow(speakers: contact)
                    } else {
                        Text("No contact for this sponsor")
                    }
                }
                
                
            }
            .padding()
            
        }
        .navigationTitle(sponsor.fields.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            if (sponsor.fields.contactsId != nil) {
                sponsor.fields.contactsId?.forEach { id in
                    ApiService.call(
                        Speaker.self,
                        url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees/\(id)"
                    ) { data in
                        if (data != nil) {
                            contact.append(data!)
                        }
                    } errorHandler: { (error) in
                        // TODO: Do smth
                    }
                }
            }
        })
    }
}

struct SponsorDetails_Previews: PreviewProvider {
    static var previews: some View {
        SponsorDetails(sponsor: localSponsors[1])
    }
}
