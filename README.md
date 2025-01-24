# DoorLock
This was my first digital design project. The project is very ameteur very hard to understand but it covers basics. 

![Ekran görüntüsü 2025-01-24 114409](https://github.com/user-attachments/assets/6f3b53fa-86ee-40f2-95d9-9303b7e14c55)

This project is implemented on the Bayas3 Board, incorporating a button synchronizer to convert asynchronous human inputs into synchronized signals. The system operates in two modes: Mode 1 (R2 pin ON) for unlocking the lock and Mode 2 (R2 pin OFF) for changing the password.

In Mode 1, the system prompts the user to input a password via the seven-segment display. After processing the entered password, the seven-segment display provides feedback. If the password is correct, all LEDs light up, and the display shows "TRUE," accompanied by a relaxing animation. If the password is incorrect, the system stops at the mismatched bit, and the display shows "FALSE."

In Mode 2, the system allows the user to set a new password. Upon activating the R2 switch, the system prompts the user to input a new password via the seven-segment display. After entering the new password and pressing the start button, the display confirms the new password.

If any invalid action occurs during the process, the seven-segment display shows "ERROR" and resets to the starting point, ensuring smooth and reliable operation throughout. This project effectively demonstrates secure password entry and management using the Bayas3 Board.
