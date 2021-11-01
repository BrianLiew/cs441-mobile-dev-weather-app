//
//  ViewController.swift
//  weather app
//
//  Created by Brian Liew on 10/21/21.
//

import UIKit

let screen_width = UIScreen.main.bounds.width
let screen_height = UIScreen.main.bounds.height

let big_font = UIFont(name: "Chalkduster", size: 24)
let small_font = UIFont(name: "Chalkduster", size: 16)

class ViewController: UIViewController {

    // MARK: UI element declarations
    
    // UIScrollView
    let scroll_view = UIScrollView(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
    // UIView
    let background = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
    let temperature_background = UIView(frame: CGRect(x: 0, y: screen_height / 2, width: screen_width, height: 175))
    let wind_background = UIView(frame: CGRect(x: 0, y: screen_height / 2 + 175, width: screen_width, height: 175))
    // UIImageView
    let weather_graphic = UIImageView(frame: CGRect(x: screen_width / 2 - 100, y: screen_height / 4 + 25, width: 200, height: 175))
    // UILabel
    let city_label = UILabel(frame: CGRect(x: 0, y: screen_height / 4 - 150, width: screen_width, height: 100))
    // DESCRIPTION
    let weather_description_label = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 4 - 25, width: 300, height: 50))
    // TEMPERATURE
    let temp_title = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2, width: 300, height: 50))
    let temp_label = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2 + 50, width: 200, height: 100))
    let temp_max_label = UILabel(frame: CGRect(x: screen_width / 2 + 50, y: screen_height / 2 + 50, width: 100, height: 50))
    let temp_min_label = UILabel(frame: CGRect(x: screen_width / 2 + 50, y: screen_height / 2 + 100, width: 100, height: 50))
    // WIND
    let wind_title = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2 + 175, width: 300, height: 50))
    let wind_deg_label = UILabel(frame: CGRect(x: screen_width / 2 - 150, y: screen_height / 2 + 225, width: 150, height: 100))
    let wind_speed_label = UILabel(frame: CGRect(x: screen_width / 2, y: screen_height / 2 + 225, width: 150, height: 100))
    // let attribution = UILabel(frame: CGRect(x: 0, y: 0, width: screen_width, height: 10))
    
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
        background.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.5)
        temperature_background.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.6, alpha: 0.2)
        wind_background.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 1.0, alpha: 0.5)
        city_label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.5)
        temp_label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 0.5)
        temp_max_label.backgroundColor = UIColor(red: 0.5, green: 0.6, blue: 0, alpha: 0.5)
        temp_min_label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.5, alpha: 0.5)
        wind_deg_label.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 1.0, alpha: 1.0)
        wind_speed_label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 1.0, alpha: 1.0)
        
        temp_label.layer.cornerRadius = 0.5
        temp_label.layer.masksToBounds = true
        
        city_label.text = "-"
        weather_description_label.text = "-"
        temp_title.text = "Temperature"
        temp_label.text = "0.00 °F"
        temp_max_label.text = "0.00 °F"
        temp_min_label.text = "0.00 °F"
        wind_title.text = "Wind"
        // attribution.text = "https://www.vecteezy.com/free-vector/weather-forecast"
        
        city_label.textAlignment = .center
        weather_description_label.textAlignment = .center
        temp_label.textAlignment = .center
        temp_title.textAlignment = .center
        temp_max_label.textAlignment = .center
        temp_min_label.textAlignment = .center
        wind_title.textAlignment = .center
        wind_deg_label.textAlignment = .center
        wind_speed_label.textAlignment = .center
        
        city_label.font = big_font
        weather_description_label.font = big_font
        temp_label.font = big_font
        temp_title.font = big_font
        temp_max_label.font = small_font
        temp_min_label.font = small_font
        wind_title.font = big_font
        wind_deg_label.font = big_font
        wind_speed_label.font = big_font
        
        view.addSubview(scroll_view)
        scroll_view.addSubview(background)
        scroll_view.addSubview(temperature_background)
        scroll_view.addSubview(wind_background)
        scroll_view.addSubview(weather_graphic)
        scroll_view.addSubview(city_label)
        scroll_view.addSubview(weather_description_label)
        scroll_view.addSubview(temp_label)
        scroll_view.addSubview(temp_title)
        scroll_view.addSubview(temp_max_label)
        scroll_view.addSubview(temp_min_label)
        scroll_view.addSubview(wind_title)
        scroll_view.addSubview(wind_deg_label)
        scroll_view.addSubview(wind_speed_label)
    }
    
    func update_UI(
        city_name: String,
        weather_description_string: String,
        country_name: String,
        temp_double: Double,
        temp_max_double: Double,
        temp_min_double: Double,
        wind_deg_int: Int,
        wind_speed_double: Double
    ) -> Void {
        self.city_label.text = city_name + ", " + country_name
        self.weather_description_label.text = weather_description_string
        self.temp_label.text = String(format: "%.1f", convert_kelvin_to_fahrenheit(input: temp_double)) + "°F"
        self.temp_max_label.text = String(format: "%.1f", convert_kelvin_to_fahrenheit(input: temp_max_double)) + "°F"
        self.temp_min_label.text = String(format: "%.1f", convert_kelvin_to_fahrenheit(input: temp_min_double)) + "°F"
        self.wind_deg_label.text = convert_deg_to_direction(input: wind_deg_int)
        self.wind_speed_label.text = String(format: "%.2f", wind_speed_double) + " mph"
    }
    
    // MARK: data function
    
    // completion handler for make_request(). parser.
    func request_completion_handler(json: Data?) -> Void {
        if let json_unwrapped = json {
            DispatchQueue.main.async {
                let weather_data = try? self.decoder.decode(weather_data.self, from: json_unwrapped)
                if let weather_data_unwrapped = weather_data {
                    print(weather_data_unwrapped)
                    self.update_UI(
                        city_name: weather_data_unwrapped.name,
                        weather_description_string: weather_data_unwrapped.return_description().capitalized,
                        country_name: weather_data_unwrapped.sys.country,
                        temp_double: weather_data_unwrapped.main.temp,
                        temp_max_double: weather_data_unwrapped.main.temp_max,
                        temp_min_double: weather_data_unwrapped.main.temp_min,
                        wind_deg_int: weather_data_unwrapped.wind.deg,
                        wind_speed_double: weather_data_unwrapped.wind.speed
                    )
                    self.weather_graphic.image = UIImage(data: try! Data(contentsOf: URL(string: "http://openweathermap.org/img/wn/\(weather_data_unwrapped.return_icon())@2x.png")!))!
                }
            }
        } else { print("json unwrap error") }
    }
    
}
