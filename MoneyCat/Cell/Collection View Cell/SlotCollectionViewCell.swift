//
//  SlotCollectionViewCell.swift
//  MoneyCat
//
//  Created by MyMac on 1/3/22.
//

import UIKit
import AVFoundation

class SlotCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - outlets
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var buttonsBgView: UIView!
    @IBOutlet weak var slotView: UIView!
    @IBOutlet weak var totalCoinsLabel: UILabel!
    @IBOutlet weak var boxImageView: UIImageView!
    @IBOutlet weak var purchaseLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var maxButton: UIButton!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var goBankButton: UIButton!
    @IBOutlet weak var mainViewWidth: NSLayoutConstraint!
    
    
    //MARK: - variable declaration
    var coinNumber = 0
    var slotMachine = ZCSlotMachine()
    var slotIcons = NSMutableArray()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    //MARK: - Setup UI
    func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.orangeView.roundCorners(topLeft: self.orangeView.frame.width / 2, topRight: self.orangeView.frame.width / 2, bottomLeft: 10, bottomRight: 10)
            self.yellowView.roundCorners(topLeft: self.yellowView.frame.width / 2, topRight: self.yellowView.frame.width / 2, bottomLeft: 10, bottomRight: 10)
            self.shadowView.roundCorners(topLeft: 0.0, topRight: 0.0, bottomLeft: 10.0, bottomRight: 10.0)
            self.buttonsBgView.roundCorners(topLeft: 0.0, topRight: 0.0, bottomLeft: 10.0, bottomRight: 10.0)

            self.scoreView.roundCorners(topLeft: 0.0, topRight: 0.0, bottomLeft: 10.0, bottomRight: 10.0)
        }
        self.mainViewWidth.constant = Constant.DeviceType.IS_IPAD ? UIScreen.main.bounds.width * 0.75 : UIScreen.main.bounds.width * 0.9
        totalCoinsLabel.text = "\(Util.shared.userDefaults(forKey: "totalCoins") ?? 0)"

        appendSlotIcons()
    }
    
    //MARK: - Methods
    
    func appendSlotIcons() {
        if let image = UIImage(named: "LuckyCat") {
            slotIcons.add(image)
        }
        if let image = UIImage(named: "ichingcoinv6.png") {
            slotIcons.add(image)
        }
        if let image = UIImage(named: "3Bar.png") {
            slotIcons.add(image)
        }
        if let image = UIImage(named: "1Bar.png") {
            slotIcons.add(image)
        }
        if let image = UIImage(named: "2Bar.png") {
            slotIcons.add(image)
        }
        if let image = UIImage(named: "LuckyCat.png") {
            slotIcons.add(image)
        }
        if let image = UIImage(named: "fuv4copy.png") {
            slotIcons.add(image)
        }
        if let image = UIImage(named: "1Bar.png") {
            slotIcons.add(image)
        }
        
                
        slotMachine = Constant.DeviceType.IS_IPAD ? ZCSlotMachine(frame: CGRect(x: 30, y: 0, width: UIScreen.main.bounds.width * 0.44, height: UIScreen.main.bounds.width * 0.39)) : ZCSlotMachine(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.61, height: UIScreen.main.bounds.width * 0.39))
        
        slotMachine.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        slotMachine.contentInset = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)

        slotMachine.delegate = self
        slotMachine.dataSource = self
        slotMachine.backgroundColor = UIColor.clear
        slotView.addSubview(slotMachine)
    }
    
    func presentAlertView(imageName: String, titleText: String, audioName: String) {
        if let topVC = UIApplication.getTopViewController() {
            let vc = topVC.storyboard?.instantiateViewController(withIdentifier: "AlertPopupViewController") as! AlertPopupViewController
            vc.message = titleText
            vc.imageName = imageName
            vc.audioName = audioName
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            topVC.present(vc, animated: true, completion: nil)
        }
    }
        

    //MARK: - Actions
    @IBAction func oneButtonAction(_ sender: Any) {
        let coinCount = Int(totalCoinsLabel.text!)
        if coinCount! >= 1 {
            oneButton.isSelected = true
            twoButton.isSelected = false
            maxButton.isSelected = false
            coinNumber = 1
        }
        else {
            print("Please refill coins first..")
        }
    }
    
    @IBAction func twoButtonAction(_ sender: Any) {
        let coinCount = Int(totalCoinsLabel.text!)
        if coinCount! >= 1 {
            oneButton.isSelected = false
            twoButton.isSelected = true
            maxButton.isSelected = false
            coinNumber = 2
        }
        else {
            print("Please refill coins first..")
        }
    }
    
    @IBAction func maxButtonAction(_ sender: Any) {
        let coinCount = Int(totalCoinsLabel.text!)
        if coinCount! >= 1 {
            oneButton.isSelected = false
            twoButton.isSelected = false
            maxButton.isSelected = true
            coinNumber = 3
        }
        else {
            print("Please refill coins first..")
        }
    }
    
    @IBAction func spinButtonAction(_ sender: Any) {
        if oneButton.isSelected == true || twoButton.isSelected == true || maxButton.isSelected == true {
            let slotIconCount = slotIcons.count
            let x = drand48()
            let y = drand48()
            let z = drand48()
            let slotOneIndex = Int(abs(Float(x * Double(slotIconCount))))
            let slotTwoIndex = Int(abs(Float(y * Double(slotIconCount))))
            let slotThreeIndex = Int(abs(Float(z * Double(slotIconCount))))
            
            slotMachine.slotResults = [NSNumber(value: slotOneIndex), NSNumber(value: slotTwoIndex), NSNumber(value: slotThreeIndex)]
            Util.shared.playAudio(audioName: "machineRunning", view: self.contentView)
            slotMachine.startSliding()
        } else {
            DispatchQueue.main.async {
                if let topVC = UIApplication.getTopViewController() {
                    Util.shared.present(title: "PayTable", message: "Please bet coins first..", from: topVC)
                }
            }
        }
    }
    
    @IBAction func goBankButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            if let topVC = UIApplication.getTopViewController() {
                Util.shared.present(title: Constant.appName, message: "You have increased 500 coins in your account.", from: topVC)
            }
        }
        var count = Int(Util.shared.userDefaults(forKey: "totalCoins") as! String) ?? 0
        count = count + 500
        debugPrint("You have increased 500 coins in your account.")
        Util.shared.save(toUserDefaults: "\(count)", withKey: "totalCoins")
        totalCoinsLabel.text = "\(Util.shared.userDefaults(forKey: "totalCoins") ?? 0)"
    }
    
    
}


//MARK: - ZCSlotMachineDataSource

extension SlotCollectionViewCell : ZCSlotMachineDataSource {
    func numberOfSlots(in slotMachine: ZCSlotMachine!) -> UInt {
        3
    }
    
    func iconsForSlots(in slotMachine: ZCSlotMachine!) -> [Any]! {
        slotIcons as? [Any]
    }
    
    func slotWidth(in slotMachine: ZCSlotMachine!) -> CGFloat {
        (UIScreen.main.bounds.width * 0.6)/3
    }
    
    func slotSpacing(in slotMachine: ZCSlotMachine!) -> CGFloat {
        5.0
    }
    
}

//MARK: - ZCSlotMachineDelegate

extension SlotCollectionViewCell : ZCSlotMachineDelegate {
    func slotMachineWillStartSliding(_ slotMachine: ZCSlotMachine?) {
        spinButton.isSelected = true
        spinButton.isEnabled = false
    }
    
    func slotMachineDidEndSliding(_ slotMachine: ZCSlotMachine?) {
        spinButton.isSelected = false
        spinButton.isEnabled = true
        Util.shared.pauseAudio()
        
        let mainSring = (slotMachine?.slotResults as? [Int] ?? []).compactMap{ $0 }.map(String.init).joined(separator: "")
        print(mainSring)
        var coinCount = Int(totalCoinsLabel.text!)
        
        if (mainSring == "000") || (mainSring == "111") || (mainSring == "222") || (mainSring == "333") || (mainSring == "444") || (mainSring == "555") || (mainSring == "777") {
            
            print("Jackpot")
            if mainSring == "000" {
                if oneButton.isSelected {
                    coinCount = coinCount! + 800
                    print("Congratulations! you won 800 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 800 coins.", audioName: "won")
                }
                else if twoButton.isSelected {
                    coinCount = coinCount! + 1600
                    print("Congratulations! you won 1600 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 1600 coins.", audioName: "won")
                }
                else if maxButton.isSelected {
                    coinCount = coinCount! + 2400
                    print("Congratulations! you won 2400 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 2400 coins.", audioName: "won")
                }
            }
            else if mainSring == "111" {
                if oneButton.isSelected {
                    coinCount = coinCount! + 80
                    print("Congratulations! you won 80 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 80 coins.", audioName: "won")
                }
                else if twoButton.isSelected {
                    coinCount = coinCount! + 160
                    print("Congratulations! you won 160 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 160 coins.", audioName: "won")
                }
                else if maxButton.isSelected {
                    coinCount = coinCount! + 240
                    print("Congratulations! you won 240 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 240 coins.", audioName: "won")
                }
            }
            else if mainSring == "222" {
                if oneButton.isSelected {
                    coinCount = coinCount! + 40
                    print("Congratulations! you won 40 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 40 coins.", audioName: "won")
                }
                else if twoButton.isSelected {
                    coinCount = coinCount! + 80
                    print("Congratulations! you won 80 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 80 coins.", audioName: "won")
                }
                else if maxButton.isSelected {
                    coinCount = coinCount! + 120
                    print("Congratulations! you won 120 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 120 coins.", audioName: "won")
                }
            }
            else if mainSring == "333" {
                if oneButton.isSelected {
                    coinCount = coinCount! + 25
                    print("Congratulations! you won 25 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 25 coins.", audioName: "won")
                }
                else if twoButton.isSelected {
                    coinCount = coinCount! + 50
                    print("Congratulations! you won 50 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 50 coins.", audioName: "won")
                }
                else if maxButton.isSelected {
                    coinCount = coinCount! + 75
                    print("Congratulations! you won 75 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 75 coins.", audioName: "won")
                }
            }
            else if mainSring == "444" {
                if oneButton.isSelected {
                    coinCount = coinCount! + 10
                    print("Congratulations! you won 10 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 10 coins.", audioName: "won")
                }
                else if twoButton.isSelected {
                    coinCount = coinCount! + 20
                    print("Congratulations! you won 20 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 20 coins.", audioName: "won")
                }
                else if maxButton.isSelected {
                    coinCount = coinCount! + 30
                    print("Congratulations! you won 30 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 30 coins.", audioName: "won")
                }
            }
            else if mainSring == "555" {
                if oneButton.isSelected {
                    coinCount = coinCount! + 800
                    print("Congratulations! you won 800 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 800 coins.", audioName: "won")
                }
                else if twoButton.isSelected {
                    coinCount = coinCount! + 1600
                    print("Congratulations! you won 1600 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 1600 coins.", audioName: "won")
                }
                else if maxButton.isSelected {
                    coinCount = coinCount! + 2400
                    print("Congratulations! you won 2400 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 2400 coins.", audioName: "won")
                }
            }
            else if mainSring == "777" {
                if oneButton.isSelected {
                    coinCount = coinCount! + 10
                    print("Congratulations! you won 10 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 10 coins.", audioName: "won")
                }
                else if twoButton.isSelected {
                    coinCount = coinCount! + 20
                    print("Congratulations! you won 20 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 20 coins.", audioName: "won")
                }
                else if maxButton.isSelected {
                    coinCount = coinCount! + 30
                    print("Congratulations! you won 30 coins.")
                    self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 30 coins.", audioName: "won")
                }
            }
            
        }
        else if (mainSring == "055") || (mainSring == "505") || (mainSring == "550") || (mainSring == "005") || (mainSring == "500") || (mainSring == "050") {
            if oneButton.isSelected {
                coinCount = coinCount! + 800
                print("Congratulations! you won 800 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 800 coins.", audioName: "won")
            }
            else if twoButton.isSelected {
                coinCount = coinCount! + 1600
                print("Congratulations! you won 1600 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 1600 coins.", audioName: "won")
            }
            else if maxButton.isSelected {
                coinCount = coinCount! + 2400
                print("Congratulations! you won 2400 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 2400 coins.", audioName: "won")
            }
        }
        else if (mainSring == "477") || (mainSring == "747") || (mainSring == "774") || (mainSring == "447") || (mainSring == "744") || (mainSring == "474") {
            if oneButton.isSelected {
                coinCount = coinCount! + 10
                print("Congratulations! you won 10 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 10 coins.", audioName: "won")
            }
            else if twoButton.isSelected {
                coinCount = coinCount! + 20
                print("Congratulations! you won 20 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 20 coins.", audioName: "won")
            }
            else if maxButton.isSelected {
                coinCount = coinCount! + 30
                print("Congratulations! you won 30 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 30 coins.", audioName: "won")
            }
        }
        else if (mainSring as NSString).range(of: "6").location != NSNotFound {
            if oneButton.isSelected {
                coinCount = coinCount! + 2
                print("Congratulations! you won 2 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 2 coins.", audioName: "won")
            }
            else if twoButton.isSelected {
                coinCount = coinCount! + 4
                print("Congratulations! you won 4 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 4 coins.", audioName: "won")
            }
            else if maxButton.isSelected {
                coinCount = coinCount! + 6
                print("Congratulations! you won 6 coins.")
                self.presentAlertView(imageName: "smileCat", titleText: "Congratulations! you won 6 coins.", audioName: "won")
            }
        }
        else {
            if coinCount != 0 {
                coinCount = coinCount! - coinNumber
                if coinCount! < 0 {
                    coinCount = 0
                }
                print("Sorry! you lost \(coinNumber) coins.")
                self.presentAlertView(imageName: "cryCat", titleText: "Sorry! you lost \(coinNumber) coins.", audioName: "lost")
            }
        }
        
        totalCoinsLabel.text = "\(coinCount ?? 0)"
        Util.shared.save(toUserDefaults: "\(coinCount ?? 0)", withKey: "totalCoins")
        oneButton.isSelected = false
        twoButton.isSelected = false
        maxButton.isSelected = false
        
    }
    
    
}
