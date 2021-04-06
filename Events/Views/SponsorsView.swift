//
//  SponsorsView.swift
//  Events
//
//  Created by Gabriel on 30/03/2021.
//

import SwiftUI

struct SponsorsView: View {
    @State private var sponsors: [Sponsor] = []
    @State private var categorizedSponsors: [String: [Sponsor]] = Dictionary()
    
    var body: some View {
        NavigationView {
            HStack {
                ZStack {
                    BackgroundView()
                    // TODO: categorize sponsors
                    ScrollView{
                        ForEach(Array(categorizedSponsors.keys), id: \.self) { key in
                            SponsorsCategoryRow(categoryName: key, items: categorizedSponsors[key] ?? [])
                                .padding(.top)
                        }
                    }
                    
                    .navigationTitle("Sponsors")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            ApiService.call(RootSponsors.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors") { (data) in
                sponsors = data?.sponsors ?? []
                if (sponsors.count > 0) {
                    categorizedSponsors = Dictionary(
                        grouping: sponsors,
                        by: { $0.fields.status }
                    )
                }
            } errorHandler: { (error) in
                // TODO: Display something
            }
        })
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
    }
}
