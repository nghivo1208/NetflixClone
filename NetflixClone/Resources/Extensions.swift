//
//  Extensions.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 07/04/2023.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
