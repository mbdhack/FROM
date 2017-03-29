//
//  LoadViewController.swift
//  From
//
//  Created by Mac user on 3/21/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var playername = String()
    var score = [Int]()
    var name = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print(GameModel.gameShareInstance.topPlayerScore)
        tableView.tableFooterView = UIView()
        self.navigationController?.isNavigationBarHidden = false
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
         GameModel.gameShareInstance.gettToppalyer{
            self.fecthData()
           // self.tableView.reloadData()
        }
    }
    func fecthData(){
        for item in GameModel.gameShareInstance.topPlayerScore{
          self.name.append(item.name)
          self.score.append(item.score)
          tableView.reloadData()
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell  = tableView.dequeueReusableCell(withIdentifier:topScoreCellIdentifier) as! ScoreTableViewCell
        cell.idLAbel.text = "\(indexPath.row+1)"
        cell.playerName.text = self.name[indexPath.row]
        cell.score.text = String(self.score[indexPath.row])
        return cell
    }

    @IBAction func Back(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "nextView")
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
