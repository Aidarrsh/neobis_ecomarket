//
//  extension + UIImage.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 3/11/23.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
