//
//  TopScoreApiCall.swift
//  From
//
//  Created by Mac user on 3/29/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import Foundation
import Alamofire

//struct Score {
//    var name : String!
//    var score: Int!
//}
//class TopPlayerAPicall {
//    let gameModelInstance = GameModel()
//    var topPlayerDict = [[String : AnyObject]]()
//    var playerName : String!
//    var highestScore: Int!
//    var topPlayerScore = [Score]()
//    func gettToppalyer(completed: @escaping DownloadCompleted){
//        Alamofire.request("https://from.blubeta.com/api/PlayersNFL").responseJSON { response in
//            let result = response.result
//            //print(result.value as? [[String:AnyObject]] as Any)
//            guard (result.value as? [[String:AnyObject]]) != nil else{return}
//            self.topPlayerDict = result.value as! [[String : AnyObject]]
//           // print(self.topPlayerDict)
////            print(self.topPlayerDict as Any)
//            completed()
//        }
//    }
//}
