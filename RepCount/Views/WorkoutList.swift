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
            List(Workouts().workouts) { workout in
                NavigationLink {
                    WorkoutDetail(workout: workout)
                } label: {
                    WorkoutRow(workout: workout)
                }
                //.listRowBackground(Color.black)
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .navigationBarTitle("Workouts")
            //.toolbarColorScheme(.dark, for: .navigationBar)
            //.toolbarBackground(Color.black, for: .navigationBar)
            //.toolbarBackground(.visible, for: .navigationBar)
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
