//
//  HeaderCollectionReusableView.swift
//  ShortVideoApp
//
//  Created by Biswajyoti Sahu on 07/05/21.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    var headerLabel = UILabel()
    override init(frame: CGRect) {
        
        headerLabel = UILabel()
        headerLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.adjustsFontForContentSizeCategory = true
        
        super.init(frame: frame)
        backgroundColor = .systemBackground

        addSubview(headerLabel)
        addCustomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillData(_ data: Expolre) {
        
        headerLabel.text = data.title
    }
    
    private func addCustomConstraint() {
        
        NSLayoutConstraint.activate([
            
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
        ])
    }
}
