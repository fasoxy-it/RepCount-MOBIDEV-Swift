//
//  WorkoutControl.swift
//  RepCount
//
//  Created by Mattia Fasoli on 31/10/22.
//

import SwiftUI
import RealityKit

struct WorkoutControl: View {
    
    @State var isTimerRunning: Bool = true
    @State var timerCount: Double = 0.0
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    
    var workout: Workout
    
    var body: some View {
        NavigationView {
            ZStack {
                ARViewContainer(arViewModel: arViewModel)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("Gray"))
                                .opacity(0.8)
                                .frame(height: 180)
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
                                        .foregroundColor(Color("Yellow"))
                                    Text("\(formatTimerMmSsMSms(counter: timerCount))")
                                        .font(.title3)
                                        .foregroundColor(Color("Yellow"))
                                        .onReceive(timer) { time in
                                            if isTimerRunning {
                                                timerCount += 0.01
                                            }
                                        }
                                    Spacer()
                                }.padding(.bottom, 5)
                                HStack {
                                    Image(systemName: "arrow.clockwise.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color("Green"))
                                    Text("00")
                                        .font(.title3)
                                        .foregroundColor(Color("Green"))
                                    Spacer()
                                }.padding(.bottom, 5)
                                HStack {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color("Red"))
                                    Text("00")
                                        .font(.title3)
                                        .foregroundColor(Color("Red"))
                                    Spacer()
                                }
                            }.padding(.leading, 20)
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                        .font(.system(size: 38))
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            arViewModel.switchCamera()
                                        }
                                }.padding(.bottom, 5)
                                HStack {
                                    Spacer()
                                    if isTimerRunning {
                                        Image(systemName: "pause.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                            .onTapGesture {
                                                timer.upstream.connect().cancel()
                                                isTimerRunning = false
                                            }
                                    } else {
                                        Image(systemName: "play.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                            .onTapGesture {
                                                timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
                                                isTimerRunning = true
                                            }
                                    }
                                }.padding(.bottom, 5)
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: WorkoutSummary(workout: workout, timeing: timerCount, repetitions: 25, mistakes: 0)) {
                                        Image(systemName: "x.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                    }.simultaneousGesture(TapGesture().onEnded {
                                        timer.upstream.connect().cancel()
                                    })
                                }
                            }.padding(.trailing, 20)
                        }.padding()
                    }
                }
            }
        }.toolbar(.hidden)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    var arViewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        
        return arViewModel.arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
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

func formatTimerMmSsMSms(counter: Double) -> String {
    let minutes = Int(counter) / 60 % 60
    let seconds = Int(counter) % 60
    let milliseconds = Int(counter*1000) % 1000
    return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
}
