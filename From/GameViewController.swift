//
//  GameViewController.swift
//  From
//
//  Created by Mac user on 3/15/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {
    @IBOutlet weak var countL: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var count = 10
    var timer = Timer()
    var current_score = 0
    var texField: UITextField!
    var minutes = String()
    var seconds = String()
    var testKey = String()
    var collegeNameRandomPicked = [[String]]()
    var new  = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
         buttonDesign ()
       
        askQuestion ()
    }
    override func viewDidAppear(_ animated: Bool) {
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func buttonDesign () {
        button1.layer.borderWidth = 3
        button2.layer.borderWidth = 3
        button3.layer.borderWidth = 3
        button4.layer.borderWidth = 3
    }
    
    func askQuestion(){
       let newChoice = GameModel.gameShareInstance.testNew.choose(1)
        print(newChoice)
        for item in newChoice {
            let question = item["Choices"] as! [String]
            let name = item["Name"] as! String!
            self.playerName.text = name
            button1.setTitle(question[0], for: UIControlState.normal)
            button2.setTitle(question[1], for: UIControlState.normal)
            button3.setTitle(question[2], for: UIControlState.normal)
            button4.setTitle(question[3], for: UIControlState.normal)

            
        }
        
        }
    func timerUpdate(){
        if (count < 0 ){
            timer.invalidate()
//            let ac = UIAlertController(title: title, message: "Game Over \nYour score is \(current_score).", preferredStyle: .alert)
//            ac.addTextField(configurationHandler: configurationTextField)
//            ac.addAction(UIAlertAction(title: "Submit", style: .default, handler:{ (UIAlertAction) in
//                print("Name : \(self.texField.text)")
//            }))
//            self.present(ac, animated: true, completion: {
//                print("completion block")
//            })
        }else{
            minutes = String(count / 60)
            seconds = String(count % 60)
            countL.text = minutes + ":" + seconds
            count -= 1
        }
    }
    func configurationTextField(textfield: UITextField!){
        textfield.placeholder = "Enter Your Name"
        texField = textfield
    }
    
    @IBAction func mainButton(_ sender: UIButton) {
            for item in  GameModel.gameShareInstance.dictAthletsResult{
            let keyAthlete = item["athlete"] as! String
            let valueCorrect = item["correct"] as! String
            if keyAthlete == self.playerName.text && valueCorrect == sender.titleLabel?.text{
            self.current_score += 1
            self.scoreLabel.text = "Current Streak: \(self.current_score)"
            GameModel.gameShareInstance.currentStreak =  self.current_score
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
            timerUpdate()
            askQuestion()
            }
               
//            else {
//                let ac = UIAlertController(title: title, message: "Game Over \nYour score is \(current_score).", preferredStyle: .alert)
//                ac.addTextField(configurationHandler: configurationTextField)
//                ac.addAction(UIAlertAction(title: "Submit", style: .default, handler:{ (UIAlertAction) in
//                    print("Name : \(self.texField.text)")
//                }))
//                self.present(ac, animated: true, completion: {
//                    print("Name : \(self.texField.text) sent")
//                })
//                }
               }
        askQuestion()
            }
        }

