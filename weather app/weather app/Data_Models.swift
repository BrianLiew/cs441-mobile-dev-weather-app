//
//  Data_Models.swift
//  weather app
//
//  Created by Brian Liew on 10/27/21.
//

import Foundation

struct weather_data: Codable {
    var name: String
    var main: main
    // var weather: weather
}

struct main: Codable {
    var temp: Double
    var temp_max: Double
    var temp_min: Double
}

/*
struct weather: Codable {
    var description: String
    var icon: String
    var id: Int
    var main: String
}
 */
