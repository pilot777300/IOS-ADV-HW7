//
//  Annotation.swift
//  NavigTest
//
//  Created by Mac on 18.03.2023.
//

import Foundation
import MapKit

final class Annotation: NSObject, MKAnnotation {
    
    var name: String
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init (name: String,
          coordinate:CLLocationCoordinate2D,
          info: String)
    {
        self.name = name
        self.coordinate = coordinate
        self.info = info
    
    super.init()
    }
    
}
extension Annotation {
    
    static func make() -> [Annotation] {
        return[.init(name: "Люберцы", coordinate: CLLocationCoordinate2D(latitude: 55.6772, longitude: 37.8932), info: "!!!!"),
        
                .init(name: "Жуковский", coordinate: CLLocationCoordinate2D(latitude: 55.3604, longitude: 38.0658), info: "Дом"),
        ]
    }
}
