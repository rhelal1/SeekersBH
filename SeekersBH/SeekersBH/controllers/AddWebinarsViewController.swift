//
//  AddWebinarsViewController.swift
//  SeekersBH
//
//  Created by Zainab Madan on 25/12/2024.
//
//
import UIKit


class AddWebinarsViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var webtitle: UITextField!
    
    @IBOutlet weak var wedescription: UITextField!
    
    @IBOutlet weak var webspeaker: UITextField!
    
    @IBOutlet weak var webdate: UITextField!
    
    @IBOutlet weak var webtime: UITextField!
    

    @IBOutlet weak var weburl: UITextField!
    
    
    @IBOutlet weak var webcover: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func savewebinar(_ sender: Any) {
        guard let title = webtitle.text, !title.isEmpty,
              let description = wedescription.text, !description.isEmpty,
              let speaker = webspeaker.text, !speaker.isEmpty,
              let date = webdate.text, !date.isEmpty,
              let time = webtime.text, !time.isEmpty,
              let url = weburl.text, !url.isEmpty else {
            print("Please fill out all fields.")
            return
        }
        
        guard let coverImage = webcover.image else {
            print("Please select a cover image.")
            return
        }
        
        let documentReference = FirebaseManager.shared.db.collection("Webinars").document()
        let documentID = documentReference.documentID
        
        CloudinaryManager.upload(image: coverImage, to: "webinarsCovers", uploadPreset: "ml_default") { result in
            switch result {
            case .success(let coverUrl):
                let webinarData: [String: Any] = [
                    "id": documentID,
                    "title": title,
                    "description": description,
                    "speaker": speaker,
                    "date": date,
                    "time": time,
                    "url": url,
                    "cover": coverUrl,
                    "views": 0
                ]
                
                FirebaseManager.shared.addDocumentToCollection(collectionName: "Webinars", data: webinarData)
                print("Webinar and cover image URL saved successfully!")
                
                let alert = UIAlertController(title: "Success", message: "New Webinars Added Successfully!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                self.webtitle.text = ""
                self.wedescription.text = ""
                self.webspeaker.text = ""
                self.webdate.text = ""
                self.webtime.text = ""
                self.weburl.text = ""
                self.webcover.image = nil
                
            case .failure(let error):
                print("Image upload failed: \(error.localizedDescription)")
            }
        }
    }


    
    @IBAction func selectedwebcover(_ sender: Any) {
        presentImagePicker()
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
//            print("Edited image selected.")
            webcover.image = selectedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
//            print("Original image selected.")
            webcover.image = originalImage
        } else {
            print("No image selected.")
        }
    }


    
}
