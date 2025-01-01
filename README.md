# SeekersBH

**SeekersBH** is an iOS application designed to revolutionize the job-seeking process by providing a comprehensive platform for job seekers and employers. The app not only facilitates job searches but also serves as a career companion, supporting users throughout their professional journeys with a suite of innovative features.

## Table of Contents
- [Background](#background)
- [Features](#features)
- [Target Stakeholders](#target-stakeholders)
- [Technologies Used](#technologies-used)
- [Firebase and Cloudinary Usage](#firebase-and-cloudinary-usage)
- [Design Changes](#design-changes)
- [Team Members](#team-members)
- [How to Run the Project](#how-to-run-the-project)

---

## Background
SeekersBH aims to address common challenges in the job-seeking process, such as disorganized application tracking and limited access to career resources. It provides job seekers with tools to explore job opportunities, manage applications, build resumes, and access career development resources. Employers can post and manage job listings while interacting directly with potential candidates.

The app stands out by combining professional development resources, personalized job recommendations, and an interactive community for both job seekers and employers.

---

## Features
### Core Features:
1. **User Authentication**: Secure login, registration, guest access, and persistent login.
2. **User Profile & Settings**: Personalize profiles with information, skills, and preferences. Includes light/dark mode option.
3. **Personalized Job Recommendations**: Tailored job suggestions based on user profiles and interests.
4. **Job Application**: Simplifies applying to jobs directly within the platform.
5. **Job Application Tracker**: Tracks the progress of submitted applications.
6. **Resume Creator & Customizer**: Build and manage professional resumes for job applications.
7. **Professional Growth Hub**: Access articles, videos, and webinars for skill enhancement.
8. **Interactive Online Courses**: Learn new skills, take quizzes, and earn certifications.
9. **Job Management for Employers**: Employers can post, edit, and manage job listings.
10. **Search Engine & Filter**: Advanced filtering for tailored job searches.
11. **Admin Dashboard**: Manage resources, user accounts, and monitor platform activity.
12. **User Connections & Direct Messages**: Connect with users, send messages, and share CVs.

### Extra Features:
- Firebase integration for added functionality.

---

## Target Stakeholders
- **Primary Stakeholders**:
  - Job Seekers (Users)
  - Employers
  - App Developers
  - Administrators
- **Secondary Stakeholders**:
  - Career Advisors
  - Data Analysts
  - Marketing & Sales Teams
- **Tertiary Stakeholders**:
  - Investors
  - Third-party Service Providers

---

## Technologies Used
- **Frontend**: Swift (iOS Development)
- **Backend**: Firebase for authentication and database management
- **Design Tools**: Figma for mockups and UI/UX design
  
---

## Firebase and Cloudinary Usage
SeekersBH leverages the following technologies to enhance functionality and ensure a seamless user experience:

- **Firebase Database**: Used to store and manage application data efficiently.
- **Firebase Authentication**: Facilitates secure login and user management.
- **Firebase Messaging**: Supports real-time communication between users.
- **Cloudinary**: Utilized for storing and managing media files such as user profile images and other assets.

---

## Design Changes
This section outlines updates made to the design of SeekersBH. These include refinements to improve user experience and functionality:

1. **[Feature: Online Courses]**
- Change:
    In the online courses screen, a new button has been added to allow users to view all their obtained certifications. When clicked, this button navigates the user to a screen displaying all their certifications, where they can select one to manage. Upon selection, they are taken to another screen to manage the certification. Here, the user can remove the certificate or choose a CV from their CV list to add the certification to it.
- Reason for the Change:
    This change was implemented to address the issue of users not being able to easily view their obtained certifications. By enhancing the user experience with this feature, users can now conveniently manage their certifications, improving the overall usability and functionality of the app.
2. **[Feature: Manage resources]**
  - Change:
    Removed the profile picture because we don’t have a section to add the picture in the sign in 
    Added a section to add a cover to the resources ‘videos and webinars’ 
3. **[Feature: cv creator]**
    - Change:
      Added a cv name field for the user to fill, so when he views his cv's he chooses the cv name he wants to view / edit.
4. **[Feature: Job Application Tracker]**
    - Change:
      Added more job details. removed the employer email because its not related or relevant to the job tracker.
5. **[Feature: User Authentication - registeration]**
    - Change:
      Changes are done in the registration page because there was a problem in scrolling the page
6. **[Feature: Job Managment For Employers]**
     - Change:
    In the add new job application screen, the user is going to fill a four pages of form to add a new job application, unlike the form in the prototype which is made of three pages only, some of the form fields were put in a whole new page.
  - Reason for the change:
    This change was made to make the form more user-friendly, since three text views were too much for a an Iphone screen.
7. **[Feature: Search Engine & Filter]**
   - Change:
    In the search engine page, the filter was modifed to filter the jobs based on it's status only (closed,open), unlike the filter in the prototype which was filtering jobs on another criterias.
  - Reason for the Change:
    This change was made due to reconsidering the relevant things that the user would want to filter his search based on them.
8. **[Feature: Job Application]**
    - Change:
      The design of the CV has been changed due to challenges I encountered in its application.
---

## Team Members
- **Zainab Abdulla** (202203386): Admin Dashboard, User Connections & Direct Messages
- **Marwa Abbas** (202202170): Job Application Tracker, Resume Creator
- **Ruqaya Helal** (202204117): Professional Growth Hub, Interactive Online Courses
- **Qasim Alshehabi** (202202979): Job Management for Employers, Search Engine & Filter
- **Duha Hashem** (202201251): Personalized Job Recommendations, Job Application
- **Reem Alhalwachi** (202201044): User Authentication, User Profile & Settings

---

## How to Run the Project
1. Clone the repository to your local machine.
2. Open the project in Xcode (requires Xcode 15.0 or later).
3. Configure Firebase by adding your `GoogleService-Info.plist` file to the project.
4. Build and run the project on a simulator or a connected iOS device.

---

For further information or contributions, feel free to reach out to the team or the project instructor, **Mr. Ghassan AlShajjar**.

