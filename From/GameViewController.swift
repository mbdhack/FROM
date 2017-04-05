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
    
    var count = 10
    var hightScore = 0
    var testresult  = String()
    var timer: Timer!
    var current_scoreArray = [Int]()
    var textField: UITextField!
    var minutes = String()
    var seconds = String()
    var newChoice = [[String:AnyObject]]()
    var collegeNameRandomPicked = [[String]]()
    var new  = [String]()
    var current_score = 0
    var ac  = UIAlertController()
    var istance = GameModel()
    var scoretosend = 0
    let userDefaults = UserDefaults.standard
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var viewLoader = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if GameModel.gameShareInstance.finalData.isEmpty {
        showIndicator()
        }else {
        self.hideIndicator()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetime), userInfo: nil, repeats: true)
        startTimer()
        askQuestion()
        self.button1.layer.borderWidth = 1
        self.button2.layer.borderWidth = 1
        self.button3.layer.borderWidth = 1
        self.button4.layer.borderWidth = 1
        self.button1.layer.borderColor = UIColor.init(red: 253, green: 95, blue: 0, alpha: 1).cgColor
        self.button2.layer.borderColor = UIColor.init(red: 253, green: 95, blue: 0, alpha: 1).cgColor
        self.button3.layer.borderColor = UIColor.init(red: 253, green: 95, blue: 0, alpha: 1).cgColor
        self.button4.layer.borderColor = UIColor.init(red: 253, green: 95, blue: 0, alpha: 1).cgColor
        }
    }
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
      let buttonArray = [button1,button2,button3,button4]
      buttonSize(button: buttonArray as! [UIButton])
      UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showIndicator() {
        DispatchQueue.main.async {
            self.viewLoader.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
            self.viewLoader.center = self.view.center
            self.viewLoader.backgroundColor = UIColor.black
            self.viewLoader.alpha = 0.7
            self.viewLoader.clipsToBounds = true
            self.viewLoader.layer.cornerRadius = 10
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.viewLoader.bounds.size.width / 2, y:self.viewLoader.bounds.size.height / 2)
            self.viewLoader.addSubview(self.spinner)
            self.view.addSubview(self.viewLoader)
            self.spinner.startAnimating()
        }
    }
    func hideIndicator() {
     DispatchQueue.main.async {
    self.spinner.stopAnimating()
    self.viewLoader.removeFromSuperview()
        }
    }
    
    func buttonSize (button : [UIButton]){
        for item in button {
        item.titleLabel!.numberOfLines = 1
        item.titleLabel!.adjustsFontSizeToFitWidth = true
        item.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
    }
    func askQuestion(){
        newChoice = GameModel.gameShareInstance.finalData.choose(1)
        print("Here is the choice\(newChoice)")
            var question = newChoice[0]["Choices"] as! [String]
            let randomChoice = question.shuffle()
            let name = newChoice[0]["Name"] as! String!
            testresult = newChoice[0]["correct"] as! String!
            self.playerName.text = name
            button1.setTitle(randomChoice[0], for: UIControlState.normal)
            button2.setTitle(randomChoice[1], for: UIControlState.normal)
            button3.setTitle(randomChoice[2], for: UIControlState.normal)
            button4.setTitle(randomChoice[3], for: UIControlState.normal)
    }
    func postData(completed: @escaping DownloadCompleted) {
        let parameters : Parameters = [
            "name" : self.textField.text! as String,
            "streak" : self.scoretosend
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
    func submit(_ action : UIAlertAction! = nil){
        postData {
        print("Data has been sent")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "nextViewTopPlayer")
        self.present(vc, animated: true, completion: nil)
      }
    func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatetime), userInfo: nil, repeats: true)
    }
    func endTimer() {
    timer.invalidate()
    }
    func restartTimer(){
         endTimer()
         count = 10
         self.countL.text = "\(timeFormatted(self.count))"
         askQuestion()
    }
    func resetScore(completed: @escaping DownloadCompleted){
    current_score = 0
    completed()
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return  String(format: "%2d", seconds)
    }
    func home(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        self.present(vc, animated: true, completion: nil)

    }
    func alertViewtoshow(){
        let checScoreStatus = self.checkScore(completed: {
            print("Score Has been Checked")
        })
        if checScoreStatus == true {
            self.savedata()
            self.ac = UIAlertController(title: self.title, message: "\(scoreDisplayMessage) \(self.current_score)", preferredStyle: .alert)
            self.ac.addTextField(configurationHandler: self.configurationTextField)
            self.ac.addAction(UIAlertAction(title: "😃\(submitButtonTitlte)", style: .default, handler: self.submit))
            self.present(self.ac, animated: true, completion: {
                print("completion block")
            })
        }else {
            self.savedata()
            self.ac = UIAlertController(title: self.title, message: "\(scoreDisplayMessage) \(self.current_score)", preferredStyle: .alert)
            self.ac.view.layer.cornerRadius = 1
            self.ac.addAction(UIAlertAction(title:"☹️\(restartButtonTitlte)", style: .default, handler: { action in
                self.restartTimer()
            }
            ))
            self.ac.addAction(UIAlertAction(title:"Home", style: .default, handler: { action in
                self.home()
            }))

           self.present(self.ac, animated: true, completion: {
            print("completion block")
           })
        }

    }
    func savedata(){
      if let highscore = userDefaults.object(forKey: "Score") as? Int{
        print("here:\(highscore)")
        if current_score > highscore {
        userDefaults.set(current_score, forKey: "HighScore")
        userDefaults.synchronize()
        }else {
        }
    }
      userDefaults.set(current_score, forKey: "Score")
      userDefaults.synchronize()
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
        completed()
        return false
        }
    }
    func configurationTextField(textfield: UITextField?){
        textfield?.placeholder = enterYourName
        if let unwrapped = textfield {
           textField = unwrapped
        }
    }
    
    @IBAction func mainButton(_ sender: UIButton) {
        if sender.titleLabel?.text == testresult{
            print("Test")
            current_score += 1
            self.scoreLabel.text = "Current Streak:\(current_score)"
            askQuestion()
            restartTimer()
        }else {
        timer.invalidate()
        alertViewtoshow()
        resetScore{
        self.scoreLabel.text = "Current Streak:0"
        }
    }
 }
 
}
