//
//  Model.swift
//  From
//
//  Created by Mac user on 3/16/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import Foundation
import Alamofire
import GameplayKit
import UIKit

struct Score {
    var name : String!
    var score: Int!
}

public class URLEndpoint{
    let baseUrl = "https://from.blubeta.com/api"
    let atheletsEndpoint = "/Athletes"
    let atheletsCollegeEndpoint = "/Athletes/colleges"
    let topPlayerEndPoint = "/Players/top20"
    let postEndpoint = "/Players"

}
public class GameModel:URLEndpoint {
    var playerName : String!
    var CollegeName: String!
    var highestScore : Int!
    var currentStreak: Int
    var userSocre = [Int]()
    var dictAthletsResult = [[String:AnyObject]]()
    var collegeNameArray = [AnyObject]()
    var athletesCorrect = [String:String]()
    var finalData = [[String:AnyObject]]()
    var dictFinalData = [String:AnyObject]()
    var topPlayerDict = [[String:AnyObject]]()
    var keyCorrectAthlete = String ()
    var keyCorrectCollege = String()
    var topPlayerScore = [Score]()
    static var gameShareInstance = GameModel()
    override init() {
      playerName = ""
      currentStreak = 0
      highestScore = 0
      CollegeName = ""
      }
}
extension GameModel{
    func apiCallUrl (baseurl baseUrl : String , endpoint endPoint : String)-> String{
        return ("\(baseUrl)\(endPoint)")
    }
    func downloadAthlets(completed: @escaping DownloadCompleted){
            Alamofire.request(apiCallUrl(baseurl: baseUrl, endpoint: atheletsEndpoint)).responseJSON { response in
            let result = response.result
            guard (result.value as? [[String:AnyObject]]) != nil else{return}
             self.dictAthletsResult = (result.value)! as! [[String:AnyObject]]
            completed()
        }
    }
    func downloadAthletsCollege(completed: @escaping DownloadCompleted){
        Alamofire.request(apiCallUrl(baseurl: baseUrl, endpoint: atheletsCollegeEndpoint)).responseJSON { response in
            let result = response.result
            guard (result.value as? [String]) != nil else{return}
            self.collegeNameArray = (result.value)! as! [String] as [AnyObject]
            completed()
        }
    }
    func QuestionAnswerStructure (){
        for item in dictAthletsResult{
            var arrayThreeNumber = self.collegeNameArray.choose(3)
            keyCorrectAthlete = item[athleteKeyString] as! String
            keyCorrectCollege = item[correctKeyString] as! String
            print( keyCorrectAthlete,keyCorrectCollege)
            self.dictFinalData["Name"] = keyCorrectAthlete as AnyObject?
            arrayThreeNumber.append(keyCorrectCollege as AnyObject)
            self.dictFinalData["Choices"] = arrayThreeNumber as AnyObject?
            self.finalData.append(dictFinalData)
        }
    }
    func gettToppalyer(completed: @escaping DownloadCompleted){
        Alamofire.request(apiCallUrl(baseurl: baseUrl, endpoint: topPlayerEndPoint)).responseJSON { response in
            let result = response.result
            guard (result.value as? [[String:AnyObject]]) != nil else{return}
            self.topPlayerDict = (result.value)! as! [[String : AnyObject]]
            print(self.topPlayerDict)
            for item in self.topPlayerDict {
            self.playerName = item["name"] as! String
            self.highestScore = item[streakKeyString] as! Int
            self.topPlayerScore.append(Score(name:self.playerName  , score:self.highestScore))
                //print(self.topPlayerScore)
            }
           
            completed()
        }
    }
}
extension Array {
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    @discardableResult
    mutating func shuffle() -> Array {
        indices.dropLast().forEach {
            guard case let index = Int(arc4random_uniform(UInt32(count - $0))) + $0, index != $0 else { return }
            swap(&self[$0], &self[index])
        }
        return self
    }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}

