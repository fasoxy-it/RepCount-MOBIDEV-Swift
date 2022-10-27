//
//  WorkoutRow.swift
//  RepCount
//
//  Created by Mattia Fasoli on 27/10/22.
//

import SwiftUI

struct WorkoutRow: View {
    
    var workout: Workout
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            HStack {
                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 75, height: 75)
                        Image(systemName: workout.logo)
                            .font(.system(size: 34))
                            .foregroundColor(.green)
                    }
                }
                VStack {
                    HStack {
                        Text(workout.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    HStack {
                        Text(workout.muscle)
                            .font(.body)
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutRow(workout: Workouts().workouts[0])
            WorkoutRow(workout: Workouts().workouts[1])
            WorkoutRow(workout: Workouts().workouts[2])
        }
    }
}
