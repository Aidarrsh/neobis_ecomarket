//
//  extension + NSObject.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 27/10/23.
//

import Foundation
import UIKit

extension NSObject {
    func flexibleHeight(to: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height * to / 812
    }
    func flexibleWidth(to: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * to / 375
    }
}
