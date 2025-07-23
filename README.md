3 DOF Robotic Arm Controller, SCARA

A 3-DOF robotic arm that draws user-input paths on paper, controlled via MATLAB and an Arduino. This project was developed for a Robotics and Kinematics course.
How It Works
- GUI: A MATLAB script creates a graphical interface for the user to draw on.
- Path Input: The user holds the 'K' key and moves the mouse to draw a path. The (x, y) coordinates are stored in a matrix.
- Inverse Kinematics: The script calculates the required servo motor angles (theta1, theta2) to reach each point in the path.
- Execution: The calculated angles are sent to an Arduino, which controls the servo motors to draw the path on paper.

Known Issues & Improvements
- Mechanical Issue: The design lacks bearings on the joints. This causes the servo motor shafts to bend under load, which reduces drawing accuracy.
-    Solution: Add bearings to the joints to improve stability and precision.
- Software Issue: The control script is written in MATLAB, which causes significant performance lag when drawing high-density paths.
-    Solution is for better performance, the controller should be re-written in a more suitable language for real-time tasks, such as C++ or Python.

Bill of Materials
- 2 x Tower Pro MG995 Servo Motor
- 1 x Tower Pro SG90 Servo Motor
- Arduino UNO R3
- 5V Regulator
- External Power Supply

Project Files
- Tinkercad Schematic: https://www.tinkercad.com/things/6sjXP0xfZ9F-robotik-projem
- SolidWorks Files: Should be reviewed to understand the mechanical assembly.

How to Use
1) Hardware Setup:
- Connect the Arduino to your PC.
- Ensure all wiring matches the project schematic.
- It's recommended to first run a calibration script to set all servos to their zero/home position.

2) Run the MATLAB Script:
- Open Robtik_Proje.m in MATLAB.
- In the script, find the line ard = arduino('COM6', 'Uno'); and change 'COM6' to your Arduino's COM port.
- Run the script.

3) Draw !:
- The program will ask for point density. Use a value between 10-50 to avoid lag.
- A GUI window will appear. To draw, hold down the 'K' key while moving your mouse over the window.
- Release 'K' to finish a line segment. You can start a new one by pressing 'K' again.
- Press the 'Escape' key to finalize the drawing and command the robot to start plotting.
- 
When finished, press 'Esc' to exit.
The Arduino-controlled robot will replicate your drawing exactly.
Enjoy your project!

