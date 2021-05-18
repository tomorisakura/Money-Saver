//
//  NameViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 17/05/21.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(profile)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
        let profileVC = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        updateProfile()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func updateProfile() {
        profile = Profile(name: nameField.text!, balance: profile.balance, income: profile.income, expanse: profile.expanse)
        print(profile)
    }
    
}
