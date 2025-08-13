//
//  CustomTextField.swift
//  MovieList
//
//  Created by Rasim Burak Kaya on 24.07.2025.
//

import Foundation
import UIKit

final class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        borderStyle = .none
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        leftView = padding
        leftViewMode = .always
        
        attributedPlaceholder = NSAttributedString(
                   string: placeholder ?? "",
                   attributes: [
                       .foregroundColor: UIColor.gray,
                       .font: UIFont.systemFont(ofSize: 14)
                   ]
               )
        
        textColor = .black
    }
}
