//
//  selectViewController.swift
//  CatchYourFriend
//
//  Created by Berkay Ozcan on 06/05/2023.
//

import UIKit

class selectViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var gamerName: UITextField!
    
    @IBOutlet weak var playbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playbutton.layer.cornerRadius = 14
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        if gamerName.text != ""  {
            if let chosenImage = imageView.image {
                let minionmodel = minionModel.sharedInstance
                minionmodel.chosenImage = chosenImage
                minionmodel.minionName = gamerName.text!
                performSegue(withIdentifier: "gotoplay", sender: nil)
            }
        }else{
            errormessage(title: "Error !", message: "Please select an image and username")
        }
        
    }
    
    
    func errormessage(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }

}
