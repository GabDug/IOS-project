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
            HStack {
                ZStack {
                    BackgroundView()
                    // TODO: categorize sponsors
                    ScrollView{
                        ForEach(sponsors) { sponsor in
                            SponsorsCategoryRow(categoryName: sponsor.fields.status, items: sponsors)
                        }
                    }
                    
                    .navigationTitle("Sponsors")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
    }
}
