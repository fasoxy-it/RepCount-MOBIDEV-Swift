//
//  WorkoutControl.swift
//  RepCount
//
//  Created by Mattia Fasoli on 31/10/22.
//

import SwiftUI
import RealityKit
import AVFoundation

class ViewModel: ObservableObject {
    @Published var label: String = ""
    @Published var count: Double = 0.0
    @Published var countMistake: Double = 0.0
}

struct WorkoutControl: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    @State var isTimerRunning: Bool = true
    @State var timerCount: Double = 0.0
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    let synthesizer = AVSpeechSynthesizer()
    
    var workout: Workout
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ViewWrapper(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("Gray"))
                                .opacity(0.8)
                                .frame(height: 180)
                            VStack {
                                HStack {
                                    Text(viewModel.label)
                                    //Text(workout.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Spacer()
                                }.padding(.bottom, 10)
                                HStack {
                                    Image(systemName: "stopwatch.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color("Yellow"))
                                    Text("\(formatTimerMmSsMSms(counter: timerCount))")
                                        .font(.title3)
                                        .foregroundColor(Color("Yellow"))
                                        .onReceive(timer) { time in
                                            if isTimerRunning {
                                                timerCount += 0.01
                                            }
                                        }
                                    Spacer()
                                }.padding(.bottom, 5)
                                HStack {
                                    Image(systemName: "arrow.clockwise.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color("Green"))
                                    Text(String(format: "%.0f", viewModel.count))
                                    //Text("00")
                                        .font(.title3)
                                        .foregroundColor(Color("Green"))
                                    Spacer()
                                }.padding(.bottom, 5)
                                HStack {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color("Red"))
                                    Text(String(format: "%.0f", viewModel.countMistake))
                                    //Text("00")
                                        .font(.title3)
                                        .foregroundColor(Color("Red"))
                                    Spacer()
                                }
                            }.padding(.leading, 20)
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                        .font(.system(size: 38))
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            //
                                        }
                                }.padding(.bottom, 5)
                                HStack {
                                    Spacer()
                                    if isTimerRunning {
                                        Image(systemName: "pause.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                            .onTapGesture {
                                                let utterance = AVSpeechUtterance(string: "Stop")
                                                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                                synthesizer.speak(utterance)
                                                timer.upstream.connect().cancel()
                                                isTimerRunning = false
                                            }
                                    } else {
                                        Image(systemName: "play.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                            .onTapGesture {
                                                let utterance = AVSpeechUtterance(string: "Play")
                                                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                                synthesizer.speak(utterance)
                                                timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
                                                isTimerRunning = true
                                            }
                                    }
                                }.padding(.bottom, 5)
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: WorkoutSummary(workout: workout, timeing: timerCount, repetitions: Int(viewModel.count), mistakes: Int(viewModel.countMistake))) {
                                        Image(systemName: "x.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                    }.simultaneousGesture(TapGesture().onEnded {
                                        timer.upstream.connect().cancel()
                                    })
                                }
                            }.padding(.trailing, 20)
                        }.padding()
                    }
                }
            }
        }.toolbar(.hidden)
    }
}

struct WorkoutControl_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorkoutControl(workout: Workouts().workouts[0])
            WorkoutControl(workout: Workouts().workouts[1])
            WorkoutControl(workout: Workouts().workouts[2])
        }
    }
}

func formatTimerMmSsMSms(counter: Double) -> String {
    let minutes = Int(counter) / 60 % 60
    let seconds = Int(counter) % 60
    let milliseconds = Int(counter*1000) % 1000
    return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
}

class ViewController: UIViewController {
    
    var viewModel: ViewModel?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var videoCapture: VideoCapture!
    var videoProcessingChain: VideoProcessingChain!
    var actionFrameCounts = [String: Int]()
    var actionRepCounts = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoProcessingChain = VideoProcessingChain()
        videoProcessingChain.delegate = self
        
        videoCapture = VideoCapture()
        videoCapture.delegate = self
        
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
            //addFrameCount(frameCount, to: actionPrediction.label)
            addRepCount(frameCount, to: actionPrediction.label)
            //addRepCount(1, to: actionPrediction.label)
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
    
    private func addRepCount(_ repCount: Int, to actionLabel: String) {
        let totalReps = (actionRepCounts[actionLabel] ?? 0) + repCount
        actionRepCounts[actionLabel] = totalReps
        
        if actionLabel == "Jumping Jacks" {
            self.viewModel?.count = (Double(totalReps) / 40)
            //self.viewModel?.count = (Double(totalReps) / ExerciseClassifier.frameRate)
        } else if actionLabel == "Lunges" {
            self.viewModel?.countMistake = (Double(totalReps) / 55)
            //self.viewModel?.countMistake = (Double(totalReps) / ExerciseClassifier.frameRate)
        }
        
    }
    
    /*
    private func addFrameCount(_ frameCount: Int, to actionLabel: String) {
        let totalFrames = (actionFrameCounts[actionLabel] ?? 0) + frameCount
        actionFrameCounts[actionLabel] = totalFrames
    }
    */
    
    private func updateUILabelsWithPrediction(_ prediction: ActionPrediction) {
        DispatchQueue.main.async {
            if prediction.label == "Jumping Jacks" {
                self.viewModel?.label = prediction.label
            } else {
                self.viewModel?.label = "Different"
            }
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

struct ViewWrapper: UIViewControllerRepresentable {
    
    var viewModel: ViewModel
    
    func makeUIViewController(context: Context) -> ViewController {
        let mvc = ViewController()
        mvc.viewModel = viewModel
        return mvc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
    
}
