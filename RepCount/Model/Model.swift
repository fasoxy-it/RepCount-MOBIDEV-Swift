//
//  Model.swift
//  RepCount
//
//  Created by Mattia Fasoli on 27/10/22.
//

import Foundation
import AVFoundation

struct Workout: Hashable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var logo: String
    var description: String
    var video: String
    var muscle: String
    var intensity: String
    var attentions: [String]
    var mistakes: [String: String]
}

struct Workouts {
    
    var workouts: [Workout] = []

    init() {
        workouts.append(Workout(name: "Push Up", logo: "figure.wrestling", description: "In an earlier time, the push-up was largely regarded as a measure of a person’s strength and fitness. In more modern times, much of this reputation has been passed on to the bench press, but the push-up’s passing misses the great opportunity to master a gateway movement to one of the most developmental progressions in all of fitness", video: "pushups", muscle: "Chest, Arms", intensity: "Low", attentions: ["Hands approximately shoulder-width apart", "Legs together with only the balls of the feet on the ground", "Start with arms extended", "Body remains rigid", "Lower chest and thighs to the ground", "Elbows in close to the body", "Complete at full arm extension"], mistakes: ["": ""]))
        workouts.append(Workout(name: "Squat", logo: "figure.cross.training", description: "The squat is a beautiful, natural movement. It demands midline stabilization, posterior-chain engagement and core-to-extremity movement, and it can be used to move your body weight or very large loads held in a variety of positions. At one end of the spectrum, the squat is an essential component of weightlifting and powerlifting, and at the other end, the squat is essential to getting off a toilet seat. Regardless of what the problem is, the answer is to squat.", video: "squats", muscle: "Legs", intensity: "Low", attentions: ["Shoulder-width stance", "Knees in line with toes", "Lumbar curve maintained", "Hips descend back and down", "Hips descend lower than knees", "Heel down", "Complete a full hip and knee extension"], mistakes: ["Knees": "One common mistake people make with half-squats is allowing their knees to move past their toes. This can put extra stress on the knee joint and increase the risk of injury. To perform a proper half-squat, start with your feet shoulder-width apart, engage your core, and slowly lower your hips down and back while keeping your knees behind your toes. This will help ensure that your knees are in a safe position and that you're engaging your leg muscles in the most effective way possible. If you find that your knees are still moving too far forward, you may need to adjust your foot positioning or seek guidance from a fitness professional to ensure proper form.", "Back": "Lumbar curve not maintained", "Heels": "Heels not down", "Halfsquat": "The mistake in a half-squat is not going low enough. Many people make the mistake of only lowering their body a small amount when performing a half-squat, which means they're not fully engaging the muscles in their legs and glutes. To get the most out of this exercise, it's important to lower your body until your thighs are at least parallel to the ground, which will engage more of the leg muscles and provide greater strength-building benefits."]))
        workouts.append(Workout(name: "Sit Up", logo: "figure.rower", description: "There is an adjunct movement to GHD sit-ups in which the athlete is dynamic in the trunk and static in the hip. It is the AbMat sit-up, where we deliberately take the hip flexors out of the equation and work the torso dynamically. The two sit-ups, GHD and AbMat, complement each other beautifully. One is dynamic in the hips and static in the trunk; the other is dynamic in the trunk and static in the hip. In conjunction with the L-sit (static in the trunk and hip), they develop a formidable capacity in the midline.", video: "situps", muscle: "Abs", intensity: "Low", attentions: ["Abmat fills the gap between the lumbar curve and ground", "Start with feet together and shoulders on the ground", "Pull torso to seated with as little momentum as possible", "Complete when seated with shoulders over hips, spine extended", "Slowly lower to the ground for the next rep"], mistakes: ["": ""]))
    }
}
