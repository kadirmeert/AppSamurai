//
//  MovieModel.swift
//  Apsiyon
//
//  Created by MERT on 28.04.2022.
//

import Foundation
import ObjectMapper

class MovieModel: Mappable {

    public var title: String = ""
    public var backdropPath: String = ""
    public var voteAverage: Double?
    public var release_date: String = ""
    public var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }


    required init?(map: Map) {
        if map.JSON["title"] == nil {
            return nil
        }
    }

    func mapping(map: Map) {
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        voteAverage <- map["vote_average"]
        release_date <- map["release_date"]
        
    }
}
