//
//  Model.swift
//  RepCount
//
//  Created by Mattia Fasoli on 27/10/22.
//

import Foundation

struct Workout {
    var name: String
    var logo: String
    var description: String
    var video: String
    var muscle: String
    var intensity: String
    var attentions: [String]
}

struct Workouts {
    
    var workouts: [Workout] = []

    init() {
        workouts.append(Workout(name: "Push Ups", logo: "figure.walk", description: "In an earlier time, the push-up was largely regarded as a measure of a person’s strength and fitness. In more modern times, much of this reputation has been passed on to the bench press, but the push-up’s passing misses the great opportunity to master a gateway movement to one of the most developmental progressions in all of fitness", video: "pushups", muscle: "Chest, Arms", intensity: "Low", attentions: ["Hands approximately shoulder-width apart", "Legs together with only the balls of the feet on the ground", "Start with arms extended", "Body remains rigid", "Lower chest and thighs to the ground", "Elbows in close to the body", "Complete at full arm extension"]))
        workouts.append(Workout(name: "Squats", logo: "figure.walk", description: "The squat is a beautiful, natural movement. It demands midline stabilization, posterior-chain engagement and core-to-extremity movement, and it can be used to move your body weight or very large loads held in a variety of positions. At one end of the spectrum, the squat is an essential component of weightlifting and powerlifting, and at the other end, the squat is essential to getting off a toilet seat. Regardless of what the problem is, the answer is to squat.", video: "squats", muscle: "Legs", intensity: "Low", attentions: ["Shoulder-width stance", "Knees in line with toes", "Lumbar curve maintained", "Hips descend back and down"]))
        workouts.append(Workout(name: "Sit Ups", logo: "figure.walk", description: "There is an adjunct movement to GHD sit-ups in which the athlete is dynamic in the trunk and static in the hip. It is the AbMat sit-up, where we deliberately take the hip flexors out of the equation and work the torso dynamically. The two sit-ups, GHD and AbMat, complement each other beautifully. One is dynamic in the hips and static in the trunk; the other is dynamic in the trunk and static in the hip. In conjunction with the L-sit (static in the trunk and hip), they develop a formidable capacity in the midline.", video: "situps", muscle: "Abs", intensity: "Low", attentions: ["Abmat fills the gap between the lumbar curve and ground", "Start with feet together and shoulders on the ground", "Pull torso to seated with as little momentum as possible", "Complete when seated with shoulders over hips, spine extended", "Slowly lower to the ground for the next rep"]))
    }
}
