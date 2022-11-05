//
//  WorkoutMistakeRow.swift
//  RepCount
//
//  Created by Mattia Fasoli on 04/11/22.
//

import SwiftUI

struct WorkoutMistakeRow: View {
    
    var attention: String

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
                                .foregroundColor(.white)
                                .onTapGesture {
                                    showDetails.toggle()
                                }
                        } else {
                            Image(systemName: "chevron.up")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    showDetails.toggle()
                                }
                        }
                        
                    }
                    VStack {
                        Text("Incline")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("Red"))
                                .frame(height: 28)
                            Text("?? mistakes")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }.padding(.leading, 170)
                }
                if showDetails {
                    HStack {
                        Text(attention)
                            .font(.body)
                            .foregroundColor(.white)
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
        WorkoutMistakeRow(attention: Workouts().workouts[0].attentions[0])
    }
}
