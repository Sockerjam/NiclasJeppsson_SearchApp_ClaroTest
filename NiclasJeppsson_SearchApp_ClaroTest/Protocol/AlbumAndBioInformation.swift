//
//  AlbumAndBioInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 16/05/2021.
//

import UIKit

protocol AlbumAndBioInformationProtocol {
    
    func getArtistAlbums(with artistName:String)
    func getArtistBio(with artistName:String)
    func setAlbumModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Album>)
    func artistAlbumSnapShot(with albumData:[Album])
    var setDelegate:ArtistBioDelegate { get set }
}

protocol ArtistBioDelegate {
    func getBioData(bio:String, listeners:String, playcount:String)
}
