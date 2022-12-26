//
//  WorkoutMistakeRow.swift
//  RepCount
//
//  Created by Mattia Fasoli on 04/11/22.
//

import SwiftUI

struct WorkoutMistakeRow: View {
    
    var mistake: String
    var count: Int

    @State private var showDetails = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("Gray"))
            VStack {
                HStack {
                    VStack {
                        if !showDetails {
                            Image(systemName: "chevron.down")
                                .font(.body)
                                .fontWeight(.bold)
                                //.foregroundColor(.white)
                                .onTapGesture {
                                    showDetails.toggle()
                                }
                        } else {
                            Image(systemName: "chevron.up")
                                .font(.body)
                                .fontWeight(.bold)
                                //.foregroundColor(.white)
                                .onTapGesture {
                                    showDetails.toggle()
                                }
                        }
                        
                    }
                    VStack {
                        Text(mistake)
                            .font(.body)
                            .fontWeight(.bold)
                            //.foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("Red"))
                                .frame(width: 110, height: 28)
                            Text("\(Int(count)) mistakes")
                                .font(.subheadline)
                                //.foregroundColor(.white)
                        }
                    }.padding(.leading)
                }
                if showDetails {
                    HStack {
                        Text(Workouts().workouts[1].mistakes["squat"]!)
                            .font(.body)
                            //.foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                }
                
            }.padding(.all)
        }
    }
}

struct WorkoutMistakeRow_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutMistakeRow(mistake: Workouts().workouts[1].mistakes["squat"]!, count: 0)
    }
}
