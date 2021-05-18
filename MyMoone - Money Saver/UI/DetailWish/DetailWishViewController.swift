//
//  DetailWishViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 16/05/21.
//

import UIKit

class DetailWishViewController: UIViewController {
    @IBOutlet weak var wishTitle: UILabel!
    @IBOutlet weak var balanceWish: UILabel!
    @IBOutlet weak var wishProgress: UIProgressView!
    @IBOutlet weak var wishProgressLbl: UILabel!
    @IBOutlet weak var precentageLbl: UILabel!
    
    var passTitle : String = ""
    var passBalance : Double = 0.0
    var passWishProgress : Float = 0.0
    var passWishProgressText : String = ""
    var passIndexKey : Int = 0
    var passIndexSection : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let priceFormater = NumberFormatter()
        priceFormater.numberStyle = .currency
        priceFormater.locale = Locale(identifier: "id_ID")
        wishTitle.text = passTitle
        balanceWish.text = priceFormater.string(from: passBalance as NSNumber)
        wishProgress.progress = passWishProgress
        wishProgressLbl.text = "\(profile.balance) / "+priceFormater.string(from: passBalance as NSNumber)!
        
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.minimumFractionDigits = 1
        percentFormatter.maximumFractionDigits = 1
        
        //precentageLbl.text = percentFormatter.string(from: NSNumber(value: passWishProgress))
        let percentage = round(passWishProgress*100)
        
        if percentage >= 100.0 {
            precentageLbl.text = "100.0%"
        } else {
            precentageLbl.text = String(round(passWishProgress*100))+"%"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func editBtn(_ sender: Any) {
        let wishViewController = WishViewController(nibName: String(describing: WishViewController.self), bundle: nil)
        self.navigationController?.pushViewController(wishViewController, animated: true)
        wishViewController.passTitle = passTitle
        wishViewController.passTarget = String(passBalance)
        wishViewController.state = .Edited
        wishViewController.passKeyIndex = passIndexKey
        wishViewController.passKeySection = passIndexSection
    }
    
}
