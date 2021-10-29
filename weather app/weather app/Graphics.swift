//
//  Graphics.swift
//  weather app
//
//  Created by Brian Liew on 10/29/21.
//

import Foundation

func fetch_graphics(input: String, completion_handler: @escaping (Data?) -> Void) -> Void {
    let graphics_url = URL(string: "http://openweathermap.org/img/wn/\(input)@2x.png")
    
    let default_config = URLSessionConfiguration.default
    let session = URLSession(configuration: default_config)
    
    DispatchQueue.global().async {
        // URLSessionDataTask
        let data_task = session.dataTask(with: graphics_url!) { data, response, error in
            // HTTP status code validation
            guard let http_response = response as? HTTPURLResponse,
                  (200...299).contains(http_response.statusCode) else {
                      if let error_unwrapped = error { print("http response error: \(error_unwrapped.localizedDescription)") }
                      return
                  }
            
            /*
            if let data_unwrapped = data { print("DATA: \(data_unwrapped)") }
            if let response_unwrapped = response { print("RESPONSE: \(response_unwrapped)") }
            if let error_unwrapped = error { print("ERROR: \(error_unwrapped)") }
            */
            
            if let data_unwrapped = data { print("graphical data: \(data_unwrapped)") }
        }

        data_task.resume()
    }
}
