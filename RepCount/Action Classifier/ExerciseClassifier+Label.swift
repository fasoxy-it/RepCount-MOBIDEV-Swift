//
//  ExerciseClassifier+Label.swift
//  RepCount
//
//  Created by Mattia Fasoli on 07/11/22.
//

extension SquatClassifier {
    /// Represents the app's knowledge of the Exercise Classifier model's labels.
    enum Label: String, CaseIterable {
        case squat = "Squat"
        case knees = "Knees"
        case halfsquat = "Halfsquat"

        /// A negative class that represents irrelevant actions.
        case none = "None"

        /// Creates a label from a string.
        /// - Parameter label: The name of an action class.
        init(_ string: String) {
            guard let label = Label(rawValue: string) else {
                let typeName = String(reflecting: Label.self)
                fatalError("Add the `\(string)` label to the `\(typeName)` type.")
            }

            self = label
        }
    }
}
