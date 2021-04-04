//
//  SponsorDetails.swift
//  Events
//
//  Created by Thibault Lepez on 31/03/2021.
//

import SwiftUI

struct SponsorDetails: View {
    var sponsor: Sponsor
    
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
                if (sponsor.fields.contactsId != nil) {
                    Text("Contacts")
                        .font(.headline)
                    
                    ForEach(sponsor.fields.contactsId ?? [], id: \.self) { contact in
                        Text(contact)
                    }
                }
                
                
            }
            .padding()
            
        }
        .navigationTitle(sponsor.fields.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SponsorDetails_Previews: PreviewProvider {
    static var previews: some View {
        SponsorDetails(sponsor: localSponsors[1])
    }
}
