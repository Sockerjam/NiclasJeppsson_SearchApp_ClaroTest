//
//  ArtistBio.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 15/05/2021.
//

import Foundation

struct ArtistBio: Decodable, Hashable{
    var artist:ArtistInfo
}

struct ArtistInfo:Decodable, Hashable{
    
    var stats:Stats
    var bio:Bio
}

struct Stats:Decodable, Hashable{
    
    var listeners:String
    var playcount:String
}

struct Bio:Decodable, Hashable{
    
    var summary:String
}


