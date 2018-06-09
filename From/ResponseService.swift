//
//  ResponseService.swift
//  From
//
//  Created by davy ngoma mbaku on 6/2/18.
//  Copyright © 2018 Mac user. All rights reserved.
//

import Foundation

class ResponseServiceMock {

class func mockPlayer() ->[PLayersModel]? {
    var result = [PLayersModel]()
    guard let path = Bundle.main.path(forResource: "Data", ofType: "json") else {
        return result
    }
    let url = URL(fileURLWithPath: path)
    do {
        let data = try Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let rm = try jsonDecoder.decode([PLayersModel].self, from: data)
        result = rm
        return result
    } catch {
        print(error)
        return result
    }
 }
}
