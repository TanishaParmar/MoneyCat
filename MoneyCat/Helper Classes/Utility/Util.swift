//
//  Util.swift
//  MoneyCat
//
//  Created by MyMac on 1/6/22.
//

import Foundation
import UIKit
import AVFoundation

class Util {
    
    static var shared = Util()
    var player = AVPlayer()
    
    func userDefaults(forKey key: String?) -> Any? {
        let standardUserDefaults = UserDefaults.standard
        var val: String? = nil
        
        if standardUserDefaults != nil {
            val = standardUserDefaults.object(forKey: key ?? "") as? String
        }
        
        return val
    }
    
    func save(toUserDefaults value: Any?, withKey key: String?) {
        var standardUserDefaults = UserDefaults.standard
        
        if standardUserDefaults != nil {
            standardUserDefaults.set(value, forKey: key ?? "")
            standardUserDefaults.synchronize()
        }
    }
    
    func present(title: String?, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
        })
        
        //Add OK button to a dialog message
        alertController.addAction(ok)
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func playAudio(audioName: String, view: UIView) {
        let url = Bundle.main.url(forResource: audioName, withExtension: "mp3")
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func pauseAudio() {
        player.pause()
    }
    
}

