//
//  Extensions.swift
//  nasay
//
//  Created by thisdjango on 17.04.2021.
//

import UIKit

extension UIView {
    
    @discardableResult
    func prepare() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func pin() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
}

