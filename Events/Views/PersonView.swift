//
//  PersonView.swift
//  Events
//
//  Created by Ruben on 06/04/2021.
//

import SwiftUI

struct PersonView: View {
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    var person: Speaker
    @State private var company: Sponsor = localSponsors[0]
    
    init (person: Speaker) {
        self.person = person
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    HStack {
                        Text(person.fields.name)
                            .font(.title)
                        
                        if (person.fields.status != nil && person.fields.status == "Confirmed") {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    
                    Text(person.fields.type)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                Text("About")
                    .font(.title2)
                
                Group {
                    HStack {
                        Text("\(person.fields.role)")
                            .font(.body)
                            .fontWeight(.bold)
                        
                        Text("at:")
                            .font(.body)
                    }
                    
                    Text("\(company.fields.name)")
                        .font(.body)
                        .fontWeight(.bold)
                }
                
                Divider()
                
                if (person.fields.type == "Speaker") {
                    Text("Contact")
                        .font(.title2)
                    
                    Group {
                        HStack {
                            Text("Email: ").font(.body)
                            Text(person.fields.email!).font(.body)
                        }
                        
                        HStack {
                            Text("Tel.: ").font(.body)
                            Text(person.fields.phone!).font(.body)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(person.fields.name)
        .navigationBarTitleDisplayMode(.inline)
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: titleBanner, detail: messageBanner, type: .error), show: $showOverlay)
                 , show: $showOverlay)
        .onAppear(perform: {
            ApiService.call(Sponsor.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors/\(person.fields.company[0])") { (data) in
                if (data != nil) {
                    company = data!
                }
            } errorHandler: { (error) in
                withAnimation { () -> Void in
                    switch (error) {
                    case .none:
                        break
                    case .some(.apiError(_, _)):
                        self.messageBanner = "An issue occured when querying the API"
                        break
                    case .some(.httpError(_)):
                        self.messageBanner = "We couldn't reach the API"
                        break
                    case .some(.parseError(_, _)):
                        self.messageBanner = "An issue occured while parsing the data"
                        break
                    }
                    
                    self.showOverlay = true
                }
            }
        })
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: localSpeakers[0])
    }
}
