//
//  HeaderReusableView.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 15/05/2021.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    static let headerReusableViewID = "headerReusableView"
    
    private let headerLabel:UILabel = {
        var headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        headerLabel.text = "Albums"
        headerLabel.textColor = .black
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(headerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10), headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10), headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor), headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
        
    }
}
