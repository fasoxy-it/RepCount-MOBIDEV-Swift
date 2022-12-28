# RepCount-MOBIDEV-Swift
>MOBIDEV Exam Project

RepCount is an iOS application that automates the real-time counting of the repetitions of a specific motor exercise and which allows you to determine the correctness of the execution.

With this application, therefore, we intend to provide users with a tool that allows them to verify and count the execution of the repetitions of motor exercises.

The first step was to collect a considerable number of videos. In this regard, 600 videos were collected, divided into:
* **None** (600)
* **Squat** (100)
* **Halfsquat** (100)
* **Knees** (100)

## Stages 
* Introduzione
* UI/UX
* Application
* Creating an action classifier model
* Detecting Motor Exercies in Live Video Feed

## Detecting Human Actions in a Live Video Feed

This app recognizes a person’s body moves, called actions, by analyzing a series of video frames with Vision and predicting the name of the movement by applying an action classifier. The action classifier in this sample recognizes four exercises:

* None
* Squat
* Half-squat
* Knees

The app defines its current action prediction on top of a live, full-screen video feed from the device’s camera.

At launch, the app configures the device’s camera to generate video frames and then directs the frames through a series of methods it chains together with Combine. These methods work together to analyze the frames and make action predictions by performing the following sequence of steps:

1. Locate all human body poses in each frame.
2. Isolate the prominent pose.
3. Aggregate the prominent pose’s position data over time.
4. Make action predictions by sending the aggregate data to the action classifier.

## Creating an Action Classifier Model

An action classifier is a machine learning model that identifies a person’s body movements in a video. In this example, the action classifier you train to classify exercise movements can predict “squat” when you provide it with a video of a person doing squat. Create an action classifier with Create ML by gathering example videos of individuals performing each action you want the classifier to recognize and identify. In this example, to train the exercise action classifier, gather videos of individuals performing various exercises, such as none, squat, half-squat, and knees.

<img width="597" alt="image" src="https://user-images.githubusercontent.com/58709856/209690667-a892e93d-905d-4200-a027-74856fbc9bf8.png">

Create ML uses Vision during training to find significant points on a person’s body, called landmarks, in each frame of a video. Action classifiers learn to recognize the movement patterns of these points over time. 

At runtime, the app uses the action classifier to identify a person’s action by analyzing a series of video frames from a camera or file.

<img width="771" alt="image" src="https://user-images.githubusercontent.com/58709856/209801476-02bdf775-5604-4239-a773-cab353c296f0.png">

Training an action classifier with the Create ML developer tool follows the same general workflow:

* Configuring the action classifiers's frame rate based on its destination app
* Acquiring videos that meet or exceed that frame rate
* Acquiring videos of humans clearly performing actions in a suitable enviroment
* Acquiring videos of relates but irrelevant actions

## Technologies
* SWIFTUI
* CreateML
* CoreML
* 
