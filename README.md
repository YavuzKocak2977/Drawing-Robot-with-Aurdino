This project was created for the Robotics and Kinematics course.

We developed it in a short time, so there are many mistakes and design issues. The most significant problem (best understood by viewing the project drawings in SolidWorks) is that the servo motors experience buckling due to the lack of bearings. This is a major issue but can be easily fixed by adding bearings with some basic drawing knowledge.

Another major issue is that I used MATLAB instead of C++ for an exercise. However, MATLAB does not perform well in this case. For example, when selecting 200 clicks per second, the program lags due to MATLAB’s inefficiency in handling large matrix arrays. I have not resolved this issue yet, and perhaps another programming language would work better.

Components Used:
3x Tower Pro MG995
Tower Pro SG90
Arduino UNO R3
Breadboard
5V Regulator
Power Supply
Project Schematics:
Tinkercad: https://www.tinkercad.com/things/6sjXP0xfZ9F-robotik-projem

How to Use:
Set Up the Arduino

Before running the code, open MATLAB and update the COM port in the script (I used COM6, but yours may be different).
Check the Arduino pin connections and ensure they are correctly wired.
Calibration

Upload a simple degree-control code to the Arduino to ensure all servos are set to 0 degrees.
Open the SolidWorks file to understand the assembly and working principle.
Running the Program

Connect the Arduino and run the program.
The program will ask how many points to add per second; select a value between 10 and 50 (higher values may cause lag).
A graph similar to an A4 sheet will appear.
Click the left mouse button on the graph to draw, then press 'K' to confirm each point.
When finished, press 'Esc' to exit.
The Arduino-controlled robot will replicate your drawing exactly.
Enjoy your project!

