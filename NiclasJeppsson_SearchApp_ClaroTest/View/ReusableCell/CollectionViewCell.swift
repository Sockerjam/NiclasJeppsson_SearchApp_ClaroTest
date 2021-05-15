//
//  CollectionViewCell.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let collectionViewReusableCellID = "reusableCollectionViewCell"
    
    private var artistImage:UIImageView = {
        let artistImage = UIImageView()
        artistImage.contentMode = .scaleAspectFit
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        artistImage.setContentHuggingPriority(.required, for: .horizontal)
        return artistImage
    }()
    
    private var artistName:UILabel = {
        let artistName = UILabel()
        let textAttribute = NSAttributedString(string: "", attributes: [.font:UIFont(name: "Helvetica", size: 15)!])
        artistName.attributedText = textAttribute
        artistName.adjustsFontSizeToFitWidth = true
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
    
    func configureCell(with artistName:String, with imageUrl:String){
        DispatchQueue.main.async {
            self.artistName.text = artistName
            self.artistImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
    
    
    private func setConstraints(){
        
        [artistImage, artistName].forEach {addSubview($0)}
        
        let constraintHeight = NSLayoutConstraint(item: artistImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        constraintHeight.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
    
            artistImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            artistImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            artistImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            artistImage.heightAnchor.constraint(equalTo: heightAnchor),
            artistImage.widthAnchor.constraint(equalToConstant: 60),
            artistName.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 10),
            artistName.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        ])
    }
    
    
}
