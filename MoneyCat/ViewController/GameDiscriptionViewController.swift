//
//  GameDiscriptionViewController.swift
//  MoneyCat
//
//  Created by MyMac on 1/3/22.
//

import UIKit

class GameDiscriptionViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var discriptionCollectionView: UICollectionView!
    
    //variable declaration
    
    
    // vc life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
    }
    
    // methods
    func registerCell() {
        discriptionCollectionView.delegate = self
        discriptionCollectionView.dataSource = self
        let nib = UINib(nibName: "DiscriptionCollectionViewCell", bundle: nil)
        discriptionCollectionView.register(nib, forCellWithReuseIdentifier: "DiscriptionCollectionViewCell")
        let slotNib = UINib(nibName: "SlotCollectionViewCell", bundle: nil)
        discriptionCollectionView.register(slotNib, forCellWithReuseIdentifier: "SlotCollectionViewCell")
    }
    
    
    //actions
    @objc func infoButtonAction() {
        let indexPath = IndexPath(item: 0, section: 0)
        discriptionCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    
}



extension GameDiscriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscriptionCollectionViewCell", for: indexPath) as! DiscriptionCollectionViewCell
            cell.backgroundColor = .black
            
            return cell

        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCollectionViewCell", for: indexPath) as! SlotCollectionViewCell
                
//            cell.setupUI()
            cell.infoButton.addTarget(self, action: #selector(infoButtonAction), for: .touchUpInside)
            return cell

        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: collectionView.frame.size.height)
    }
    
    
}


struct HomeData{
    var detailImgName: String
    var resultImgName: String
    var isLastCell: Bool = false
}
