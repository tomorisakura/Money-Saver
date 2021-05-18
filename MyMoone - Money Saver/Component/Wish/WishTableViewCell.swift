//
//  WishTableViewCell.swift
//  MyMoone - Money Saver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class WishTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var balanceProgressLbl: UILabel!
    @IBOutlet weak var wishProgress: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
