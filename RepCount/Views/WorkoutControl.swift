//
//  WorkoutControl.swift
//  RepCount
//
//  Created by Mattia Fasoli on 31/10/22.
//

import SwiftUI

struct WorkoutControl: View {
    
    var workout: Workout
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("Gray"))
                .blendMode(.destinationOut)
            VStack {
                HStack {
                    Text(workout.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.bottom, 10)
                HStack {
                    Image(systemName: "stopwatch.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.yellow)
                    Text("00.00.00")
                        .font(.title3)
                        .foregroundColor(.yellow)
                    Spacer()
                }.padding(.bottom, 5)
                HStack {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.green)
                    Text("00")
                        .font(.title3)
                        .foregroundColor(.green)
                    Spacer()
                }.padding(.bottom, 5)
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.red)
                    Text("00")
                        .font(.title3)
                        .foregroundColor(.red)
                    Spacer()
                }
            }.padding(.leading, 20)
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .font(.system(size: 38))
                        .foregroundColor(.white)
                }.padding(.bottom, 5)
                HStack {
                    Spacer()
                    Image(systemName: "pause.circle.fill")
                        .font(.system(size: 38))
                        .foregroundColor(.white)
                }.padding(.bottom, 5)
                HStack {
                    Spacer()
                    Image(systemName: "x.circle.fill")
                        .font(.system(size: 38))
                        .foregroundColor(.white)
                }
            }.padding(.trailing, 20)
        }.padding()
    }
}

struct WorkoutControl_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutControl(workout: Workouts().workouts[0])
            WorkoutControl(workout: Workouts().workouts[1])
            WorkoutControl(workout: Workouts().workouts[2])
        }
    }
}
