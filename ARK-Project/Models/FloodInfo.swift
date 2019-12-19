//
//  FloodInfo.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import Foundation



struct Place {
    var latitude: Double
    var longitude: Double
    var floodedInYear: Int
    var directionOfSafeZone: String
    var feetUnderWater: Int
    var populationEffected: Int
    var searchName: String
    var danger: Int
}
var place1 = Place(latitude: 40.7605031, longitude: -73.9509934, floodedInYear: 2200, directionOfSafeZone: "West", feetUnderWater: 7, populationEffected: 11_945, searchName: "Roosevelt Island", danger: 3)
var place2 = Place(latitude: 25.7825452, longitude: -80.2996701, floodedInYear: 2200, directionOfSafeZone: "West", feetUnderWater: 6, populationEffected: 463_347, searchName: "Miami", danger: 2)
var place3 = Place(latitude: 36.1251954, longitude: -115.3154268, floodedInYear: 3500, directionOfSafeZone: "SouthWest", feetUnderWater: 6, populationEffected: 641_676, searchName: "Las Vegas", danger: 7)

var NY = ["Expected to flood in 2200", "In the yr. 2200 it will be 7' under water", "Number of population effected: 11,945", "Danger level: 3", "Go west to be in a safe zone"]
var FL = ["Expected to flood in 2200", "In the yr. 2200 it will be 6' under water", "Number of population effected: 463,347", "Danger level: 2", "Go west to be in a safe zone"]
var NV = ["Expected to flood in 3500", "In the yr. 3500 it will be 6' under water", "Number of population effected: 641,676", "Danger level: 7", "Go southwest to be in a safe zone"]
