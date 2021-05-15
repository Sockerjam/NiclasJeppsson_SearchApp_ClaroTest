//
//  ArtistModel.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation


struct ArtistModel:Decodable, Hashable{
    
    var results:Results
}

struct Results:Decodable, Hashable{
    var artistmatches:ArtistMatches
}

struct ArtistMatches:Decodable, Hashable{
    
    var artist:[Artist]
}

struct Artist:Decodable, Hashable{
    
    var name:String
    var image:[Image]
}

struct Image:Decodable, Hashable{
    
    var imageUrl:String
    var imageSize:String
    
    enum CodingKeys:String, CodingKey {
        case imageUrl = "#text"
        case imageSize = "size"
    }
}
