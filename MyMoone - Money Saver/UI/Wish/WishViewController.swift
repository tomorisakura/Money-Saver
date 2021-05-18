//
//  WishViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class WishViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var targetField: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var state : WishState? = nil
    var passTitle : String = ""
    var passTarget : String = ""
    var passKeyIndex : Int = 0
    var passKeySection : Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch state {
        case .Edited:
            titleField.text = passTitle
            targetField.text = passTarget
            
            updateBtn.setTitle("Perbarui", for: .normal)
            deleteBtn.isHidden = false
            deleteBtn.isEnabled = true
            
            print(passKeyIndex)
            
        default:
            deleteBtn.isHidden = true
            deleteBtn.isEnabled = false
        }
        
        initButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        deleteBtn.layer.borderWidth = 3
        deleteBtn.layer.borderColor = UIColor.red.cgColor
    }
    
    func initButtonState() {
        if titleField.text?.isEmpty == false && targetField.text?.isEmpty == false{
            editButtonItem.isEnabled = true
        }else {
            editButtonItem.isEnabled = false
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let dreamVC = DreamsViewController(nibName: String(describing: DreamsViewController.self), bundle: nil)
        
        if state == .Edited {
            print("Edited")
            updateData()
            self.navigationController?.pushViewController(dreamVC, animated: true)
            
        } else if state == .None {
            print("Save new wish")
            if titleField.text!.isEmpty == true && targetField.text!.isEmpty == true {
                let alert = UIAlertController(title: "Galat", message: "Field gaboleh kosong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                let progressCount = profile.balance / Double(targetField.text!)!
                let newWish = Wish(id: wishList.count+1, title: titleField.text!, progress: Float(progressCount), balanceProgress: Double(targetField.text!) ?? 0.0)
                wishList.append(newWish)
                print(progressCount * 100)
                self.navigationController?.pushViewController(dreamVC, animated: true)
            }
        }
    }
    
    private func updateData() {
        let currentProgress = Float(profile.balance / Double(targetField.text!)!)
        wishList[passKeyIndex] = Wish(id: wishList[passKeyIndex].id, title: titleField.text!, progress: currentProgress, balanceProgress: Double(targetField.text!) ?? 0.0)
    }
    
    private func deleteData() {
        print("Delete \(wishList[passKeyIndex].title)")
        wishList.remove(at: passKeyIndex)
    }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Hapus", message: "Apakah kamu akan menghapus \(wishList[passKeyIndex].title)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Batal", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: {_ in
            self.deleteData()
            let dreamVC = DreamsViewController(nibName: String(describing: DreamsViewController.self), bundle: nil)
            self.navigationController?.pushViewController(dreamVC, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
