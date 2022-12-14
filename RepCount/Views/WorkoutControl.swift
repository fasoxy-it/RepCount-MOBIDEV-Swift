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
    
    @Published var count: Int = 0
    @Published var countMistake: Int = 0
    @Published var countActionRepetitions = [String: Int]()
    
    @Published var camera = false
    @Published var prediction = true
    
}

struct WorkoutControl: View {
    
    @StateObject var viewModel = ViewModel()
    
    @State var isTimerRunning: Bool = true
    @State var timerCount: Double = 0.0
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    //let synthesizer = AVSpeechSynthesizer()
    
    var workout: Workout
    var utility: Utility = Utility()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ViewWrapper(viewModel: viewModel, workout: workout)
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
                                    Text(workout.name)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        //.foregroundColor(.white)
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
                                    Text(String(viewModel.count))
                                        .font(.title3)
                                        .foregroundColor(Color("Green"))
                                    Spacer()
                                }.padding(.bottom, 5)
                                HStack {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(Color("Red"))
                                    Text(String(viewModel.countMistake))
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
                                            utility.speak(string: "Change")
                                            viewModel.camera = true
                                        }
                                }.padding(.bottom, 5)
                                HStack {
                                    Spacer()
                                    if isTimerRunning {
                                        Image(systemName: "pause.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                            .onTapGesture {
                                                utility.speak(string: "Pause")
                                                timer.upstream.connect().cancel()
                                                isTimerRunning = false
                                                viewModel.prediction = false
                                            }
                                    } else {
                                        Image(systemName: "play.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                            .onTapGesture {
                                                utility.speak(string: "Play")
                                                timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
                                                isTimerRunning = true
                                                viewModel.prediction = true
                                            }
                                    }
                                }.padding(.bottom, 5)
                                HStack {
                                    Spacer()
                                    NavigationLink(destination: WorkoutSummary(workout: workout, timeing: timerCount, repetitions: viewModel.count, mistakes: viewModel.countMistake, action: viewModel.countActionRepetitions)) {
                                        Image(systemName: "x.circle.fill")
                                            .font(.system(size: 38))
                                            .foregroundColor(.white)
                                    }.simultaneousGesture(TapGesture().onEnded {
                                        timer.upstream.connect().cancel()
                                        utility.speak(string: "Finish")
                                        viewModel.prediction = false
                                    })
                                }
                            }.padding(.trailing, 20)
                        }.padding()
                    }
                }
            }
        }
        .toolbar(.hidden)
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

class ViewController: UIViewController {
    
    var viewModel: ViewModel?
    var workout: Workout?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var videoCapture: VideoCapture!
    var videoProcessingChain: VideoProcessingChain!
    
    let synthesizer = AVSpeechSynthesizer()
    
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
        videoProcessingChain.upstreamFramePublisher = framePublisher
    }
    
}

extension ViewController: VideoProcessingChainDelegate {
    
    func videoProcessingChain(_ chain: VideoProcessingChain, didPredict actionPrediction: ActionPrediction, for frameCount: Int) {
        if actionPrediction.isModelLabel {
            addRepCount(frameCount, to: actionPrediction.label)
        }
    }
    
    func videoProcessingChain(_ chain: VideoProcessingChain, didDetect poses: [Pose]?, in frame: CGImage) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.drawPoses(poses, onto: frame)
        }
    }
    
}

extension ViewController {
    
    private func addRepCount(_ repCount: Int, to actionLabel: String) {
        let totalReps = (viewModel?.countActionRepetitions[actionLabel] ?? 0) + (repCount / 60)
        viewModel?.countActionRepetitions[actionLabel] = totalReps
        
        
        // Numero di frame di esecuzione dell'esercizio diviso il numero di frame al secondo ottengo il tempo in secondi di esecuzione dell'esercizio che se divido per il tempo medio di esecuzione ottengo il numero di ripetizioni
        
        if actionLabel != "None" {
            
            viewModel?.count += 1
            
            if actionLabel == "Squat" {
                let utterance = AVSpeechUtterance(string: String(viewModel!.count))
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                synthesizer.speak(utterance)
            } else {
                viewModel?.countMistake += 1
                let utterance = AVSpeechUtterance(string: actionLabel)
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                synthesizer.speak(utterance)
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
    
    @ObservedObject var viewModel: ViewModel
    
    var workout: Workout
    
    func makeUIViewController(context: Context) -> ViewController {
        let mvc = ViewController()
        mvc.viewModel = viewModel
        mvc.workout = workout
        return mvc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
        if viewModel.camera {
            uiViewController.videoCapture.toggleCameraSelection()
            viewModel.camera = false
        }
        
        if viewModel.prediction {
            uiViewController.videoCapture.enableCaptureSession()
        } else {
            uiViewController.videoCapture.disableCaptureSession()
        }
        
    }
    
}
