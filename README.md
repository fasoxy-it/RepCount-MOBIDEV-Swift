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
    <img alt="Screenshot 2022-12-26 alle 16 24 49" src="https://user-images.githubusercontent.com/58709856/222925400-c3d63d38-c5c3-4800-bc1e-98919a2c0df2.png">
    <img alt="Screenshot 2022-12-26 alle 16 25 13" src="https://user-images.githubusercontent.com/58709856/222925445-51abb7c0-9e61-48f2-85db-2019cf4b5e4b.png">
  </div>
  

* **Evaluating the Action Classifier**: After training the model, the next step is to evaluate its performance. This involves testing the model on a separate dataset of videos and measuring its accuracy, precision, recall, and other evaluation metrics. This step is important for identifying any issues with the model's performance and making adjustments as needed.

  >During the training process, the dataset was iterated about 80 times to optimize the model's performance. As a result, the training dataset achieved a final accuracy score of 99%, while the validation dataset achieved a score of 100%. These scores indicate that the model was able to learn and accurately classify the different actions with a high degree of accuracy.
  
  <img width="50%" alt="Screenshot 2022-12-26 alle 16 25 38" src="https://user-images.githubusercontent.com/58709856/222925460-a4a4a58b-7410-424c-a172-f4ea43b8a61e.png"><img width="50%" alt="Screenshot 2022-12-26 alle 16 25 52" src="https://user-images.githubusercontent.com/58709856/222925473-21e97c59-9491-47b5-aea9-c77758aa4f7c.png">

## Detecting Human Actions in a Live Video Feed

The movements of a person's body, referred to as actions, can be detected through the analysis of a sequence of video frames using the Vision framework. By utilizing an action classifier, the name of a particular movement can be predicted with a high degree of accuracy. This allows for the identification of specific actions in real-time video feeds, which can be useful for a variety of applications, including fitness tracking and sports analysis. The process involves training an action classifier using machine learning techniques on a dataset of example action videos. Once the model has been trained, it can be applied to a live video feed to classify the actions being performed in real-time. By accurately detecting and classifying human actions, it is possible to gain valuable insights into a person's movements, which can be used to improve training techniques, prevent injury, and enhance overall performance.

  >In this application, there is an action classifier that has been trained to recognize four types of exercises: None, Squat, Half-squat, and Knees. The application makes its prediction based on the live video feed from the device's camera, which is displayed full-screen.

  When the application is launched, it configures the camera to generate video frames, and these frames are then processed through a series of methods using Combine. These methods work together to analyze the frames and predict the action by following the sequence of steps outlined below:

  1. Identify and locate all human body poses in each frame.
  2. Isolate the most prominent pose.
  3. Aggregate the position data of the most prominent pose over a period of time.
  4. Use the aggregated data to make action predictions by sending it to the action classifier.

  Through these steps, the application is able to accurately recognize and classify different exercise actions in real-time.


Create ML uses Vision during training to find significant points on a person’s body, called landmarks, in each frame of a video. Action classifiers learn to recognize the movement patterns of these points over time. 

At runtime, the app uses the action classifier to identify a person’s action by analyzing a series of video frames from a camera or file.

<img width="1717" alt="Detecting Human Actions in Live Video Feed" src="https://user-images.githubusercontent.com/58709856/222959088-6c681728-0dcb-4669-8a1c-1f054c921e24.png">


## Developing the RepCount Application

The RepCount application has the following main activities:

1. **Workout List Activity**: This activity displays a list of available workouts to choose from.
2. **Workout Detail Activity**: This activity provides detailed information about the selected workout, including the muscle group involved in the exercise, the exercise intensity, a description of the exercise, an example video of the correct execution of the exercise, and a list of warnings to keep in mind during the exercise.
3. **Workout Main Activity**: This activity shows the live video feed captured by the camera in the background, with the skeleton of the pose of the main body joins superimposed. In the foreground, a box displays the time taken to perform the exercise, the number of repetitions performed correctly, and the number of repetitions performed incorrectly. It also has three controls that allow you to respectively: change the camera between front and rear, pause or restart the exercise monitoring, and end the exercise monitoring.
4. **Workout Summary Activity**: This activity provides a summary of the main information related to the workout, such as the muscle group and intensity. It also presents a summary of the exercise execution, including the time taken, number of repetitions correctly performed, number of errors committed, and a percentage of execution accuracy. Additionally, there is a dedicated section that reports the specific number of repetitions associated with each error, and a button that provides a description of how to correct the exercise form.
<img width="366" alt="Workout List Activity" src="https://user-images.githubusercontent.com/58709856/222958937-29fb97f3-330f-4958-9661-6f35138cc9b2.png">
<img width="366" alt="Workout Detail Activity" src="https://user-images.githubusercontent.com/58709856/222958971-3d230f6b-6399-4012-add7-4d5c3b4cd349.png">
<img width="367" alt="Workout Main Activity" src="https://user-images.githubusercontent.com/58709856/222958990-761d0635-9acb-425c-b717-98fc86fb6db1.png">
<img width="367" alt="Workout Summary Activity" src="https://user-images.githubusercontent.com/58709856/222958955-5dff29b7-2a1c-4f2e-bcff-2dc0a69cb6b4.png">



## Technologies
* SWIFTUI
* CreateML
* CoreML
* 
