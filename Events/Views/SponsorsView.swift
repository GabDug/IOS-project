//
//  SponsorsView.swift
//  Events
//
//  Created by Gabriel on 30/03/2021.
//

import SwiftUI

struct SponsorsView: View {
    var body: some View {
        NavigationView {
            // TODO: categorize sponsors
            List(sponsors) { sponsor in
                SponsorsCategoryRow(categoryName: sponsor.fields.status, items: sponsors)

            }
            .navigationTitle("Sponsors")
        }
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
    }
}
