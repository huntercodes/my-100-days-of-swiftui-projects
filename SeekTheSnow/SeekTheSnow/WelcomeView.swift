//
//  WelcomeView.swift
//  SeekTheSnow
//
//  Created by hunter downey on 1/27/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text("Welcome to Seek The Snow!")
                .font(.largeTitle)
            Spacer()
            Text("Please select a resort from the left-hand menu: swipe from the left edge to show it!")
                .font(.title2)
                .foregroundColor(.secondary)
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
