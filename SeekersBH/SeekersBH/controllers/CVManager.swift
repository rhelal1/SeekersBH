//
//  CVManager.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import Foundation

import FirebaseFirestore
//import FirebaseFirestoreSwift

class CVManager {
    static let shared = CVManager()
    
    var cv: CV = CV (
        fullName: "",
        email: "",
        phoneNumber: "",
        likedInURL: "",
        protofolioURL: "",
        aboutMe: "",
        educations: [:],
        skills: "",
        otherSkills: "",
        certifications: [],
        otherCertification: "",
        projectSecions: [],
        otherProjects: "",
        highestDegree: "",
        university: ""
    )
    
    private init() {}
    
    // Function to save the CV to Firebase
    func saveCVToFirebase() {
        let cv = CVManager.shared.cv

        let cvData: [String: Any] = [
            "fullName": cv.fullName,
            "email": cv.email,
            "phoneNumber": cv.phoneNumber,
            "likedInURL": cv.likedInURL,
            "protofolioURL": cv.protofolioURL,
            "aboutMe": cv.aboutMe,
            "degree": cv.educations.map { $0.key.rawValue }, // Assuming you want to save the degree as a string
            "insinuation": cv.educations.map { $0.value },  // Same for insinuation
            "skills": cv.skills,
            "certifications": cv.certifications.map { [
                "certificationName": $0.name,
                "certificationDateObtained": formatDateToString($0.DateObtained),
                "certificationIssuingOrganization": $0.IssuingOrganization
            ] },
            "projectName": cv.projectSecions.map { $0.name }, // Assuming you want to save an array of project names
            "projectOverView": cv.projectSecions.map { $0.overview },
            "projectResourse": cv.projectSecions.map { $0.resource },
            "id": 0 // This is the ID field; you'll need to handle it based on your collection's logic (like autoincrement or assigning manually)
        ]

        let db = Firestore.firestore()
        db.collection("CVs").addDocument(data: cvData) { error in
            if let error = error {
                print("Error saving CV: \(error.localizedDescription)")
            } else {
                print("CV saved successfully!")
            }
        }
    }
}

// Helper function to format date to string (you can adjust the date format as needed)
func formatDateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the format to your preferred date format
    return dateFormatter.string(from: date)
}
