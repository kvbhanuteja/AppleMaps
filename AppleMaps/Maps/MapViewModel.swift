//
//  MapViewModel.swift
//  AppleMaps
//
//  Created by bhanuteja on 26/08/22.
//

import Foundation
import CoreLocation

class MapViewModel {
    var locationPinsDropped = false
    
    func getLocations() throws -> [CLLocationCoordinate2D]? {
        if let filePath = Bundle.main.path(forResource: "Locations", ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let object = try JSONDecoder().decode(LocationData.self, from: data)
            print("location pins", object.result)
            var locations = [CLLocationCoordinate2D]()
            object.result.forEach { location in
                locations.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            }
            return locations
        }
        return nil
    }
}
