//
//  LoadViewController.swift
//  From
//
//  Created by Mac user on 3/21/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import UIKit
import Alamofire

class LoadViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    // MARK: - OUtlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var score = [Int]()
    var name = [String]()
    var playername = String()
    var playerscore = String()
    var instance = TopPlayerAPicall()
    var color = [String]()
    
    // MARK: - view life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.navigationController?.isNavigationBarHidden = false
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        color = ["282C35","313540"]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        instance.gettToppalyer{
        self.fecthData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Fech data from Top Score Endpoint
    func fecthData(){
        for item in instance.topPlayerDict{
            print(item)
          self.name.append(item["name"] as! String)
          self.score.append(item["streak"] as! Int)
          tableView.reloadData()
        }
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
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let randomColor = Int(arc4random_uniform(UInt32(self.color.count)))
//        cell.contentView.backgroundColor = UIColor(
//    }
    
    
     // MARK: - Action

    @IBAction func Back(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        self.present(vc, animated: true, completion: nil)
        }

    }
