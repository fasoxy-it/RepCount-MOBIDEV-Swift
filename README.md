# RepCount-MOBIDEV-Swift
>MOBIDEV Exam Project

RepCount is an iOS application that automates the real-time counting of the repetitions of a specific motor exercise and which allows you to determine the correctness of the execution.

With this application, therefore, we intend to provide users with a tool that allows them to verify and count the execution of the repetitions of motor exercises.

>The application is currently in BETA and focuses on detecting squats. It has a classification system that can identify two common types of errors: half-squats and knees-in.

## Introduction

The workflow for developing RepCount can be summarized into three principal steps:

1. Creating the Action Classifier Model
2. Detecting Human Actions in Live Video Feed
3. Developing the RepCount Application.

## Creating an Action Classifier Model

An action classifier is a type of machine learning model that is trained to recognize and classify human actions in video data. The three main steps required to create an action classifier model can be summarized as follows:

* **Collecting and Organizing Example Action Videos**: This involves collecting a dataset of example videos that demonstrate the actions you want the classifier to recognize, and organizing these videos into a format that can be used for training the model. This step is crucial for ensuring that the model has enough diverse and representative data to learn from. 

  >For the RepCount application, we have collected a dataset of 600 videos from 4 individuals with varying characteristics such as weight, height, age, and sex. This dataset includes 300 videos of the None Action, 100 videos of the Squat Action, 100 videos of the Half-Squat Action, and 100 videos of the Knees-In Action.
* **Training the Action Classifier**: Once the dataset is collected and organized, the next step is to train the action classifier model. This involves using machine learning algorithms and techniques to teach the model to recognize and classify the different actions in the dataset. This step requires careful selection of machine learning techniques and parameters to optimize the model's accuracy. 
  >During the training step of the RepCount application, we utilized the CoreML Tool to create our action classifier model. To optimize the model's performance, we set a frame rate of approximately 30 frames per second and an action duration of 2 seconds, which corresponds to a prediction window of 60 frames. During the training step, we utilized the technique of horizontally flipping the videos as a data augmentation method to improve the model's ability to generalize to new scenarios. By flipping the videos horizontally, we created additional training examples that were similar to the original videos but mirrored, which helped the model to learn to recognize and classify actions from both sides. This approach can improve the model's accuracy and robustness, allowing it to identify actions accurately in a wider range of scenarios.
* **Evaluating the Action Classifier**: After training the model, the next step is to evaluate its performance. This involves testing the model on a separate dataset of videos and measuring its accuracy, precision, recall, and other evaluation metrics. This step is important for identifying any issues with the model's performance and making adjustments as needed.

<img width="597" alt="image" src="https://user-images.githubusercontent.com/58709856/209690667-a892e93d-905d-4200-a027-74856fbc9bf8.png">

Create ML uses Vision during training to find significant points on a person’s body, called landmarks, in each frame of a video. Action classifiers learn to recognize the movement patterns of these points over time. 

At runtime, the app uses the action classifier to identify a person’s action by analyzing a series of video frames from a camera or file.

<img width="771" alt="image" src="https://user-images.githubusercontent.com/58709856/209801476-02bdf775-5604-4239-a773-cab353c296f0.png">

Training an action classifier with the Create ML developer tool follows the same general workflow:

* Configuring the action classifiers's frame rate based on its destination app
* Acquiring videos that meet or exceed that frame rate
* Acquiring videos of humans clearly performing actions in a suitable enviroment
* Acquiring videos of relates but irrelevant actions



The first step was to collect a considerable number of videos. In this regard, 600 videos were collected, divided into:
* **None** (600)
* **Squat** (100)
* **Halfsquat** (100)
* **Knees** (100)

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
