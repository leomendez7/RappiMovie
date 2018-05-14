//
//  DateFormatter+RappiMovies.swift
//  RappiMovies
//
//  Created by Leonardo Mendez on 10/05/18.
//  Copyright © 2018 Leonardo Mendez. All rights reserved.
//

import Foundation

extension DateFormatter {
    func formatDate(from string: String) -> Date? {
        self.dateFormat = "yyyy-MM-dd"
        return self.date(from: string)
    }
}
