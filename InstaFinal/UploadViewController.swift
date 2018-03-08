//
//  UploadViewController.swift
//  InstaFinal
//
//  Created by MacBook on 2/26/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addPost))
    }
    
    @IBAction func openImagePicker(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
   
    
    /// Move TextFields to keyboard. Step 1: Add tap gesture to view.
    
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        }  else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        addImageButton.setImage(newImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func addPost() {
        
        let postRef = Database.database().reference().child("posts").childByAutoId()
        let storageRef = Storage.storage().reference().child("\(postRef)")
        let image = addImageButton.currentImage
        var photoURL: URL
        var postObject = ["id": postRef,
                          "uid": user][String:Any]
        guard let imageData = UIImageJPEGRepresentation(image!, 0.75) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                if let url = metaData?.downloadURL() {
                photoURL = url
                    postObject = [
                        "id": postRef,
                        "uid": user,
                        "caption": textView.text,
                        "photoURL": photoURL
                        ] as [String:Any]
                }
            } else {
               print("\(error!.localizedDescription)")
            }
        }
    
        guard let user = Auth.auth().currentUser?.uid else  { return }
        
        
            postRef.setValue(postObject, withCompletionBlock: { error, ref in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    
                }
            })
        }
}

    
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        
        
}
