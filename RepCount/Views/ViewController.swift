//
//  ViewController.swift
//  RepCount
//
//  Created by Mattia Fasoli on 10/11/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private var actionLabel: UILabel = {
        let actionLabel = UILabel()
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        actionLabel.textColor = .black
        //actionLabel.text = "Hello, UIKit!"
        actionLabel.textAlignment = .center
        
        return actionLabel
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "example")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var videoCapture: VideoCapture!
    var videoProcessingChain: VideoProcessingChain!
    var actionFrameCounts = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoProcessingChain = VideoProcessingChain()
        videoProcessingChain.delegate = self
        
        videoCapture = VideoCapture()
        videoCapture.delegate = self
        
        view.addSubview(actionLabel)
        NSLayoutConstraint.activate([
            actionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            actionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
    }
    
}

extension ViewController: VideoCaptureDelegate {
    
    func videoCapture(_ videoCapture: VideoCapture, didCreate framePublisher: FramePublisher) {
        updateUILabelsWithPrediction(.startingPrediction)
        videoProcessingChain.upstreamFramePublisher = framePublisher
    }
    
}

extension ViewController: VideoProcessingChainDelegate {
    
    func videoProcessingChain(_ chain: VideoProcessingChain, didPredict actionPrediction: ActionPrediction, for frameCount: Int) {
        if actionPrediction.isModelLabel {
            addFrameCount(frameCount, to: actionPrediction.label)
        }
        updateUILabelsWithPrediction(actionPrediction)
    }
    
    func videoProcessingChain(_ chain: VideoProcessingChain, didDetect poses: [Pose]?, in frame: CGImage) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.drawPoses(poses, onto: frame)
        }
    }
    
}

extension ViewController {
    
    private func addFrameCount(_ frameCount: Int, to actionLabel: String) {
        let totalFrames = (actionFrameCounts[actionLabel] ?? 0) + frameCount
        actionFrameCounts[actionLabel] = totalFrames
    }
    
    private func updateUILabelsWithPrediction(_ prediction: ActionPrediction) {
        DispatchQueue.main.async {
            self.actionLabel.text = prediction.label
        }
    }
    
    private func drawPoses(_ poses: [Pose]?, onto frame: CGImage) {
        
        let renderFormat = UIGraphicsImageRendererFormat()
        renderFormat.scale = 1.0
        
        let frameSize = CGSize(width: frame.width, height: frame.height)
        let poseRender = UIGraphicsImageRenderer(size: frameSize, format: renderFormat)
        
        let frameWithPoseRendering = poseRender.image {
            renderContext in
            
            let cgContext = renderContext.cgContext
            let inverse = cgContext.ctm.inverted()
            
            cgContext.concatenate(inverse)
            
            let imageRectangle = CGRect(origin: .zero, size: frameSize)
            cgContext.draw(frame, in: imageRectangle)
            
            let pointTransform = CGAffineTransform(scaleX: frameSize.width, y: frameSize.height)
            
            guard let poses = poses else { return }
            
            for pose in poses {
                pose.drawWireframeToContext(cgContext, applying: pointTransform)
            }
        }
        DispatchQueue.main.async {
            self.imageView.image = frameWithPoseRendering
        }
    }
    
}

