//
//  Model.swift
//  From
//
//  Created by Mac user on 3/16/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import Foundation
import Alamofire

public class URLEndpoint{
    let baseUrl = "https://from.blubeta.com/api"
    let atheletsEndpoint = "/Athletes"
    let atheletsCollegeEndpoint = "/Athletes/colleges"
    let topPlayerEndPoint = "/Players/top20"
    let postEndpoint = "/Players"

    }
public class GameModel:URLEndpoint {
    var CollegeName: String!
    var dictAthletsResult = [[String:AnyObject]]()
    var collegeNameArray = [String]()
    var athletesCorrect = [String:String]()
    var finalData = [[String:AnyObject]]()
    var quizData = [String:AnyObject]()
    var topPlayerDict = [[String:AnyObject]]()
    var keyCorrectAthlete = String ()
    var keyCorrectCollege = String()
    static var gameShareInstance = GameModel()
    override init() {
      CollegeName = ""
      }
    }
extension GameModel{
    func apiCallUrl (baseUrl:String,endPoint:String)-> String{
        return ("\(baseUrl)\(endPoint)")
    }
    func downloadAthlets(completed: @escaping DownloadCompleted){
            Alamofire.request(apiCallUrl(baseUrl:baseUrl,endPoint:atheletsEndpoint)).responseJSON { response in
            let result = response.result
            guard result.value as? [[String:AnyObject]] != nil else{return}
                self.dictAthletsResult = result.value as! [[String : AnyObject]]
            completed()
        }
    }
    func downloadAthletsCollege(completed: @escaping DownloadCompleted){
        Alamofire.request(apiCallUrl(baseUrl:baseUrl,endPoint:atheletsCollegeEndpoint)).responseJSON { response in
            let result = response.result
            guard result.value as? [String] != nil else{return}
            self.collegeNameArray = result.value as! [String]
            completed()
        }
    }
    func questionAnswerStructure (){
        for item in dictAthletsResult{
            var randomArray = self.collegeNameArray.choose(3)
            keyCorrectAthlete = item[athleteKeyString] as! String
            keyCorrectCollege = item[correctKeyString] as! String
            randomArray.append(keyCorrectCollege as String)
            self.quizData["Name"] = keyCorrectAthlete as AnyObject
            self.quizData["Choices"] = randomArray as AnyObject
            self.quizData["correct"] = keyCorrectCollege as AnyObject
            print( keyCorrectAthlete,keyCorrectCollege)
            self.finalData.append(quizData)
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

