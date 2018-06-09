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
import SCLAlertView
import PopupDialog




class GameViewController: UIViewController {
    @IBOutlet weak var countL: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARk: store properties
    var count = 10
    var correctResponse = String()
    var timer: Timer!
    var textField: UITextField!
    var minutes = String()
    var seconds = String()
    var newChoice = [[String:AnyObject]]()
    var collegeNameRandomPicked = [[String]]()
    var current_score = 0
    var ac  = UIAlertController()
    //var instance = GameModel()
    var scoretosend = 0
    var userDefaults = UserDefaults.standard
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var viewLoader = UIView()

    
    //MARk: View Cycle
    override func viewDidLoad() {
//        super.viewDidLoad()
//        //if GameModel.gameShareInstance.finalData.isEmpty {
//        showIndicator()
//        }else {
//        self.hideIndicator()
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatetime), userInfo: nil, repeats: true)
//        startTimer()
//        askQuestion()
//        buttondesign()
//        }
    }
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(true)
//     // let buttonArray = [button1,button2,button3,button4]
//      buttonSize(button: buttonArray as! [UIButton])
//      UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
//
//
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARk: Indicator loading animation and view
    func showIndicator() {
//        DispatchQueue.main.async {
//            self.viewLoader.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
//            self.viewLoader.center = self.view.center
//            self.viewLoader.backgroundColor = UIColor.black
//            self.viewLoader.alpha = 0.7
//            self.viewLoader.clipsToBounds = true
//            self.viewLoader.layer.cornerRadius = 10
//            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
//            self.spinner.center = CGPoint(x:self.viewLoader.bounds.size.width / 2, y:self.viewLoader.bounds.size.height / 2)
//            self.viewLoader.addSubview(self.spinner)
//            self.view.addSubview(self.viewLoader)
//            self.spinner.startAnimating()
//        }
    }
    func hideIndicator() {
     DispatchQueue.main.async {
    self.spinner.stopAnimating()
    self.viewLoader.removeFromSuperview()
        }
    }
    
    // MARK: Button Design
    func buttonSize (button : [UIButton]){
        for item in button {
        item.titleLabel!.numberOfLines = 1
        item.titleLabel!.adjustsFontSizeToFitWidth = true
        item.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
    }
    func buttondesign(){
        self.button1.layer.borderWidth = 3
        self.button2.layer.borderWidth = 3
        self.button3.layer.borderWidth = 3
        self.button4.layer.borderWidth = 3
        self.button1.layer.borderColor = UIColor.orange.cgColor
        self.button2.layer.borderColor = UIColor.orange.cgColor
        self.button3.layer.borderColor = UIColor.orange.cgColor
        self.button4.layer.borderColor = UIColor.orange.cgColor
        self.scoreLabel.textColor = UIColor.orange
    }
    
//    // MARK: Question Algorythm
//    func askQuestion(){
//        newChoice = GameModel.gameShareInstance.finalData.choose(1)
//        print("Here is the choice\(newChoice)")
//            var question = newChoice[0]["Choices"] as! [String]
//            let randomChoice = question.shuffle()
//            let name = newChoice[0]["Name"] as! String!
//            correctResponse = newChoice[0]["correct"] as! String!
//            self.playerName.text = name
//            button1.setTitle(randomChoice[0], for: UIControlState.normal)
//            button2.setTitle(randomChoice[1], for: UIControlState.normal)
//            button3.setTitle(randomChoice[2], for: UIControlState.normal)
//            button4.setTitle(randomChoice[3], for: UIControlState.normal)
//    }
    
    // MARK: Server Post Data
    func postData(completed: @escaping DownloadCompleted) {
        let parameters : Parameters = [
            "name" : self.textField.text! as String,
            "streak" : self.scoretosend
        ]
        Alamofire.request("https://from.blubeta.com/api/PlayersNFL", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
            (response:DataResponse<Any>) in
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
    
    // MARK: Action fuction
    func submit(_ action : UIAlertAction! = nil){
        postData {
        print("Data has been sent")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "nextViewTopPlayer")
        self.present(vc, animated: true, completion: nil)
      }
    func updatetime(){
        self.countL.text = "\(timeFormatted(count))"
        if count !=  0 {
            count -= 1
        }else {
            endTimer()
            alertViewtoshow()
        }
    }
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatetime), userInfo: nil, repeats: false)
        }
    }
    func endTimer() {
        if timer != nil {
         timer.invalidate()
        }
    }
    func restartTimer(){
        count = 10
        self.countL.text = "\(timeFormatted(self.count))"
       // askQuestion()
    }
    func resetScore(completed: @escaping Completed){
    current_score = 0
    completed()
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return  String(format: "%2d", seconds)
    }
    func savehighscore(){
        var highscore = userDefaults.integer(forKey: "HighScoreData")
        if current_score > highscore {
            highscore = current_score
            userDefaults.set(highscore, forKey: "HighScoreData")
            userDefaults.synchronize()
        }
    }
    
    func checkScore()-> Bool{
        if current_score > 10 {
            self.scoretosend = current_score
            return true
        } else {
            return false
        }
    }
    
    // MARK: Alert Controller
    func alertViewtoshow(){
        userDefaults.set(current_score, forKey: "ScoreData")
        self.savehighscore()
        let checScoreStatus = self.checkScore()
            if checScoreStatus == true {
                self.ac = UIAlertController(title: self.title, message: "Game Over \nYou have achieved a score of: \(self.current_score)", preferredStyle: .alert)
                self.ac.addTextField(configurationHandler: self.configurationTextField)
                self.ac.addAction(UIAlertAction(title: "\(submitButtonTitlte)", style: .default, handler: self.submit))
                self.present(self.ac, animated: true, completion: {
                })
            }else {
                let title = "GAME OVER"
                let message = "Your score is: \(self.current_score)"
                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: false) {
                    print("Completed")
                }
                let buttonOne = DefaultButton(title: "HOME") {
                    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! LandingViewController
                    self.present(destinationVC, animated: true, completion: nil)
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
    }
    
    //MARk: alertView text configuration
    func configurationTextField(textfield: UITextField?){
        textfield?.placeholder = enterYourName
        if let unwrapped = textfield {
           textField = unwrapped
        }
    }
    
    //MARk: Button Action
    @IBAction func mainButton(_ sender: UIButton) {
        if sender.titleLabel?.text == correctResponse{
            print("Test")
            current_score += 1
            self.scoreLabel.text = "Current Streak:\(current_score)"
         //   askQuestion()
            restartTimer()
        }else {
            endTimer()
            self.alertViewtoshow()
            resetScore{
            self.scoreLabel.text = "Current Streak:0"
        }
    }
 }
 
}
