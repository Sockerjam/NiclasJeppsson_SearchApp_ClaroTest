//
//  CollectionViewCell.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let collectionViewReusableCellID = "reusableCollectionViewCell"
    
    private var artistImage:UIImageView = {
        let artistImage = UIImageView()
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        return artistImage
    }()
    
    private var artistName:UILabel = {
        let artistName = UILabel()
        artistName.translatesAutoresizingMaskIntoConstraints = false
        return artistName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(artistName:String, imageUrl:Image){
        
    }
    
    
    private func setConstraints(){
        
        [artistImage, artistName].forEach {addSubview($0)}
        
        NSLayoutConstraint.activate([artistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10), artistImage.heightAnchor.constraint(equalToConstant: 60), artistImage.widthAnchor.constraint(equalToConstant: 60), artistName.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    
}
