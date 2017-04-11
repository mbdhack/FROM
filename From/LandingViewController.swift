 //
//  LandingViewController.swift
//  From
//
//  Created by Mac user on 3/14/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
   
    // MARK: - OUtlet
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var guessAthleteLAbel: UILabel!
    @IBOutlet weak var latestStreak: UILabel!
    @IBOutlet weak var highestStreak: UILabel!
    @IBOutlet weak var viewHighScores: UIButton!
    @IBOutlet weak var startGame: UIButton!
    
    
    // MARK: - Properties
    var scorehigh = UserDefaults.standard
    var scorelatest = UserDefaults.standard
    var instance = GameViewController()
    var test = [Int]()
    var test2 = [Int]()
    var Score = HighScore()
    
    // MARK: - view life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
         componementAnimation()
        definesPresentationContext = true
        apIcall()
    
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        _ = isKeyPresentInUserDefaults(key:"Score")
        //showHighaLatest()
        buttonSize(button: [self.viewHighScores,self.startGame])
        self.startGame.layer.borderColor = UIColor.init(red: 253, green: 95, blue: 0, alpha: 1).cgColor
        self.startGame.layer.borderWidth = 2
        self.viewHighScores.layer.borderWidth = 0
        let attributedString = NSMutableAttributedString(string:"")
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 14.0),
                          NSForegroundColorAttributeName : UIColor.yellow,
                          NSUnderlineStyleAttributeName : 1] as [String : Any]
        let buttonTitleStr = NSMutableAttributedString(string:"View High Scores", attributes:attributes)
        attributedString.append(buttonTitleStr)
        self.viewHighScores.setAttributedTitle(attributedString, for: .normal)
       // print(result)
        showHighScore()
        showHighaLatest()
        
    }
    func acceptData(data: AnyObject!) {
       print("\(data)")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Check UserdDefault key
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    func apIcall(){
        GameModel.gameShareInstance.downloadAthlets {
        GameModel.gameShareInstance.downloadAthletsCollege {
        GameModel.gameShareInstance.questionAnswerStructure()
            }
        }
    }
    // MARK: - Animation
    func componementAnimation(){
        UIView.animate(withDuration: 3.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.fromLabel.center = CGPoint(x: 100, y: 40+200)
            self.guessAthleteLAbel.center = CGPoint(x: 100, y: 40+200)
            self.latestStreak.center = CGPoint(x: 100, y: 40+200)
            self.highestStreak.center = CGPoint(x: 100, y: 40+200)
            self.viewHighScores.center = CGPoint(x: 100, y: 40+200)
            self.guessAthleteLAbel.center = CGPoint(x: 100, y: 40+200)
            self.startGame.center = CGPoint(x: 100, y: 40+200)
        }, completion: nil)
    }
    
    // MARK: - retreive UsefDefault Data
    func showHighScore() {
        let highscore = scorehigh.integer(forKey: "HighScoreData")
        self.highestStreak.font = UIFont.boldSystemFont(ofSize: 19)
        //self.test2.append(highscore)
//        print("check high :\(self.test2)")
        self.highestStreak.text = "Highest Streak: \(highscore)"
        print("here is the highscore\(highscore)")
    
    }
    func showHighaLatest()  {
        let latestStreak = scorelatest.integer(forKey: "ScoreData")
        self.latestStreak.font = UIFont.boldSystemFont(ofSize: 19)
        self.latestStreak.text = "Latest Streak: \(latestStreak)"
        print("here is the lateststreak \(latestStreak)")
    }
    
    // MARK: - Button settings
    func buttonSize(button : [UIButton]) {
        for item in button {
            item.titleLabel!.numberOfLines = 1
            item.titleLabel!.adjustsFontSizeToFitWidth = true
            item.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
    }
    func buttondesign(button : UIButton){
        
    }
    
    // MARK: - Action

    @IBAction func startGame(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "nextView")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func viewHighScore(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "nextViewTopPlayer")
        self.present(vc, animated: true, completion: nil)
    }
    
}
