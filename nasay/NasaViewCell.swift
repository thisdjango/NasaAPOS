//
//  NasaViewCell.swift
//  nasay
//
//  Created by thisdjango on 17.04.2021.
//

import UIKit

class NasaViewCell: UICollectionViewCell {
    static let cellId = "imageCell"
    
    var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    var text: String? {
        didSet {
            explanation.text = text
        }
    }
    
    private let imageView = UIImageView()
    private let explanation = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView.prepare())
        addSubview(explanation.prepare())
        
        imageView.contentMode = .scaleAspectFill
        explanation.font = .systemFont(ofSize: 24)
        explanation.backgroundColor = .init(white: 1, alpha: 0.7)
        layer.masksToBounds = true
        layer.cornerRadius = 15
        // Layout
        imageView.pin()
        explanation.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        explanation.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        explanation.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
