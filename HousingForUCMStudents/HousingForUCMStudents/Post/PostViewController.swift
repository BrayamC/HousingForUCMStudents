//
//  PostViewController.swift
//  HousingForUCMStudents
//
//  Created by Brayam Corral on 4/8/21.
//

import UIKit
import AlamofireImage
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var roomsTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBAction func onSubmit(_ sender: Any) {        // parse creates schema based on these attributes
        // creates table
        let post = PFObject(className: "Posts")
        
        // if attribute doesnt exist, creates attributes with data
        post["address"] = addressTextField.text
        post["rooms"] = roomsTextField.text
        post["price"] = priceTextField.text
        post["author"] = PFUser.current()!
        
        let imageData = houseImageView.image!.pngData()
        
        // makes new table
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        print("Clicked on feed pic")
        // launch camera
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // Use camera if possible, else use library
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFit: size)
        
        houseImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
