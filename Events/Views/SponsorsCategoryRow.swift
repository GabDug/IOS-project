//
//  SponsorsCategoryRow.swift
//  Events
//
//  Created by Thibault Lepez on 30/03/2021.
//

import SwiftUI

struct SponsorsCategoryRow: View {
    var categoryName: String
    var items: [Sponsor]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(categoryName)
                    .font(.headline)
            }
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top ) {
                    ForEach(items) { sponsor in
                        NavigationLink(destination: SponsorDetails(sponsor: sponsor)) {
                            SponsorCategoryItem(sponsor: sponsor)
                        }
                        
                    }
                    .padding(.leading)
                }
            }
            .frame(height:185)
        }
    }
}

struct SponsorsCategoryRow_Previews:
    PreviewProvider {
    // Fake local data with JSON
    static var previews: some View {
        SponsorsCategoryRow(
            categoryName: "Pledged",
            items: localSponsors
        )
        .previewLayout(.fixed(width: 400, height: 300))
    }
}
