//
//  DreamsViewController.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class DreamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var wishTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    var indexUpdated : Int? = nil
    var sectionUpdate : Int? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        wishTableView.delegate = self
        wishTableView.dataSource = self
        
        let uiNib = UINib(nibName: String(describing: WishTableViewCell.self), bundle: nil)
        wishTableView.register(uiNib, forCellReuseIdentifier: String(describing: WishTableViewCell.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if wishList.isEmpty {
            wishTableView.isHidden = true
            emptyView.isHidden = false
            return 0;
        } else {
            wishTableView.isHidden = false
            emptyView.isHidden = true
            return wishList.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailWishController = DetailWishViewController(nibName: String(describing: DetailWishViewController.self), bundle: nil)
        self.navigationController?.pushViewController(detailWishController, animated: true)
        let wish = wishList[indexPath.row]
        detailWishController.passTitle = wish.title
        detailWishController.passBalance = wish.balanceProgress
        detailWishController.passWishProgress = wish.progress
        detailWishController.passWishProgressText = String(wish.balanceProgress)
        detailWishController.passIndexKey = indexPath.row
        detailWishController.passIndexSection = indexPath.section
        //print("\(indexPath.row) , \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let priceFormater = NumberFormatter()
        priceFormater.numberStyle = .currency
        priceFormater.locale = Locale(identifier: "id_ID")
        let cell = wishTableView.dequeueReusableCell(withIdentifier: String(describing: WishTableViewCell.self), for: indexPath) as! WishTableViewCell
        let wish = wishList[indexPath.row]
        cell.titleLbl.text = wish.title
        cell.balanceProgressLbl.text = "\(priceFormater.string(from: profile.balance as NSNumber)!) / "+priceFormater.string(from: wish.balanceProgress as NSNumber)!
        cell.wishProgress.progress = wish.progress
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        wishTableView.reloadData()
    }
    
    @IBAction func addWish(_ sender: Any) {
        let wishViewController = WishViewController(nibName: String(describing: WishViewController.self), bundle: nil)
        wishViewController.state = .None
        self.navigationController?.pushViewController(wishViewController, animated: true)
    }
    
    @IBAction func createWish(_ sender: Any) {
        let wishViewController = WishViewController(nibName: String(describing: WishViewController.self), bundle: nil)
        wishViewController.state = .None
        self.navigationController?.pushViewController(wishViewController, animated: true)
    }
    
}
