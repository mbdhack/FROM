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
import Alamofire


class GameViewController: UIViewController {
    @IBOutlet weak var countL: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var count = 20
    var timer = Timer()
    var current_scoreArray = [Int]()
    var texField: UITextField!
    var minutes = String()
    var seconds = String()
    var collegeNameRandomPicked = [[String]]()
    var new  = [String]()
    var current_score = 0
    var ac  = UIAlertController()
    var istance = GameModel()
    var savescore = [String]()
    var scoretosend = 0
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      buttonDesign ()
      timerUpdate(timer :timer)
      UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
      askQuestion ()
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
    
    func askQuestion(_ action : UIAlertAction! = nil){
       let newChoice = GameModel.gameShareInstance.finalData.choose(1)
        print("Here is the choice\(newChoice)")
            let question = newChoice[0]["Choices"] as! [String]
            let name = newChoice[0]["Name"] as! String!
            self.playerName.text = name
            button1.setTitle(question[0], for: UIControlState.normal)
            button2.setTitle(question[1], for: UIControlState.normal)
            button3.setTitle(question[2], for: UIControlState.normal)
            button4.setTitle(question[3], for: UIControlState.normal)
    }
    func postData(completed: @escaping DownloadCompleted) {
        let parameters : Parameters = [
            "name" : "\(self.texField.text)",
            "streak" : "\(self.scoretosend)"
        ]
        Alamofire.request("https://from.blubeta.com/api/Players", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value as Any)
                }
                break
            case .failure(_):
                print(response.result.error as Any)
                break
            }
        }
    }
    func submit(_ action : UIAlertAction! = nil){
        postData { 
         print("Sent")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "nextViewTopPlayer")
        self.present(vc, animated: true, completion: nil)
    }
    func restart(_ action : UIAlertAction! = nil){
    let newtimber = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    timerUpdate(timer:newtimber)
    askQuestion()
    }
    func timerUpdate(timer: Timer){
        if (count < 0 ){
        timer.invalidate()
        ac = UIAlertController(title: title, message: "\(scoreDisplayMessage) \(current_score).", preferredStyle: .alert)
        ac.addTextField(configurationHandler: configurationTextField)
        ac.addAction(UIAlertAction(title: "\(restartButtonTitlte)", style: .default, handler: askQuestion))
        ac.addAction(UIAlertAction(title: "\(submitButtonTitlte)", style: .default, handler: submit))
        self.present(ac, animated: true, completion: {
                print("completion block")
       })
       saveScoreLocal()
        }else{
            minutes = String(count / 60)
            seconds = String(count % 60)
            countL.text = "0\(minutes):0\(seconds)s"
            count -= 1
        }
    }
    
    func checkScore (){
        if current_score > 10 {
        self.scoretosend = current_score
        }
    }
    func saveScoreLocal(){
    UserDefaults.setValue(self.current_score, forKey: "LatestScore")
    }
    
    func configurationTextField(textfield: UITextField!){
        if (textfield) != nil {
            textfield.placeholder = enterYourName
            texField = textfield
        }
    }
    
    @IBAction func mainButton(_ sender: UIButton) {
        for item in  GameModel.gameShareInstance.dictAthletsResult{
            let keyAthlete = item["athlete"] as! String
            let valueCorrect = item["correct"] as! String
            if keyAthlete == self.playerName.text && valueCorrect == sender.titleLabel?.text{
                self.current_score += 1
                self.scoreLabel.text = "Current Streak: \(self.current_score)"
                GameModel.gameShareInstance.currentStreak =  self.current_score
                let newtimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
                timerUpdate(timer: newtimer)
                checkScore ()
                askQuestion()
            }else{
            print("no")
            }
            
        }
    }
}
