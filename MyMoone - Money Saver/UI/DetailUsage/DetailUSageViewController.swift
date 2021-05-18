//
//  DetailUSageViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class DetailUSageViewController: UIViewController {
    
    @IBOutlet weak var imageStateDetail: UIImageView!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var statusDetail: UILabel!
    @IBOutlet weak var balanceDetail: UILabel!
    @IBOutlet weak var idUsage: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var dateUsage: UILabel!
    @IBOutlet weak var expanseStatus: UILabel!
    
    var passTitle: String = ""
    var passBalance : Double = 0.0
    var passIdUsage : Int = 0
    var passDateUsage : String = ""
    var passImage : UIImage?
    var passExpanseStatus : String = ""
    var passIndexUsage : Int = 0
    
    private var isExpanse : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        let priceFormater = NumberFormatter()
        priceFormater.numberStyle = .currency
        priceFormater.locale = Locale(identifier: "id_ID")
        titleDetail.text = passTitle
        balanceDetail.text = priceFormater.string(from: passBalance as NSNumber)
        idUsage.text = String(passIdUsage)
        dateUsage.text = passDateUsage
        expanseStatus.text = passExpanseStatus
        imageStateDetail.image = passImage
        
        if passExpanseStatus.elementsEqual("Pemasukan") {
            isExpanse = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func editBtn(_ sender: Any) {
        let editVC = EditUsageViewController(nibName: String(describing: EditUsageViewController.self), bundle: nil)
        self.navigationController?.pushViewController(editVC, animated: true)
        editVC.passTitle = passTitle
        editVC.passBalance = passBalance
        editVC.passIsExpanse = isExpanse
        editVC.passIndexUsage = passIndexUsage
    }
    

}
