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
    var instance = GameViewController()
    
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        APIcall()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func APIcall(){
        GameModel.gameShareInstance.downloadAthlets {
            GameModel.gameShareInstance.downloadAthletsCollege {
               
                GameModel.gameShareInstance.QuestionAnswerStructure()
                
            }
        }
    }
    
    func retriveData(){
        //for item in score.value(forKey: "highScore") {
        
       // }
        if let highScore = score.value(forKey: "highScore") {
           self.highestStreak.text = "\(highScore)"
        } else {
           self.latestStreak.text = "\(instance.current_score)"
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
