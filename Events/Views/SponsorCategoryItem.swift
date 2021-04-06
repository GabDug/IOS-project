//
//  SponsorCategoryItem.swift
//  Events
//
//  Created by Thibault Lepez on 30/03/2021.
//

import SwiftUI

struct SponsorCategoryItem: View {
    var sponsor: Sponsor
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .fill(ColorUtils.newColorFromId(userId: sponsor.id))
                    .frame(width: 155, height: 155)
                
                Text(NameUtils.initialsFromName(name: sponsor.fields.name))
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            Text(sponsor.fields.name)
                .foregroundColor(.primary)
                .frame(width: 155)
        }
        
    }
}

struct SponsorCategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        SponsorCategoryItem(
            sponsor: localSponsors[1]
        )
    }
}
