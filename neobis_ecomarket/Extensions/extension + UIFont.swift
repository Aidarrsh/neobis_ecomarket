//
//  extension + UIFont.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 27/10/23.
//

import Foundation
import UIKit

extension UIFont {
    static func ttBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "TTNormsPro-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func ttMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "TTNormsPro-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func interSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
