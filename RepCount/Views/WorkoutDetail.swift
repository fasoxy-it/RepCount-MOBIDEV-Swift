//
//  WorkoutDetail.swift
//  RepCount
//
//  Created by Mattia Fasoli on 27/10/22.
//

import SwiftUI
import AVKit

struct WorkoutDetail: View {
    
    @State var player = AVPlayer()
    
    var workout: Workout
    var utility: Utility = Utility()
    
    var body: some View {
        ZStack {
            //Color.black.ignoresSafeArea()
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
                                    //.foregroundColor(.white)
                                Spacer()
                            }.padding(.bottom, 1)
                            HStack {
                                Image(systemName: "figure.stand")
                                    .font(.system(size: 20))
                                    .foregroundColor(.indigo)
                                Text(workout.muscle)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    //.foregroundColor(.white)
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
                                    //.foregroundColor(.white)
                                    .padding(.leading, 4)
                                Spacer()
                            }
                        }.padding(.leading, 10)
                    }
                    HStack {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.bold)
                            //.foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.top)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color("Gray"))
                        VStack {
                            HStack {
                                Text(workout.description)
                                    .font(.body)
                                    //.foregroundColor(.white)
                            }
                            .padding(.top, 1)
                            VStack {
                                HStack {
                                    VideoPlayer(player: player)
                                        .frame(height: 205)
                                        .onAppear() {
                                            player = AVPlayer(url: Bundle.main.url(forResource: workout.video, withExtension: "mp4")!)
                                            player.play()
                                        }
                                }
                            }.padding(.vertical, 5)
                            
                        }.padding(.all)
                    }
                    HStack {
                        Text("Attentions")
                            .font(.title2)
                            .fontWeight(.bold)
                            //.foregroundColor(.white)
                        Spacer()
                    }.padding(.top)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color("Gray"))
                        VStack {
                            HStack {
                                VStack {
                                    ForEach (workout.attentions, id: \.self) {
                                        attention in
                                        HStack {
                                            Label {
                                                Text(attention)
                                                    //.foregroundColor(.white)
                                                Spacer()
                                            } icon: {
                                                Image(systemName: "circle.fill")
                                                    .font(.system(size: 10))
                                                    //.foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                            }
                        }.padding(.all)
                    }
                    
                    HStack {
                        NavigationLink(destination: WorkoutControl(workout: workout)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(Color("Green"))
                                    .frame(height: 50)
                                Text("Start")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                        }.simultaneousGesture(TapGesture().onEnded {
                            utility.speak(string: "Start")
                        })
                    }.padding(.top)
                }.padding()
                    //.navigationTitle("")
                    //.navigationBarTitleDisplayMode(.inline)
            }//.padding(.top)
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
