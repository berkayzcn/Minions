//
//  ViewController.swift
//  CatchYourFriend
//
//  Created by Berkay Ozcan on 26/04/2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var playbttn: UIButton!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playbttn.layer.cornerRadius = 14
        
        let takeHighScore = UserDefaults.standard.object(forKey: "highscore")
        if takeHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        if let newScore = takeHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "High Score : \(highScore)"
        }
    }

    @IBAction func playButton(_ sender: Any) {
        performSegue(withIdentifier: "toSecondVc", sender: nil)
    }
    
}

