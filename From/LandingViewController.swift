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
    @IBOutlet weak var guessBySport: UILabel!
    @IBOutlet weak var nflButon: UIButton!
    @IBOutlet weak var nbaButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var startGame: UIButton!
    
    let score = UserDefaults.standard
    var scoreData = [String:AnyObject]()
    var sortedscore = [Int]()
    var instance = GameViewController()
    
    
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        apIcall()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        retriveData {
        self.score.set(0, forKey: "Score")
        self.assigtoLabel()
        }
    }
    func apIcall(){
        GameModel.gameShareInstance.downloadAthlets {
        GameModel.gameShareInstance.downloadAthletsCollege {
        GameModel.gameShareInstance.QuestionAnswerStructure()
            }
        }
    }
    func SortedScore (completed: @escaping DownloadCompleted){
        if let score = (UserDefaults.standard.dictionary(forKey: "Score")){
            for score in score {
                let score = score
                self.scoreData["score"] = score as AnyObject?
            }
        }
    }
    func retriveData(completed: @escaping DownloadCompleted){
    SortedScore {
        for (_,value) in self.scoreData {
         self.sortedscore.append(value as! Int)
        }
    }
  }
  func assigtoLabel() {
     self.highestStreak.text = "Highest Streak:\(self.sortedscore.max())"
     self.latestStreak.text = "Latest Streak:\(self.sortedscore.min())"
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
