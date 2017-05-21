//
//  ViewController.swift
//  BreathingTimer
//
//  Created by Daniele on 2017-05-16.
//  Copyright © 2017 Daniele Perazzolo. All rights reserved.
//

import UIKit

class TimerController: UIViewController {
    // Values
    let MAX_TIME = 6
    let START_TIME = 0
    let PAUSE_TIME = 2
    let ANIMATE_SIZE = CGFloat(10.0)
    let actions = ["INHALE", "HOLD", "EXHALE"]
    var curTime = 0
    var breathDirection = true // (true, inhale), (false, exhale)
    
    // Colors
    var dark = #colorLiteral(red: 0.2638265491, green: 0.3153602183, blue: 0.3580936491, alpha: 1)
    var medium = #colorLiteral(red: 0.5115888119, green: 0.6059057117, blue: 0.6216838956, alpha: 1)
    var light = #colorLiteral(red: 0.8500891328, green: 0.8663892746, blue: 0.8635664582, alpha: 1)

    // UI Outlets
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var directionText: UILabel!
    @IBOutlet weak var shape: UILabel!
    @IBOutlet weak var instructions: UILabel!
    
    // UI Actions
    // Reset ui if screen is tapped to sync breathing
    // TODO: Fix weird reset on exhale
    @IBAction func syncTimeAndBreath(_ sender: Any) {
        // Reset UI Colors
        UIView.transition(with: shape, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.shape.backgroundColor = self.dark
        }, completion: nil)
        UIView.transition(with: directionText, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.directionText.textColor = self.medium
        }, completion: nil)
        UIView.transition(with: instructions, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.instructions.textColor = self.medium
        }, completion: nil)
        UIView.transition(with: time, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.time.textColor = self.light
        }, completion: nil)
        
        curTime = START_TIME
        breathDirection = true
        directionText.text = actions[0]
        
        // Add letter spacing to inhale/exhale
        directionText.letter(spacing: 15.0)
        
        time.text = "\(curTime)"
        UILabel.animate(withDuration: 0, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
            self.shape?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        // Add letter spacing to inhale/exhale
        directionText.letter(spacing: 15.0)
        
        // Add Rounded Corners to the shape which will grow and shrink
        shape.layer.cornerRadius = 40
        shape.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        curTime += 1
        
        // Inhale
        if (breathDirection) {
            // If starting inhale begin animation
            if (curTime == 1) {
                UILabel.animate(withDuration: TimeInterval(MAX_TIME), animations: {() -> Void in
                    self.shape?.transform = CGAffineTransform(scaleX: self.ANIMATE_SIZE, y: self.ANIMATE_SIZE)
                })
            }
            
            // If less than MAX_TIME
            if (curTime <= MAX_TIME) {
                time.text = "\(curTime)"
            // If MAX_TIME has passed change to hold breath
            } else if (curTime == MAX_TIME+1) {
                // Reverse UI Colors
                UIView.transition(with: shape, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.shape.backgroundColor = self.light
                }, completion: nil)
                UIView.transition(with: directionText, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.directionText.textColor = self.dark
                }, completion: nil)
                UIView.transition(with: instructions, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.instructions.textColor = self.dark
                }, completion: nil)
                UIView.transition(with: time, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.time.textColor = self.dark
                }, completion: nil)
                
                directionText.text = actions[1]
                // Add letter spacing to inhale/exhale
                directionText.letter(spacing: 15.0)
                
                time.text = ""
            
            // If less than PAUSE_TIME then do nothing
            } else if (curTime < (MAX_TIME+1) + PAUSE_TIME) {
                
            // Otherwise reset UI and reverse breath
            } else {
                // Reset UI Colors
                UIView.transition(with: shape, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.shape.backgroundColor = self.dark
                }, completion: nil)
                UIView.transition(with: directionText, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.directionText.textColor = self.medium
                }, completion: nil)
                UIView.transition(with: instructions, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.instructions.textColor = self.medium
                }, completion: nil)
                UIView.transition(with: time, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.time.textColor = self.light
                }, completion: nil)
                
                curTime = START_TIME
                breathDirection = false
                directionText.text = actions[2]
                // Add letter spacing to inhale/exhale
                directionText.letter(spacing: 15.0)
                
                time.text = "\(curTime)"
            }
        // Exhale
        } else {
            // If starting exhale begin animation
            if (curTime == 1) {
                UILabel.animate(withDuration: TimeInterval(MAX_TIME), animations: {() -> Void in
                    self.shape?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
            
            // If less than MAX_TIME
            if (curTime <= MAX_TIME) {
                time.text = "\(curTime)"
                
            // If MAX_TIME has passed change to hold breath
            } else if (curTime == MAX_TIME+1) {
                // Reverse UI Colors
                UIView.transition(with: shape, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.shape.backgroundColor = self.light
                }, completion: nil)
                UIView.transition(with: directionText, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.directionText.textColor = self.dark
                }, completion: nil)
                UIView.transition(with: instructions, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.instructions.textColor = self.dark
                }, completion: nil)
                UIView.transition(with: time, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.time.textColor = self.dark
                }, completion: nil)
                
                directionText.text = actions[1]
                // Add letter spacing to inhale/exhale
                directionText.letter(spacing: 15.0)
                
                time.text = ""
                
            // If less than PAUSE_TIME then do nothing
            } else if (curTime < (MAX_TIME+1) + PAUSE_TIME) {
                
            // Otherwise reset UI and reverse breath
            } else {
                // Reset UI Colors and reverse breathing
                UIView.transition(with: shape, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.shape.backgroundColor = self.dark
                }, completion: nil)
                UIView.transition(with: directionText, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.directionText.textColor = self.medium
                }, completion: nil)
                UIView.transition(with: instructions, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.instructions.textColor = self.medium
                }, completion: nil)
                UIView.transition(with: time, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.time.textColor = self.light
                }, completion: nil)
                
                curTime = START_TIME
                breathDirection = true
                directionText.text = actions[0]
                // Add letter spacing to inhale/exhale
                directionText.letter(spacing: 15.0)
                
                time.text = "\(curTime)"
            }
        }
    }
}
