//
//  Subject.swift
//  NBC-W6-Kiosk
//
//  Created by 전성규 on 11/26/24.
//

import Foundation

protocol Subject {
    mutating func addObserver(_ observer: Observer)
}
