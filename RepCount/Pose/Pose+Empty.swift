//
//  Pose+Empty.swift
//  RepCount
//
//  Created by Mattia Fasoli on 07/11/22.
//

import CoreML

extension Pose {
    /// A multiarray with the same dimensions as human body pose
    /// that sets each element to zero.
    ///
    /// This instance has the same shape as the multiarray from a
    /// `VNHumanBodyPoseObservation` instance.
    /// - Tag: emptyPoseMultiArray
    static let emptyPoseMultiArray = zeroedMultiArrayWithShape([1, 3, 18])

    /// Creates a multiarray and assigns zero to every element.
    /// - Returns: An `MLMultiArray`.
    private static func zeroedMultiArrayWithShape(_ shape: [Int]) -> MLMultiArray {
        // Create the multiarray.
        guard let array = try? MLMultiArray(shape: shape as [NSNumber],
                                            dataType: .double) else {
            fatalError("Creating a multiarray with \(shape) shouldn't fail.")
        }

        // Get a pointer to quickly set the array's values.
        guard let pointer = try? UnsafeMutableBufferPointer<Double>(array) else {
            fatalError("Unable to initialize multiarray with zeros.")
        }

        // Set every element to zero.
        pointer.initialize(repeating: 0.0)
        return array
    }
}
