//
//  networking.swift
//  weather app
//
//  Created by Brian Liew on 10/24/21.
//

import Foundation

class networking {
    
    let forecast_url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&appid=865e25bdadd4ab58522a489eed0685de")
    
    func make_request() {
        // URLSession & URLSessionConfiguration
        let session_config = URLSessionConfiguration.default
        let session = URLSession(configuration: session_config)
        
        // URLSessionDataTask
        let data_task = session.dataTask(with: forecast_url!) { data, response, error in
            print("data task created")
            
            // HTTP status code validation
            guard let http_response = response as? HTTPURLResponse,
                  (200...299).contains(http_response.statusCode) else {
                      print("http response error")
                      return
                  }
            
            // check if data is JSON
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("wrong MIME type")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                print(json)
            } else {
                if let error_unwrapped = error {
                    print("JSON error: \(error_unwrapped.localizedDescription)") }
            }
            
            /*
            if let data_unwrapped = data { print("DATA: \(data_unwrapped)") }
            if let response_unwrapped = response { print("RESPONSE: \(response_unwrapped)") }
            if let error_unwrapped = error { print("ERROR: \(error_unwrapped)") }
            */
            
        }

        data_task.resume()
        
    }
        
}
