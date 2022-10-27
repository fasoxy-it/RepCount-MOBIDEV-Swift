//
//  WorkoutDetail.swift
//  RepCount
//
//  Created by Mattia Fasoli on 27/10/22.
//

import SwiftUI
import AVKit

struct WorkoutDetail: View {
    
    @State private var player = AVPlayer()
    
    var workout: Workout
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 100)
                            Image(systemName: workout.logo)
                                .font(.system(size: 50))
                                .foregroundColor(.green)
                        }
                    }
                    VStack {
                        HStack {
                            Text(workout.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }.padding(.bottom, 1)
                        HStack {
                            Image(systemName: "figure.stand")
                                .font(.system(size: 17))
                                .foregroundColor(.indigo)
                            Text(workout.muscle)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.leading, 5)
                            Spacer()
                        }.padding(.bottom, 1)
                        HStack {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 17))
                                .foregroundColor(.orange)
                            Text(workout.intensity)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }.padding(.leading, 10)
                }
                HStack {
                    Text("Description")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.top, 5)
                HStack {
                    Text(workout.description)
                        .font(.body)
                        .foregroundColor(.white)
                }
                HStack {
                    VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: workout.video, withExtension: "mp4")!))
                }
                HStack {
                    Text("Attentions")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.top, 5)
            }.padding(.horizontal)
        }
    }
}

struct WorkoutDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutDetail(workout: Workouts().workouts[0])
            WorkoutDetail(workout: Workouts().workouts[1])
            WorkoutDetail(workout: Workouts().workouts[2])
        }
    }
}
