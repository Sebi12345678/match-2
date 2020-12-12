//
//  StorageManager.swift
//  Match22
//
//  Created by VM on 12/12/20.
//

import Foundation
import UIKit
import FirebaseStorage

class StorageManager: NSObject {
    private override init() { }
    static let shared: StorageManager = StorageManager()
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func getImage (name: String, completion:@escaping (UIImage)->Void ){
        let storage = Storage.storage()
        let pathReference = storage.reference(withPath: name)
        
        let url = self.getDocumentsDirectory().appendingPathComponent(name)
        let downloadTask = pathReference.write(toFile: url) { _, error in
          if let error = error {
            print(error)
          } else {
            do{
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
            completion(image!)
            }
            catch{
               print(error)
            }
          }
        }
        
        if FileManager.default.fileExists(atPath: url.path) {
            do{
            let imageData = try Data(contentsOf: url)
            let image = UIImage(data: imageData)
                completion(image!)
            }
            catch{
               print(error)
            }
                } else {
                    downloadTask.resume()
                }
    }
}
