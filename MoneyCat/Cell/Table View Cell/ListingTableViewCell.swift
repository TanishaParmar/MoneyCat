//
//  ListingTableViewCell.swift
//  MoneyCat
//
//  Created by MyMac on 1/5/22.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet weak var lastImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
