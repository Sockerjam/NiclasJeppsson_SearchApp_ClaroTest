//
//  ArtistModel.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation


struct ArtistModel:Decodable{
    
    var results:Results
}

struct Results:Decodable{
    var artistmatches:ArtistMatches
}

struct ArtistMatches:Decodable{
    
    var artist:[Artist]
}

struct Artist:Decodable{
    
    var name:String
    var image:[Image]
}

struct Image:Decodable{
    
    var imageUrl:String
    var imageSize:String
    
    enum CodingKeys:String, CodingKey {
        case imageUrl = "#text"
        case imageSize = "size"
    }
}
