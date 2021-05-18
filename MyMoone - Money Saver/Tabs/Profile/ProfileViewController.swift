//
//  ProfileViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editName: UIButton!
    @IBOutlet weak var pickImage: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var picker = UIImagePickerController()
    
    var state : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        editName.isHidden = true
        pickImage.isHidden = true
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.contentMode = .scaleToFill
        nameLbl.text = profile.name
        
        if let imageData = UserDefaults.standard.object(forKey: "imageProfile") as? Data {
            profileImage.image = UIImage(data: imageData)
        } else {
            profileImage.image = UIImage(systemName: "person.circle.fill")
        }
    }
    
    @IBAction func editBtn(_ sender: Any) {
        if state {
            editBtn.setTitle("Selesai", for: .normal)
            editName.isHidden = false
            pickImage.isHidden = false
            state = false
        } else {
            editBtn.setTitle("Edit", for: .normal)
            editName.isHidden = true
            pickImage.isHidden = true
            state = true
        }
    }
    @IBAction func editName(_ sender: Any) {
        let nameVC = NameViewController(nibName: String(describing: NameViewController.self), bundle: nil)
        self.navigationController?.pushViewController(nameVC, animated: true)
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        picker.dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage else {fatalError()}
            UserDefaults.standard.setValue(image.pngData(), forKey: "imageProfile")
            self.profileImage.image = UIImage(data: image.pngData() ?? Data())
        }
    }

}
