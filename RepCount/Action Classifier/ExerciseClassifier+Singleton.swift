//
//  ExerciseClassifier+Singleton.swift
//  RepCount
//
//  Created by Mattia Fasoli on 07/11/22.
//

import CoreML

extension SquatClassifier {
    /// Creates a shared Exercise Classifier instance for the app at launch.
    static let shared: SquatClassifier = {
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()

        // Create an Exercise Classifier instance.
        guard let squatClassifier = try? SquatClassifier(configuration: defaultConfig) else {
            // The app requires the action classifier to function.
            fatalError("Squat Classifier failed to initialize.")
        }

        // Ensure the Exercise Classifier.Label cases match the model's classes.
        squatClassifier.checkLabels()

        return squatClassifier
    }()
}
