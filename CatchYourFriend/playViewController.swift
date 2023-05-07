//
//  playViewController.swift
//  CatchYourFriend
//
//  Created by Berkay Ozcan on 28/04/2023.
//

import UIKit

class playViewController: UIViewController {
    
    @IBOutlet weak var playLabel: UILabel!
    
    var score = 0
    var highScore = 0
    var counter = 0
    
    var timer = Timer()
    var hideTimer = Timer()
    
    var minionsArray = [UIImageView]() 

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var minion1: UIImageView!
    @IBOutlet weak var minion2: UIImageView!
    @IBOutlet weak var minion3: UIImageView!
    @IBOutlet weak var minion4: UIImageView!
    @IBOutlet weak var minion5: UIImageView!
    @IBOutlet weak var minion6: UIImageView!
    @IBOutlet weak var minion7: UIImageView!
    @IBOutlet weak var minion8: UIImageView!
    @IBOutlet weak var minion9: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selectedimage = minionModel.sharedInstance.chosenImage
        
        minion1.image = selectedimage
        minion2.image = selectedimage
        minion3.image = selectedimage
        minion4.image = selectedimage
        minion5.image = selectedimage
        minion6.image = selectedimage
        minion7.image = selectedimage
        minion8.image = selectedimage
        minion9.image = selectedimage
        
        playLabel.text = minionModel.sharedInstance.minionName
        
        scoreLabel.text = "Score : \(score)"
        
        highScoreLabel.text = "High Score : \(highScore)"
        
        let takeHighScore = UserDefaults.standard.object(forKey: "highscore")
        if takeHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        if let newScore = takeHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score : \(highScore)"
        }
        
        minion1.isUserInteractionEnabled = true
        minion2.isUserInteractionEnabled = true
        minion3.isUserInteractionEnabled = true
        minion4.isUserInteractionEnabled = true
        minion5.isUserInteractionEnabled = true
        minion6.isUserInteractionEnabled = true
        minion7.isUserInteractionEnabled = true
        minion8.isUserInteractionEnabled = true
        minion9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        minion1.addGestureRecognizer(gestureRecognizer1)
        minion2.addGestureRecognizer(gestureRecognizer2)
        minion3.addGestureRecognizer(gestureRecognizer3)
        minion4.addGestureRecognizer(gestureRecognizer4)
        minion5.addGestureRecognizer(gestureRecognizer5)
        minion6.addGestureRecognizer(gestureRecognizer6)
        minion7.addGestureRecognizer(gestureRecognizer7)
        minion8.addGestureRecognizer(gestureRecognizer8)
        minion9.addGestureRecognizer(gestureRecognizer9)
        
      minionsArray = [minion1, minion2, minion3, minion4, minion5, minion6, minion7, minion8, minion9,]
        
        
        counter = 10
        timeLabel.text = String(counter)
       
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMinions), userInfo: nil, repeats: true)
        
        hideMinions()
    }
    
  

    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func hideMinions(){
        for minions in minionsArray{
            minions.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(minionsArray.count - 1)))
        minionsArray[random].isHidden = false
        
    }
    
    @objc func countdown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for minions in minionsArray {
                minions.isHidden = true
            }
            
            if score > highScore {
                highScore = score
                highScoreLabel.text = "High Score : \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time's up!", message: "Do you want play again ? ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){ [self]
                (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 15
                self.timeLabel.text = String(self.counter)
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
                
                
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMinions), userInfo: nil, repeats: true)
             
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
            
        }
        
        
    }
    
    
    
    
    
}
