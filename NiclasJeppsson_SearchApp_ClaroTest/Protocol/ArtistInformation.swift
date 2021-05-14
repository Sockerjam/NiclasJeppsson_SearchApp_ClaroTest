//
//  ArtistInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation

protocol ArtistInformation {
    func searchArtist(with artistName:String)
    func getArtistAlbums(with artistName:String)
}
