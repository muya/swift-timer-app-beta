//
//  ViewController.swift
//  swiftTimerAppBeta
//
//  Created by Muya on 17/08/2014.
//  Copyright (c) 2014 muya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    var timer = NSTimer()
    var times = [String]()
    var pausedTime:NSDate!
    // will keep track of whether the timer had been paused
    var wasPaused = false
    var elapsed = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // round the corners of the buttons
        self.startButton.layer.cornerRadius = 5.0
        self.stopButton.layer.cornerRadius = 5.0
        self.resetButton.layer.cornerRadius = 5.0
        
        // set default timeLabel value
        resetTimeLabel()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "transparentNavBar"), forBarMetrics: UIBarMetrics.Default)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressStartButton(sender: AnyObject) {
        if (wasPaused == true){
            println("will try resume...")
            // resume from previous time
            self.timer = NSTimer(fireDate: NSDate().dateByAddingTimeInterval(1.0), interval: 1.0, target: self, selector: "updateTimeLabel", userInfo: pausedTime, repeats: true)
            var runLoop = NSRunLoop.currentRunLoop()
            runLoop.addTimer(self.timer, forMode: NSRunLoopCommonModes)
            updateTimeLabel()
            wasPaused = false
        }
        else{
            println("will start from scratch")
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimeLabel", userInfo: NSDate(), repeats: true)
        }
        self.startButton.hidden = true
        self.stopButton.hidden = false
    }
    
    @IBAction func didPressStopButton(sender: AnyObject) {
        // reset buttons
        stopButton.hidden = true
        startButton.hidden = false
        
        // save the paused time
        if timer.valid{
            println("timer is valid, will save time and set was paused to true")
            pausedTime = timer.userInfo as NSDate
            wasPaused = true
        }
        timer.invalidate()
    }
    
    @IBAction func didPressResetButton(sender: AnyObject) {
        timer.invalidate()
        resetTimeLabel()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        var capturedTime = self.timeLabel.text
        times.append(capturedTime!)
        let destinationViewController = segue.destinationViewController as SavedTimesTableViewController
        destinationViewController.savedTimes = times
    }
    
    func savePausedTime(timeToSave: NSDate){
        
    }
    
    func updateTimeLabel(){
        elapsed++
//        var elapsed = -(self.timer.userInfo as NSDate).timeIntervalSinceNow
        if elapsed < 60 {
            timeLabel.text = String(format: "00:00:%02.0f", elapsed)
        }
        else if elapsed < 3600 {
            timeLabel.text = String(format: "00:%02.0f:%02.0f", elapsed / 60, elapsed % 60)
        }
        else{
            timeLabel.text = String(format: "%02.0f:%02.0f:%02.0f", elapsed / 3600, elapsed % 60, elapsed % 60)
        }
    }
    
    func resetTimeLabel(){
        elapsed = 0
        timeLabel.text = String(format: "00:00:%02.0f", elapsed)
    }
    
    /*
    function to return the name of a programming language
    */
    func getRandomProgrammingLanguage() -> String{
        let programmingLanguages = ["Perl", "PHP", "Swift", "Pyhon", "Java", "Ruby"]
        var randomPLIndex = Int(arc4random_uniform(UInt32(programmingLanguages.count)))
        var randomPL = programmingLanguages[randomPLIndex]
        return randomPL
    }

}

