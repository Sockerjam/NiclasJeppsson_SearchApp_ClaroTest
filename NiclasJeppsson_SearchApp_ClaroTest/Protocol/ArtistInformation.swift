//
//  ArtistInformation.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

protocol ArtistInformation {
    
    func searchArtist(with artistName:String)
    func getArtistAlbums(with artistName:String)
    func setArtistModelDataSource(with dataSource: UICollectionViewDiffableDataSource<Section, Artist>)
    func artistModelSnapShot(with data:[Artist])
    
}
