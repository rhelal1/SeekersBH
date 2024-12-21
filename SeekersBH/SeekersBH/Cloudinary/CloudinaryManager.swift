//
//  CloudinaryManager.swift
//  SeekersBH
//
//  Created by Zainab Madan on 21/12/2024.
//

import Cloudinary
import Foundation

public struct CloudinaryManager {
    private static let cloudinary: CLDCloudinary = {
        let config = CLDConfiguration(cloudName: "diquxkyh5", apiKey: "153349418492714", apiSecret: "mcV2zcISLW1ke_er-0qBu0_GmVg")
        return CLDCloudinary(configuration: config)
    }()
    
    private init() {}
    
    /// Uploads a file to Cloudinary
    /// - Parameters:
    ///   - filePath: The local file path or URL of the file to upload.
    ///   - folder: The folder in Cloudinary where the file will be stored.
    ///   - completion: Completion handler with the result of the upload operation.
    public static func upload(filePath: String, to folder: String, uploadPreset: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: filePath) else {
            completion(.failure(NSError(domain: "CloudinaryManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid file path"])))
            return
        }
        
        let params = CLDUploadRequestParams().setFolder(folder)
        cloudinary.createUploader().upload(url: url, uploadPreset: uploadPreset, params: params, progress: nil) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let publicId = result?.publicId {
                completion(.success(publicId))
            } else {
                completion(.failure(NSError(domain: "CloudinaryManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
            }
        }
    }
    
    
    /// Downloads a file from Cloudinary
    /// - Parameters:
    ///   - publicId: The public ID of the file in Cloudinary.
    ///   - transformation: Optional transformation to apply to the downloaded file.
    ///   - completion: Completion handler with the URL of the downloaded file or an error.
    public static func download(publicId: String, transformation: CLDTransformation? = nil, completion: @escaping (Result<URL, Error>) -> Void) {
        let urlGenerator = cloudinary.createUrl()
        
        // Apply the transformation if provided
        if let transformation = transformation {
            urlGenerator.setTransformation(transformation)
        }
        
        guard let urlString = urlGenerator.generate(publicId), let downloadURL = URL(string: urlString) else {
            completion(.failure(NSError(domain: "CloudinaryManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to generate download URL"])))
            return
        }
        
        // Perform download using URLSession (for demonstration)
        let task = URLSession.shared.downloadTask(with: downloadURL) { location, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let location = location {
                completion(.success(location))
            } else {
                completion(.failure(NSError(domain: "CloudinaryManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
            }
        }
        task.resume()
    }
}
