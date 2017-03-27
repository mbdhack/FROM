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
    
    var count = 5
    var timer: Timer!
    var current_scoreArray = [Int]()
    var textField: UITextField!
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetime), userInfo: nil, repeats: true)
    }
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      buttonDesign ()
        startTimer()
      //timerUpdate(timer :timer)
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
            var question = newChoice[0]["Choices"] as! [String]
            let randomChoice = question.shuffle()
            let name = newChoice[0]["Name"] as! String!
            self.playerName.text = name
            button1.setTitle(randomChoice[0], for: UIControlState.normal)
            button2.setTitle(randomChoice[1], for: UIControlState.normal)
            button3.setTitle(randomChoice[2], for: UIControlState.normal)
            button4.setTitle(randomChoice[3], for: UIControlState.normal)
    }
    func postData(completed: @escaping DownloadCompleted) {
        let parameters : Parameters = [
            "name" : "\(self.textField!.text)",
            "streak" : "\(self.current_score)"
        ]
        Alamofire.request("https://from.blubeta.com/api/Players", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print("\(response.result.value as Any) sent Here")
                }
                break
            case .failure(_):
                print("\(response.result.error as Any) not sent")
                break
            }
        }
    }
    func saveScore(){
     userDefaults.set(current_score, forKey: "Score")
     userDefaults.synchronize()
    }
    func submit(_ action : UIAlertAction! = nil){
        postData {
        self.saveScore()
        print("Data has been sent")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "nextViewTopPlayer")
        self.present(vc, animated: true, completion: nil)
      }
    func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatetime), userInfo: nil, repeats: true)
    }
    func endTimer(_ action : UIAlertAction! = nil) {
    timer.invalidate()
    }
    func restartTimer(){
         endTimer()
         count = 10
         self.countL.text = "\(timeFormatted(count))"
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return  String(format: "%02d:%02d", minutes, seconds)
    }
    func alertViewtoshow(){
        let checScoreStatus = self.checkScore(completed: {
            print("Score Has been Checked")
        })
        self.ac = UIAlertController(title: self.title, message: "\(scoreDisplayMessage) \(self.current_score)", preferredStyle: .alert)
        if checScoreStatus == true {
            self.ac.addTextField(configurationHandler: self.configurationTextField)
            self.ac.addAction(UIAlertAction(title: "\(submitButtonTitlte)", style: .default, handler: self.submit))
            self.present(self.ac, animated: true, completion: {
                print("completion block")
            })
        }else {
            self.ac.addAction(UIAlertAction(title:"\(restartButtonTitlte) again", style: .default, handler: { action in
                self.restartTimer()
            }))

           self.present(self.ac, animated: true, completion: {
            print("completion block")
           })
        }

    }
    func updatetime(){
    self.countL.text = "\(timeFormatted(count))"
        if count !=  0 {
            count -= 1
        }else {
            timer.invalidate()
            alertViewtoshow()
        }
    }
    func checkScore(completed: @escaping DownloadCompleted)-> Bool{
        if current_score > 10 {
        self.scoretosend = current_score
        completed()
        return true
        } else {
        self.scoretosend = current_score
        completed()
        return false
        }
    }
    func configurationTextField(textfield: UITextField!){
        textfield.placeholder = enterYourName
        if let unwrapped = textfield {
           textField = unwrapped
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
                startTimer()
                self.askQuestion()
                
            }else{
            print("no")
            }
            
        }
    }
}
