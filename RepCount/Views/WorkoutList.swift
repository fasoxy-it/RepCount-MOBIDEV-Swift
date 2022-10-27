//
//  WorkoutList.swift
//  RepCount
//
//  Created by Mattia Fasoli on 27/10/22.
//

import SwiftUI

struct WorkoutList: View {
    var body: some View {
        NavigationView {
            List(Workouts().workouts) {workout in
                NavigationLink {
                    WorkoutDetail(workout: workout)
                } label: {
                    WorkoutRow(workout: workout)
                }
                .listRowBackground(Color.black)
            }
            .navigationTitle("Workouts")
        }
        .environment(\.colorScheme, .dark)
        .accentColor(.white)
    }
}

struct WorkoutList_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutList()
    }
}
