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

  >For the RepCount application, we have collected a dataset of 600 videos from 4 individuals with varying characteristics such as weight, height, age, and sex. This dataset includes 300 videos of the None Action, 100 videos of the Squat Action, 100 videos of the Half-Squat Action, and 100 videos of the Knees-In Action. Each videos has a mean length of approximately 2 seconds, and they were captured at a frame rate of 30 frames per second. We aimed to capture each classified action from different angles to provide the model with a more comprehensive view of each movement. To achieve this, we recorded each action from five different angles: frontal, 45 degrees to the left, 45 degrees to the right, 90 degrees to the left, and 90 degrees to the right. This approach ensures that the model has a robust understanding of each action from multiple perspectives, enabling it to accurately classify the actions in real-time video feeds from a range of camera positions.
  
* **Training the Action Classifier**: Once the dataset is collected and organized, the next step is to train the action classifier model. This involves using machine learning algorithms and techniques to teach the model to recognize and classify the different actions in the dataset. This step requires careful selection of machine learning techniques and parameters to optimize the model's accuracy.

  >During the training step of the RepCount application, we utilized the CoreML Tool to create our action classifier model. To optimize the model's performance, we set a frame rate of approximately 30 frames per second and an action duration of 2 seconds, which corresponds to a prediction window of 60 frames. During the training step, we utilized the technique of horizontally flipping the videos as a data augmentation method to improve the model's ability to generalize to new scenarios. By flipping the videos horizontally, we created additional training examples that were similar to the original videos but mirrored, which helped the model to learn to recognize and classify actions from both sides. This approach can improve the model's accuracy and robustness, allowing it to identify actions accurately in a wider range of scenarios.
  <div style="display:flex; flex-wrap: wrap;">
    <img width="100%" alt="Screenshot 2022-12-26 alle 16 24 49" src="https://user-images.githubusercontent.com/58709856/222925400-c3d63d38-c5c3-4800-bc1e-98919a2c0df2.png">
    <img width="100%" alt="Screenshot 2022-12-26 alle 16 25 13" src="https://user-images.githubusercontent.com/58709856/222925445-51abb7c0-9e61-48f2-85db-2019cf4b5e4b.png">
  </div>
  

* **Evaluating the Action Classifier**: After training the model, the next step is to evaluate its performance. This involves testing the model on a separate dataset of videos and measuring its accuracy, precision, recall, and other evaluation metrics. This step is important for identifying any issues with the model's performance and making adjustments as needed.

  >During the training process, the dataset was iterated about 80 times to optimize the model's performance. As a result, the training dataset achieved a final accuracy score of 99%, while the validation dataset achieved a score of 100%. These scores indicate that the model was able to learn and accurately classify the different actions with a high degree of accuracy.
  
  <img width="50%" alt="Screenshot 2022-12-26 alle 16 25 38" src="https://user-images.githubusercontent.com/58709856/222925460-a4a4a58b-7410-424c-a172-f4ea43b8a61e.png"><img width="50%" alt="Screenshot 2022-12-26 alle 16 25 52" src="https://user-images.githubusercontent.com/58709856/222925473-21e97c59-9491-47b5-aea9-c77758aa4f7c.png">




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
