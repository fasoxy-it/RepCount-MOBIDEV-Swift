//
//  WorkoutSummary.swift
//  RepCount
//
//  Created by Mattia Fasoli on 02/11/22.
//

import SwiftUI

struct WorkoutSummary: View {
    
    var workout: Workout
    var timeing: Double
    var repetitions: Int
    var mistakes: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        HStack {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color("GreenDark").gradient)
                                        .frame(width: 85, height: 85)
                                    Image(systemName: workout.logo)
                                        .font(.system(size: 40))
                                        .foregroundColor(Color("Green"))
                                }
                            }
                            VStack {
                                HStack {
                                    Text(workout.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Spacer()
                                }.padding(.bottom, 1)
                                HStack {
                                    Image(systemName: "figure.stand")
                                        .font(.system(size: 20))
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
                                        .font(.system(size: 15))
                                        .foregroundColor(.orange)
                                    Text(workout.intensity)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.leading, 4)
                                    Spacer()
                                }
                            }.padding(.leading, 10)
                        }
                        HStack {
                            Text("Workout details")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }.padding(.top, 10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("Gray"))
                            VStack {
                                HStack {
                                    VStack {
                                        HStack {
                                            Text("Timeing")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("\(formatTimerMmSsMSms(counter: timeing))")
                                                .font(.title2)
                                                .foregroundColor(Color("Yellow"))
                                                .padding(.top, 1)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Repetitions")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text(String(repetitions))
                                                .font(.title2)
                                                .foregroundColor(Color("Green"))
                                                .padding(.top, 1)
                                            Spacer()
                                        }
                                    }
                                    VStack {
                                        HStack {
                                            Text("Accuracy")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("\(calculateAccuracy(repetitions: repetitions, mistakes: mistakes))%")
                                                .font(.title2)
                                                .foregroundColor(Color("Blue"))
                                                .padding(.top, 1)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Mistakes")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }.padding(.top, 5)
                                        HStack {
                                            Text(String(mistakes))
                                                .font(.title2)
                                                .foregroundColor(Color("Red"))
                                                .padding(.top, 1)
                                            Spacer()
                                        }
                                    }
                                }
                            }.padding(.all)
                        }
                        HStack {
                            Text("Mistake analysis")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }.padding(.top, 10)
                        ForEach (workout.mistakes, id: \.self) {
                            mistake in
                            WorkoutMistakeRow(mistake: mistake)
                        }
                        HStack {
                            NavigationLink(destination: ContentView()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color("Green"))
                                        .frame(height: 50)
                                    Text("Done")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                        }.padding(.top)
                    }
                    .padding()
                    .navigationTitle("Summary")
                }
            }
        }.toolbar(.hidden)
        
    }
}

struct WorkoutSummary_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutSummary(workout: Workouts().workouts[0], timeing: 14000, repetitions: 15, mistakes: 2)
            WorkoutSummary(workout: Workouts().workouts[1], timeing: 14000, repetitions: 15, mistakes: 2)
            WorkoutSummary(workout: Workouts().workouts[2], timeing: 14000, repetitions: 15, mistakes: 2)
        }
    }
}

func calculateAccuracy(repetitions: Int, mistakes: Int) -> Int {
    return 100 - ((mistakes * 100) / repetitions)
}
