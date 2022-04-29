//
//  MovieResponseModel.swift
//  Apsiyon
//
//  Created by MERT on 28.04.2022.
//
import Foundation
import ObjectMapper

class MovieResponseModel: Mappable {
    
    public var page: Int = 0
    public var results: [MovieModel] = [MovieModel]()
    
    required init?(map: Map) {
        if map.JSON["results"] == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
    }
    
    
    
}
