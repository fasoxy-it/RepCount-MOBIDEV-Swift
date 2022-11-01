//
//  ARViewModel.swift
//  RepCount
//
//  Created by Mattia Fasoli on 01/11/22.
//

import Foundation
import RealityKit


class ARViewModel: ObservableObject {
    
    @Published private var model : ARModel = ARModel()
    
    var arView : ARView {
        model.arView
    }
    
    func switchCamera() {
        model.switchCamera()
    }
    
}
