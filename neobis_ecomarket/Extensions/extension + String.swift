//
//  extension + String.swift
//  neobis_ecomarket
//
//  Created by Айдар Шарипов on 4/11/23.
//

import Foundation
import UIKit

extension String {
    func chunkFormatted(withSeparator separator: Character) -> String {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        let mask = "xxxx xxx xxx"
        var index = cleanPhoneNumber.startIndex
        
        for char in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if char == separator {
                result.append(separator)
            } else {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            }
        }
        return result
    }
}
