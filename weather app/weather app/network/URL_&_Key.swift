//
//
//  URL_&_Key.swift
//  weather app
//
//  Created by Brian Liew on 10/21/21.
//

import Foundation

private let key: String = "865e25bdadd4ab58522a489eed0685de"

let forecast_url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&appid=\(key)")

