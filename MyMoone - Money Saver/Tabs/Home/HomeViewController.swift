//
//  HomeViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currentBalanceLbl: UILabel!
    @IBOutlet weak var emptyDataLbl: UILabel!
    @IBOutlet weak var incomeBalance: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var outcomeBalance: UILabel!
    @IBOutlet weak var viewTable: UITableView!
    @IBOutlet weak var greetingLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTable.dataSource = self
        viewTable.delegate = self
        
        //register usage cell
        let uiNib = UINib(nibName: String(describing: TableViewCell.self), bundle: nil)
        viewTable.register(uiNib, forCellReuseIdentifier: String(describing: TableViewCell.self))
        
        initView()
        initGreeting()
    }
    
    private func initView() {
        let priceFormater = NumberFormatter()
        priceFormater.numberStyle = .currency
        priceFormater.locale = Locale(identifier: "id_ID")
        currentBalanceLbl.text = priceFormater.string(from: profile.balance as NSNumber)
        incomeBalance.text = priceFormater.string(from: profile.income as NSNumber)
        outcomeBalance.text = priceFormater.string(from: profile.expanse as NSNumber)
        nameLbl.text = profile.name
        viewTable.reloadData()
    }
    
    private func initGreeting() {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        
        if hourInt >= 11 && hourInt <= 14 {
            greetingLbl.text = "Selamat Siang"
        }
        else if hourInt >= 0 && hourInt <= 10 {
            greetingLbl.text = "Selamat Pagi"
        }
        else if hourInt >= 15 && hourInt <= 18 {
            greetingLbl.text = "Selamat Sore"
        }
        else if hourInt >= 19 && hourInt <= 24 {
            greetingLbl.text = "Selamat Malam"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if usages.isEmpty {
            viewTable.isHidden = true
            emptyDataLbl.isHidden = false
            return 0;
        } else {
            emptyDataLbl.isHidden = true
            viewTable.isHidden = false
            return usages.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailUSageViewController(nibName: String(describing: DetailUSageViewController.self), bundle: nil)
        let usage = usages[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
        detailController.passTitle = usage.title
        detailController.passBalance = usage.balance
        detailController.passDateUsage = usage.dateTime
        detailController.passIdUsage = usage.id
        detailController.passExpanseStatus = usage.status
        detailController.passIndexUsage = indexPath.row
        if usage.usageState == .Income {
            detailController.passImage = UIImage(named: "ArrowUp")
        } else {
            detailController.passImage = UIImage(named: "ArrowDown")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let usage = usages[indexPath.row]
        let priceFormater = NumberFormatter()
        priceFormater.numberStyle = .currency
        priceFormater.locale = Locale(identifier: "id_ID")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        cell.dateTime.text = usage.dateTime
        cell.title.text = usage.title
        
        if usage.usageState == .Income {
            cell.imageState.image = UIImage(named: "ArrowUp")
            cell.balance.textColor = UIColor.green
            cell.balance.text = "+ "+priceFormater.string(from: usage.balance as NSNumber)!
        } else {
            cell.imageState.image = UIImage(named: "ArrowDown")
            cell.balance.text = "- "+priceFormater.string(from: usage.balance as NSNumber)!
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        initView()
    }
    
    @IBAction func taskButton(_ sender: Any) {
        let taskViewController = TaskViewController(nibName: String(describing: TaskViewController.self), bundle: nil)
        self.navigationController?.pushViewController(taskViewController, animated: true)
    }
    
}
