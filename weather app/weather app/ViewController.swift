//
//  ViewController.swift
//  weather app
//
//  Created by Brian Liew on 10/21/21.
//

import UIKit

let screen_width = UIScreen.main.bounds.width
let screen_height = UIScreen.main.bounds.height

let big_font = UIFont.boldSystemFont(ofSize: 30)
let small_font = UIFont.boldSystemFont(ofSize: 15)

class ViewController: UIViewController {

    // MARK: UI element declarations
    
    // UIView
    let top_background = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height / 2))
    let bottom_background = UIView(frame: CGRect(x: 0, y: screen_height / 2, width: screen_width, height: screen_height / 2))
    // UIImageView
    let weather_graphic = UIImageView(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 4, width: 300, height: 150))
    // UILabel
    let city_label = UILabel(frame: CGRect(x: 0, y: screen_height / 4 - 150, width: screen_width, height: 100))
    let temp_title = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2, width: 300, height: 50))
    let temp_label = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2 + 50, width: 300, height: 100))
    let temp_max_label = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2 + 200, width: 100, height: 50))
    let temp_max_title = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2 + 150, width: 100, height: 50))
    let temp_min_label = UILabel(frame: CGRect(x: screen_width / 2 + 50, y: screen_height / 2 + 200, width: 100, height: 50))
    let temp_min_title = UILabel(frame: CGRect(x: screen_width / 2 + 50, y: screen_height / 2 + 150, width: 100, height: 50))
    
    // MARK: JSONDecoder declaration
    
    let decoder = JSONDecoder()
    
    // MARK: ViewController functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        init_UI()

        let network_instance = Networking()
        network_instance.make_request(completion_handler: request_completion_handler)
    }
    
    // MARK: UI functions
    
    func init_UI() {
        top_background.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.5)
        bottom_background.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.5)
        weather_graphic.backgroundColor = UIColor.white
        city_label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.5)
        temp_label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.5)
        temp_max_label.backgroundColor = UIColor(red: 0.5, green: 0.6, blue: 0, alpha: 0.5)
        temp_min_label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.5, alpha: 0.5)
        
        city_label.text = "-"
        temp_title.text = "Temperature"
        temp_label.text = "0.00 °F"
        temp_max_label.text = "0.00 °F"
        temp_max_title.text = "Maximum"
        temp_min_label.text = "0.00 °F"
        temp_min_title.text = "Minimum"
        
        city_label.textAlignment = .center
        temp_label.textAlignment = .center
        temp_title.textAlignment = .center
        temp_max_label.textAlignment = .center
        temp_max_title.textAlignment = .center
        temp_min_label.textAlignment = .center
        temp_min_title.textAlignment = .center
        
        city_label.font = big_font
        temp_label.font = big_font
        temp_title.font = big_font
        temp_max_label.font = small_font
        temp_max_title.font = small_font
        temp_min_label.font = small_font
        temp_min_title.font = small_font
        
        view.addSubview(top_background)
        view.addSubview(bottom_background)
        view.addSubview(weather_graphic)
        view.addSubview(city_label)
        view.addSubview(temp_label)
        view.addSubview(temp_title)
        view.addSubview(temp_max_label)
        view.addSubview(temp_max_title)
        view.addSubview(temp_min_label)
        view.addSubview(temp_min_title)
    }
    
    func update_UI(
        city_name: String,
        temp_double: Double,
        temp_max_double: Double,
        temp_min_double: Double
    ) -> Void {
        self.city_label.text = city_name
        self.temp_label.text = String(format: "%.1f", convert_kelvin_to_fahrenheit(input: temp_double)) + "°F"
        self.temp_max_label.text = String(format: "%.1f", convert_kelvin_to_fahrenheit(input: temp_max_double)) + "°F"
        self.temp_min_label.text = String(format: "%.1f", convert_kelvin_to_fahrenheit(input: temp_min_double)) + "°F"
    }
    
    // MARK: data function
    
    // completion handler for make_request(). parser.
    func request_completion_handler(json: Data?) -> Void {
        if let json_unwrapped = json {
            DispatchQueue.main.async {
                let weather_data = try? self.decoder.decode(weather_data.self, from: json_unwrapped)
                if let weather_data_unwrapped = weather_data {
                    self.update_UI(
                        city_name: weather_data_unwrapped.name,
                        temp_double: weather_data_unwrapped.main.temp,
                        temp_max_double: weather_data_unwrapped.main.temp_max,
                        temp_min_double: weather_data_unwrapped.main.temp_min
                    )
                }
            }
        } else { print("json unwrap error") }
    }
    
}

