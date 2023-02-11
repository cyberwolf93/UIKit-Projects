//
//  StringExtension.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 16/01/2023.
//

import UIKit

extension String {
    func localizedString(with comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    
    func textHeight(width:CGFloat, textStyle: UIFont.TextStyle = .body) -> CGFloat? {
        let rectSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let textSize = self.boundingRect(with: rectSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: textStyle)], context: nil)
        
        return ceil(textSize.height)
    }
}

