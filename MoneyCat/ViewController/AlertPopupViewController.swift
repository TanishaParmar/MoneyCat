//
//  AlertPopupViewController.swift
//  MoneyCat
//
//  Created by MyMac on 1/5/22.
//

import UIKit
import ImageIO


class AlertPopupViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var alertMessageLabel: UILabel!
    @IBOutlet weak var catGifImageView: UIImageView!
    
    //variable declaration
    var imageName = String()
    var audioName = String()
    var message = String()
    
    // vc life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Util.shared.playAudio(audioName: audioName, view: self.view)
        loadUIData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        perform(#selector(dismissAlert), with: self, afterDelay: 4)
    }
    
    @objc func dismissAlert() {
        Util.shared.pauseAudio()
        self.dismiss(animated: true, completion: nil)
    }
    
    // methods
    func loadUIData() {
        alertMessageLabel.text = message
        let img = UIImage.gifImageWithName(imageName)
        catGifImageView.image = img
    }
    
    //actions
    
}
