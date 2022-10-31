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
            Rectangle()
                .foregroundColor(Color("Gray"))
            HStack {
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color("Color").gradient)
                            .frame(width: 45, height: 45)
                        Image(systemName: workout.logo)
                            .font(.system(size: 28))
                            .foregroundColor(Color("Green"))
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
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
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
