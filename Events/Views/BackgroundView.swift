//
//  BackgroundView.swift
//  Events
//
//  Created by Gabriel on 31/03/2021.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        // Background gradient
        LinearGradient(gradient: Gradient(colors: [Color.pinkColor, Color.purpleColor]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        // Background Circles
        VStack {
            Capsule()
                .fill(Color.OrangeColor)
                .frame(width: 200, height: 200)
                .offset(x: -150, y: -55)
            Spacer()
            Capsule()
                .fill(Color.OrangeColor)
                .frame(width: 200, height: 200)
                .offset(x: 150, y: 105)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
