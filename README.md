# SwiftUI - Dozer App

## Author

Name: Jasper Vandenbroucke

Email: jasper.vandenbroucke@student.hogent.be

Student number: 202290689

## Background

In the first semester of the current school year, I created a group project for the RISE course for the company Dozer. Dozer sells all kinds of machinery. During this project, we had to build both a web and mobile application.

When I was told that for Mobile Application Development: iOS we also had to develop an app, I immediately had the idea of creating a simplified version of the Dozer mobile app.

## Description

When the app is launched you immediately see the overview of the machines with a button at the top that takes you to the screen to add a machine to the range. 
Each machine also has details and these can be viewed/modified* by clicking on a machine. 
There is also the ability to delete machines by swiping to the left in the list of machines.

The following rules apply to adding a machine.

**Machine info**:
- Name is mandatory
- Type is mandatory
- Price is mandatory and must be higher than 1000

**Options (optional)**:
- Name is mandatory
- Price is mandatory and must be higher than 1

***Note**: only machine name and type can be changed, but cannot be empty

## Running the project

**Step 1: API**

The app uses an api I created myself for this particular project.
link: https://github.com/JasperVandenbroucke/iOS-Dozer-Backend.git

Execute the following command to run the API: `npm start`

**Step 2: iOS app**

Clone this repository and open it in Xcode.
Inside Xcode, press the play button in the upper left corner

<img width="315" alt="Scherm­afbeelding 2025-01-05 om 05 56 01" src="https://github.com/user-attachments/assets/a0a9e3c7-7acb-47ca-8969-4f6039f98d94" />
