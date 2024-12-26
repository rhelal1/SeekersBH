//
//  AddVideoViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 25/12/2024.
//

import UIKit

class AddVideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var vidTitle: UITextField!
    
    @IBOutlet weak var vidLink: UITextField!
    
    @IBOutlet weak var vidSpeaker: UITextField!
    
    @IBOutlet weak var vidChannel: UITextField!
    
    @IBOutlet weak var vidDuration: UITextField!
    
    @IBOutlet weak var vidDescription: UITextField!
    
    @IBOutlet weak var vidCover: UIImageView!
    
    @IBAction func selectImageTapped(_ sender: Any) {
        presentImagePicker()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction func saveVid(_ sender: Any) {
        guard let title = vidTitle.text, !title.isEmpty,
              let link = vidLink.text, !link.isEmpty,
              let speaker = vidSpeaker.text, !speaker.isEmpty,
              let channel = vidChannel.text, !channel.isEmpty,
              let duration = vidDuration.text, !duration.isEmpty,
              let description = vidDescription.text, !description.isEmpty else {
            print("Please fill out all fields.")
            return
        }
        
        guard let coverImage = vidCover.image else {
                  print("Please select a cover image.")
                  return
              }
        
        let documentReference = FirebaseManager.shared.db.collection("Videos").document()
           let documentID = documentReference.documentID
        
        CloudinaryManager.upload(image: coverImage, to: "videosCovers", uploadPreset: "ml_default") { result in
            switch result {
            case .success(let url):
                let videoData: [String: Any] = [
                    "id": documentID,
                    "title": title,
                    "url": link,
                    "speaker": speaker,
                    "channel": channel,
                    "duration": duration,
                    "description": description,
                    "picture": url,
                    "views": 0
                ]
                
                FirebaseManager.shared.addDocumentToCollection(collectionName: "Videos", data: videoData)
                print("Video and image URL saved successfully!")
                
            case .failure(let error):
                print("Image upload failed: \(error.localizedDescription)")
            }
        }
    }
    func presentImagePicker() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.editedImage] as? UIImage {
            print("Edited image selected.")
            vidCover.image = selectedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            print("Original image selected.")
            vidCover.image = originalImage
        } else {
            print("No image selected.")
        }
    }
}


