//
//  ViewWrapper.swift
//  RepCount
//
//  Created by Mattia Fasoli on 07/11/22.
//

import Foundation
import SwiftUI

struct ViewWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ViewController {
        let mvc = ViewController()
        return mvc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
    
}
