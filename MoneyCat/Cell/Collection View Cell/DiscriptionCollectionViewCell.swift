//
//  DiscriptionCollectionViewCell.swift
//  MoneyCat
//
//  Created by MyMac on 1/3/22.
//

import UIKit

class DiscriptionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listingTableView: UITableView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    //MARK: variables declaration
    let listingArray :[HomeData] = [HomeData(detailImgName: "cat", resultImgName: "800"),HomeData(detailImgName: "icon", resultImgName: "80"),HomeData(detailImgName: "bar", resultImgName: "40"),HomeData(detailImgName: "bb", resultImgName: "25"),HomeData(detailImgName: "b", resultImgName: "10"),HomeData(detailImgName: "", resultImgName: "twoo", isLastCell: true)]
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerCell()
    }
    
    //MARK: - Methods
    func registerCell() {
        listingTableView.dataSource = self
        listingTableView.delegate = self
        let nib = UINib(nibName: "ListingTableViewCell", bundle: nil)
        listingTableView.register(nib, forCellReuseIdentifier: "ListingTableViewCell")
        tableViewWidth.constant = Constant.DeviceType.IS_IPAD ? UIScreen.main.bounds.width * 0.83 : UIScreen.main.bounds.width
    }

}


extension DiscriptionCollectionViewCell : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath) as! ListingTableViewCell
        cell.selectionStyle = .none
        let data = listingArray[indexPath.row]
        let firstImage = UIImage(named: data.detailImgName)
        cell.imageOne.image = firstImage
        cell.imageTwo.image = firstImage
        cell.imageThree.image = firstImage
        cell.imageFour.image = firstImage
        let secondImage = UIImage(named: data.resultImgName)
        cell.imageFour.image = secondImage
        if data.isLastCell {
            let lastIndexImg = UIImage(named: "icons")
            cell.imageThree.image = lastIndexImg
            cell.lastImage.isHidden = false
            let anyOneImg = UIImage(named: "anyone")
            cell.lastImage.image = anyOneImg
        }
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height * 0.165
    }
    
}
