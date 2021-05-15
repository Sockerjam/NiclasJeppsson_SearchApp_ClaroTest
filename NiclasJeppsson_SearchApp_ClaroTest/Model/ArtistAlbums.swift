//
//  ArtistAlbums.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation

struct ArtistAlbums:Decodable, Hashable{
    
    var topAlbums:TopAlbums
    
    enum CodingKeys:String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct TopAlbums:Decodable, Hashable{
    var album:[Album]
}

struct Album:Decodable, Hashable{
    var name:String
    var image:[AlbumImage]
}

struct AlbumImage:Decodable, Hashable{

    var imageUrl:String
    var imageSize:String

    enum CodingKeys:String,CodingKey {
        case imageUrl = "#text"
        case imageSize = "size"
    }

}
