//
//  ContentView.swift
//  RepCount
//
//  Created by Mattia Fasoli on 27/10/22.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        ZStack {
            WorkoutList()
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
