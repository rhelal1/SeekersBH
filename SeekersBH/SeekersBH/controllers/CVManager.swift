//
//  CVManager.swift
//  SeekersBH
//
//  Created by marwa on 19/12/2024.
//

import Foundation
import FirebaseFirestore


class CVManager {
    static let shared = CVManager()
    
    var cv: CV = CV (
        fullName: "",
        email: "",
        phoneNumber: "",
        likedInURL: "",
        protofolioURL: "",
        cvName: "",
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
            "linkenIn": cv.likedInURL,
            "portfolio": cv.protofolioURL,
            "cvName": cv.cvName,
            "aboutMe": cv.aboutMe,
            "highestDegree": cv.highestDegree,
            "university": cv.university,
            "skillName": cv.skills,
            "otherSkill": cv.otherSkills,
            "certifications": cv.certifications.map { [
                "certificationName": $0.name,
                "certificationDateObtained": formatDateToString($0.DateObtained),
                "certificationIssuingOrganization": $0.IssuingOrganization
            ] },
            "otherCertification": cv.otherCertification,
            "projectName": cv.projectSecions.map { $0.name },
            "projectOverview": cv.projectSecions.map { $0.overview },
            "projectURL": cv.projectSecions.map { $0.resource },
            "otherProjects": cv.otherProjects,
            "id": 0,
            "createdDate": Timestamp()
        ]
        
        let db = Firestore.firestore()
        db.collection("CV").addDocument(data: cvData) { error in
            if let error = error {
                print("Error saving CV: \(error.localizedDescription)")
            } else {
                print("CV saved successfully!")
            }
        }
    }
}

func formatDateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}
