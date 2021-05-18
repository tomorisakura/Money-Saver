//
//  EditUsageViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 17/05/21.
//

import UIKit

class EditUsageViewController: UIViewController {
    @IBOutlet weak var titlleField: UITextField!
    @IBOutlet weak var balanceField: UITextField!
    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var expanseView: UIView!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var tapIncomeGesture = UITapGestureRecognizer()
    var tapOutcomeGesture = UITapGestureRecognizer()
    
    var state : UsageState? = nil
    var status : String? = nil
    
    var passTitle : String = ""
    var passBalance : Double = 0.0
    var passIsExpanse : Bool = false
    var passIndexUsage : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passIsExpanse)
        initGesture()
        initViewEdit()
        
        if passIsExpanse {
            incomeState()
        } else {
            expanseState()
        }
    }
    
    private func initViewEdit() {
        titlleField.text = passTitle
        balanceField.text = String(passBalance)
    }
    
    private func initGesture() {
        tapIncomeGesture = UITapGestureRecognizer(target: self, action: #selector(TaskViewController.handleTapIncome(_:)))
        tapIncomeGesture.numberOfTapsRequired = 1
        tapIncomeGesture.numberOfTouchesRequired = 1
        incomeView.addGestureRecognizer(tapIncomeGesture)
        incomeView.isUserInteractionEnabled = true
        // outcome
        tapOutcomeGesture = UITapGestureRecognizer(target: self, action: #selector(TaskViewController.handleTapOutcome(_:)))
        tapOutcomeGesture.numberOfTapsRequired = 1
        tapOutcomeGesture.numberOfTouchesRequired = 1
        expanseView.addGestureRecognizer(tapOutcomeGesture)
        expanseView.isUserInteractionEnabled = true
        
        incomeView.layer.cornerRadius = 8
        expanseView.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        deleteBtn.layer.borderWidth = 3
        deleteBtn.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc func handleTapIncome(_ sender: UITapGestureRecognizer? = nil) {
        if state == .Outcome || state == nil {
            incomeState()
        }
    }
    
    @objc func handleTapOutcome(_ sender: UITapGestureRecognizer?) {
        if state == .Income || state == nil {
            expanseState()
        }
    }
    
    private func expanseState() {
        expanseView.layer.borderWidth = 3
        expanseView.layer.borderColor = UIColor.blue.cgColor
        incomeView.layer.borderWidth = 0
        state = .Outcome
        status = "Pengeluaran"
        print(state!)
    }
    
    private func incomeState() {
        incomeView.layer.borderWidth = 3
        incomeView.layer.borderColor = UIColor.blue.cgColor
        expanseView.layer.borderWidth = 0
        state = .Income
        status = "Pemasukan"
        print(state!)
    }
    
    private func updateData() {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy - HH:mm"
        dateFormatter.locale = Locale(identifier: "id_ID")
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        if state == .Income {
            usages[passIndexUsage].title = titlleField.text!
            usages[passIndexUsage].balance = Double(balanceField.text!)!
            usages[passIndexUsage].usageState = .Income
            usages[passIndexUsage].status = status!
            usages[passIndexUsage].dateTime = dateString
            
            profile.balance = profile.balance + Double(balanceField.text!)!
            profile.income = profile.income + Double(balanceField.text!)!
        } else {
            if profile.balance <= 0.0 {
                let alert = UIAlertController(title: "Galat", message: "Gagal saat update \(usages[passIndexUsage].title) pastikan saldo kamu gak kosong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok sip", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                usages[passIndexUsage].title = titlleField.text!
                usages[passIndexUsage].balance = Double(balanceField.text!)!
                usages[passIndexUsage].usageState = .Outcome
                usages[passIndexUsage].status = status!
                usages[passIndexUsage].dateTime = dateString
                
                profile.balance = profile.balance - Double(balanceField.text!)!
                profile.expanse = profile.expanse + Double(balanceField.text!)!
            }
        }
        
        print(usages)
    }
    
    private func deleteData() {
        let usage = usages[passIndexUsage]
        if state == .Income {
            usages.remove(at: passIndexUsage)
        } else {
            profile.balance += usage.balance
            usages.remove(at: passIndexUsage)
        }
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Perbarui", message: "Apakah kamu akan memperbarui \(usages[passIndexUsage].title) ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Perbarui", style: .default, handler: {_ in
            self.updateData()
            let homeVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Hapus", message: "Apakah kamu akan menghapus \(usages[passIndexUsage].title)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Batal", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: {_ in
            self.deleteData()
            let homeVC = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
