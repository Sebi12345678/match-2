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
        
        
        //to do: fix firebase downloading multiple files
        let url = self.getDocumentsDirectory().appendingPathComponent(name)
        
        
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
                    pathReference.getData(maxSize: 1024*1024*12) {
                        (dataResponse, errorResponse) in
                        if let data = dataResponse{
                            let image = UIImage(data: data)
                            completion(image!)
                        }
                    }
                }
    }
}
