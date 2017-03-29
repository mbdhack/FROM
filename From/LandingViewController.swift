//
//  LandingViewController.swift
//  From
//
//  Created by Mac user on 3/14/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var guessAthleteLAbel: UILabel!
    @IBOutlet weak var latestStreak: UILabel!
    @IBOutlet weak var highestStreak: UILabel!
    @IBOutlet weak var viewHighScores: UIButton!
  
 
    @IBOutlet weak var startGame: UIButton!
    
    let score = UserDefaults.standard
    var instance = GameViewController()
    
    
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        apIcall()
        let result = isKeyPresentInUserDefaults(key:"HighScore")
        print(result)
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
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    override func viewDidAppear(_ animated: Bool) {
        SortedScore{}
    }
    func apIcall(){
        GameModel.gameShareInstance.downloadAthlets {
        GameModel.gameShareInstance.downloadAthletsCollege {
        GameModel.gameShareInstance.QuestionAnswerStructure()
            }
        }
    }
    func SortedScore (completed: @escaping DownloadCompleted){
        if let highscore = score.object(forKey: "HighScore") as? Int{
            self.highestStreak.font = UIFont.boldSystemFont(ofSize: 19)
            self.highestStreak.text = "Highest Streak: 18"
            print("\(highscore)")
        }
        if let latestStreak  = score.object(forKey: "Score") as? Int{
            self.latestStreak.font = UIFont.boldSystemFont(ofSize: 19)
            self.latestStreak.text = "Latest Streak: \(latestStreak)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
