//
//  TaskViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var jumlahLbl: UILabel!
    @IBOutlet weak var balanceField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var income: UIView!
    @IBOutlet weak var pengeluaran: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var tapIncomeGesture = UITapGestureRecognizer()
    var tapOutcomeGesture = UITapGestureRecognizer()
    
    var state : UsageState? = nil
    var status : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func initGesture() {
        tapIncomeGesture = UITapGestureRecognizer(target: self, action: #selector(TaskViewController.handleTapIncome(_:)))
        tapIncomeGesture.numberOfTapsRequired = 1
        tapIncomeGesture.numberOfTouchesRequired = 1
        income.addGestureRecognizer(tapIncomeGesture)
        income.isUserInteractionEnabled = true
        // outcome
        tapOutcomeGesture = UITapGestureRecognizer(target: self, action: #selector(TaskViewController.handleTapOutcome(_:)))
        tapOutcomeGesture.numberOfTapsRequired = 1
        tapOutcomeGesture.numberOfTouchesRequired = 1
        pengeluaran.addGestureRecognizer(tapOutcomeGesture)
        pengeluaran.isUserInteractionEnabled = true
        
        income.layer.cornerRadius = 8
        pengeluaran.layer.cornerRadius = 8
    }
    
    
    @objc func handleTapIncome(_ sender: UITapGestureRecognizer? = nil) {
        if state == .Outcome || state == nil {
            income.layer.borderWidth = 3
            income.layer.borderColor = UIColor.blue.cgColor
            pengeluaran.layer.borderWidth = 0
            state = .Income
            status = "Pemasukan"
            print(state!)
        }
    }
    
    @objc func handleTapOutcome(_ sender: UITapGestureRecognizer?) {
        if state == .Income || state == nil {
            pengeluaran.layer.borderWidth = 3
            pengeluaran.layer.borderColor = UIColor.blue.cgColor
            income.layer.borderWidth = 0
            state = .Outcome
            status = "Pengeluaran"
            print(state!)
        }
    }
    
    private func insertData(state : UsageState) {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy - HH:mm"
        dateFormatter.locale = Locale(identifier: "id_ID")
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        let tempBalance = Double(balanceField.text!)
        
        switch state {
        case .Income:
            let newUsage = Usage(id: usages.count+1, title: titleField.text!, dateTime: dateString, balance: tempBalance!, usageState: state, status: status!)
            profile.balance = profile.balance + tempBalance!
            profile.income = profile.income + tempBalance!
            usages.insert(newUsage, at: 0)
            
        case .Outcome:
            let newUsage = Usage(id: usages.count+1, title: titleField.text!, dateTime: dateString, balance: tempBalance!, usageState: state, status: status!)
            profile.balance = profile.balance - tempBalance!
            profile.expanse = profile.expanse + tempBalance!
            usages.insert(newUsage, at: 0)
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        if balanceField.text?.isEmpty == true && titleField.text?.isEmpty == true {
            showAlert(message: "Field Gaboleh Kosong")
        }else {
            let homeVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
            insertData(state: state!)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Galat", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Batal", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
