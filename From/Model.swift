////
////  Model.swift
////  From
////
////  Created by Mac user on 3/16/17.
////  Copyright © 2017 Mac user. All rights reserved.
////
//
import Foundation
//import Alamofire
//
////public class URLEndpoint{
////    let baseUrl = "https://from.blubeta.com/api"
////    let atheletsEndpoint = "/AthletesNFL"
////    let atheletsCollegeEndpoint = "/AthletesNFL/colleges"
////    let topPlayerEndPoint = "/PlayersNFL"
////    let postEndpoint = "/PlayersNFL"
////
////    }
public class GameModel {
//    var collegeName: String!
//    var dictAthletsResult = [[String:AnyObject]]()
      var collegeNameArray = [AnyObject]()
//    var reducedCollege = [String]()
//    var athletesCorrect = [String:String]()
    var finalData = [[String:AnyObject]]()
    var quizData = [String:AnyObject]()
//    var topPlayerDict = [[String:AnyObject]]()
//    var keyCorrectAthlete = String ()
//    var keyCorrectCollege = String()
    var data  = [PLayersModel]()
    static var gameShareInstance = GameModel()
//    var gamemodel = [[String:]]
//    override init() {
//      collegeName = ""
//      }
    }
extension GameModel{
//    func apiCallUrl (baseUrl:String,endPoint:String)-> String{
//        return ("\(baseUrl)\(endPoint)")
//    }
//    func downloadAthlets(completed: @escaping DownloadCompleted){
//            Alamofire.request(apiCallUrl(baseUrl:baseUrl,endPoint:atheletsEndpoint)).responseJSON { response in
//            let result = response.result
//            guard result.value as? [[String:AnyObject]] != nil else{return}
//                self.dictAthletsResult = result.value as! [[String : AnyObject]]
//            completed()
//        }
//    }
//    func downloadAthletsCollege(completed: @escaping DownloadCompleted){
//        Alamofire.request(apiCallUrl(baseUrl:baseUrl,endPoint:atheletsCollegeEndpoint)).responseJSON { response in
//            let result = response.result
//            guard result.value as? [String] != nil else{return}
//            self.collegeNameArray = result.value as! [String]
//            self.reducedCollege = self.collegeNameArray.choose(400)
//            completed()
//        }
//    }
    func getCollegeName(){
        self.data = ResponseServiceMock.mockPlayer()!
        for item in data {
         self.collegeNameArray.append(item.college as AnyObject)
        }
    }
    func questionAnswerStructure (){
        for item in data {
            self.quizData["Name"] = item.full_name as AnyObject
            self.quizData["correct"] = item.college as AnyObject
            self.quizData["Choices"] = self.collegeNameArray.choose(4) as AnyObject
            self.finalData.append(quizData)
        }
//        let number = self.dictAthletsResult.choose(400)
//        for item in number {
//            var randomArray = self.reducedCollege.choose(3)
//            keyCorrectAthlete = item[athleteKeyString] as! String
//            keyCorrectCollege = item[correctKeyString] as! String
//            randomArray.append(keyCorrectCollege as String)
//            self.quizData["Name"] = keyCorrectAthlete as AnyObject
//            self.quizData["Choices"] = randomArray as AnyObject
//            self.quizData["correct"] = keyCorrectCollege as AnyObject
//
//            }
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
           self.swapAt($0, index)
        }
        return self
    }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}
