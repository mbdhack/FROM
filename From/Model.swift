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

public class GameModel {
    var playerName : String!
    var currentStreak: Int!
    var CollegeName: String!
    var UserName : String!
    var topPlayer : String!
    var dictAthletsResult = [[String:AnyObject]]()
    var collegeNAme = [AnyObject]()
    var athletesCorrect = [String:String]()
    var testNew = [[String:AnyObject]]()
    var new001 = [String:AnyObject]()
    static var gameShareInstance = GameModel()
    let baseUrl = "https://from.blubeta.com/api"
    let atheletsEndpoint = "/Athletes"
    let atheletsCollegeEndpoint = "/Athletes/colleges"
    init() {
      playerName = ""
      currentStreak = 0
      UserName = ""
      topPlayer = ""
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
            self.collegeNAme = (result.value)! as! [String] as [AnyObject]
            completed()
        }
    }
    func testIdea (){
        for item in dictAthletsResult{
            var arrayThreeNumber = self.collegeNAme.choose(3)
            let keyAthlete = item["athlete"] as! String
            let valueCorrect = item["correct"] as! String
            print( keyAthlete,valueCorrect)
            self.athletesCorrect[keyAthlete] = valueCorrect
            self.new001["Name"] = keyAthlete as AnyObject?
            arrayThreeNumber.append(valueCorrect as AnyObject)
            self.new001["Choices"] = arrayThreeNumber as AnyObject?
            self.testNew.append(new001)
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

