//
//  ViewController.swift
//  GamingApp
//
//  Created by Fizzah Jabeen on 12/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    
    var timer = Timer()
    
    var counter = 20
    
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var Kenny1: UIImageView!
    @IBOutlet weak var Kenny2: UIImageView!
    @IBOutlet weak var Kenny3: UIImageView!
    @IBOutlet weak var Kenny4: UIImageView!
    @IBOutlet weak var Kenny5: UIImageView!
    @IBOutlet weak var Kenny6: UIImageView!
    @IBOutlet weak var Kenny7: UIImageView!
    @IBOutlet weak var Kenny8: UIImageView!
    @IBOutlet weak var Kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "HighScore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore \(highScore)"
        }
        
        Kenny1.isUserInteractionEnabled = true
        Kenny2.isUserInteractionEnabled = true
        Kenny3.isUserInteractionEnabled = true
        Kenny4.isUserInteractionEnabled = true
        Kenny5.isUserInteractionEnabled = true
        Kenny6.isUserInteractionEnabled = true
        Kenny7.isUserInteractionEnabled = true
        Kenny8.isUserInteractionEnabled = true
        Kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        Kenny1.addGestureRecognizer(recognizer1)
        
        Kenny2.addGestureRecognizer(recognizer2)
        
        Kenny3.addGestureRecognizer(recognizer3)
        
        Kenny4.addGestureRecognizer(recognizer4)
        
        Kenny5.addGestureRecognizer(recognizer5)
        
        Kenny6.addGestureRecognizer(recognizer6)
        
        Kenny7.addGestureRecognizer(recognizer7)
        
        Kenny8.addGestureRecognizer(recognizer8)
        
        Kenny9.addGestureRecognizer(recognizer9)
        
        
        kennyArray = [Kenny1, Kenny2, Kenny3, Kenny4, Kenny5, Kenny6, Kenny7, Kenny8, Kenny9]
        
        //timers
        counter = 20
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny() }
    
    @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "HighScore: \(self.highScore)"
            }
            // Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil ,repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated:  true, completion: nil)
            
        }
    }
    
}
