//
//  ViewController.swift
//  BullEye
//
//  Created by ernie on 22/9/2016.
//  Copyright © 2016 ernie. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var currentValue : Int = 0
    var targetValue : Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var targetLabel :UILabel!
    @IBOutlet weak var scoreLabel :UILabel!
    @IBOutlet weak var roundLabel :UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.startNewRound()
        self.updateLabels()
        
        
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        
        //adding resizableImage for the slider left part and right part
        let insets = UIEdgeInsets(top: 0,left: 14, bottom: 0,right: 14)
        
        
    
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
            
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
            
        }
        
        
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showAlert(){
        
        let different = abs(currentValue - targetValue)
        let basicPoints = 100 - different
        let rank = self.judge(basicPoints).level
        let extraPoints = self.judge(basicPoints).extraPoints
        let finalPoints = basicPoints + extraPoints
        score += finalPoints
        
        let message = "ball stops at \(currentValue) " + "\n aim is \(targetValue)" + "\n your final score is \(finalPoints)"
        
        let alert = UIAlertController(title: rank ,message: message,preferredStyle: .ActionSheet)
        
        let action = UIAlertAction(title: "ok",style: .Default,handler:
            {action in
                self.startNewRound()
                self.updateLabels()
            })
        
        //the 3rd parameter handler means :tell the alert what should happen when the button is pressed
        alert.addAction(action)
        
        presentViewController(alert,animated: true,completion: nil)
        
    }
    
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOverButtonTapped(){
    
        self.round = 0
        self.score = 0
        startNewRound()
        updateLabels()
        
        
        
        //adding crossFade animation to the whole thing 
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
        
        
    
    }
    
    
    
    
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    
    
    
    //the example function that takes 1 argument and return 2
    private func judge(points : Int) -> ( level: String ,extraPoints: Int){
        var level : String = ""
        var extraPoints : Int = 0
        if points >= 90 {
            level = "Perfect!"
            extraPoints = 100
        }else if(points < 90 && points >= 60){
            level = "You almost had it!"
            extraPoints =  0
        }else if(points < 60){
            level = "Not even close..."
            extraPoints =  -50
        }
        return (level ,extraPoints)
    }
    
    
    
    
}

