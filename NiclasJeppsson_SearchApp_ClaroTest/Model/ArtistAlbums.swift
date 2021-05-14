//
//  ArtistAlbums.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation

struct ArtistAlbums:Decodable{
    
    var topAlbums:TopAlbums
    
    enum CodingKeys:String, CodingKey {
        case topAlbums = "topalbums"
    }
}

struct TopAlbums:Decodable{
    var album:[Album]
}

struct Album:Decodable{
    var name:String
    var image:[AlbumImage]
}

struct AlbumImage:Decodable{

    var imageUrl:String
    var imageSize:String

    enum CodingKeys:String,CodingKey {
        case imageUrl = "#text"
        case imageSize = "size"
    }

}
