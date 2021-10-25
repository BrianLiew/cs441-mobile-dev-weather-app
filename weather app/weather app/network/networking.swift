//
//  networking.swift
//  weather app
//
//  Created by Brian Liew on 10/24/21.
//

import Foundation

class networking {
    
    func make_request() -> [String: AnyObject] {
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
            
            // conversion from type Data to NSDictionary
            if let json_data = try? JSONSerialization.jsonObject(with: data!, options: []) {
                json_dict = json_data as! [String: AnyObject]
                print("string obg: \(json_dict)")
                //print(type(of: json_dict))
            } else {
                if let error_unwrapped = error {
                    print("JSON error: \(error_unwrapped.localizedDescription)") }
            }
        }

        data_task.resume()
        
        print(json_dict)
        
        return json_dict
    }
    
    
    /*
    func parse_JSON(json: Data) -> forecast {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let tmp_forecast = forecast(temp: 0, temp_max: 0, temp_min: 0, description: "")
   
        do {
            let json_decoded = try decoder.decode(forecast.self, from: json)
           
            return json_decoded
        } catch {
            print("error")
        }
        
        return tmp_forecast
    }
    */

}
