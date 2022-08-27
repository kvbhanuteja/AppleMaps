//
//  LocationDataModel.swift
//  AppleMaps
//
//  Created by bhanuteja on 26/08/22.
//

import Foundation

struct LocationData: Codable {
    let result: [LocationPins]
}

struct LocationPins: Codable {
    let latitude: Double
    let longitude: Double
}
