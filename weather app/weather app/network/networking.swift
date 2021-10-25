//
//  networking.swift
//  weather app
//
//  Created by Brian Liew on 10/24/21.
//

import Foundation

class networking {
    
    func make_request(completion_handler: @escaping ([String: AnyObject]) -> [String: AnyObject]) {
        var json_dict: [String: AnyObject] = [:]
        
        // URLSession & URLSessionConfiguration
        let default_config = URLSessionConfiguration.default
        let session = URLSession(configuration: default_config)

        // URLSessionDataTask
        let data_task = session.dataTask(with: forecast_url!) { data, response, error in
            // HTTP status code validation
            guard let http_response = response as? HTTPURLResponse,
                  (200...299).contains(http_response.statusCode) else {
                      if let error_unwrapped = error { print("http response error: \(error_unwrapped.localizedDescription)") }
                      return
                  }
            
            // check if data is JSON
            guard let mime = response?.mimeType, mime == "application/json" else {
                if let error_unwrapped = error { print("MIME error: \(error_unwrapped.localizedDescription)") }
                return
            }
            
            /*
            if let data_unwrapped = data { print("DATA: \(data_unwrapped)") }
            if let response_unwrapped = response { print("RESPONSE: \(response_unwrapped)") }
            if let error_unwrapped = error { print("ERROR: \(error_unwrapped)") }
            */
            
            // conversion from type Data to Dictionary<String, AnyObject>
            if let json_data = try? JSONSerialization.jsonObject(with: data!, options: []) {
                json_dict = json_data as! [String: AnyObject]
                completion_handler(json_dict)
            } else {
                if let error_unwrapped = error {
                    print("JSON error: \(error_unwrapped.localizedDescription)") }
            }
        }
        data_task.resume()
    }
    
}
