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
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ScrollView {
                    ForEach (Workouts().workouts) { workout in
                        NavigationLink {
                            WorkoutDetail(workout: workout)
                        } label: {
                            WorkoutRow(workout: workout)
                        }
                    }
                }
                    .padding(.horizontal)
                    .navigationTitle("Workouts")
            }
        }
        .toolbar(.hidden)
        .accentColor(.white)
    }
}

struct WorkoutList_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutList()
    }
}
