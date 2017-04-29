//
//  ViewController.swift
//  Sunny
//
//  Created by Kutlay Hanli on 29/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{
	
	var dateFormatter = DateFormatter()
	var locationManager = CLLocationManager()
	
	var latDelta:CLLocationDegrees = 0.01
	var lonDelta:CLLocationDegrees = 0.01
	
	func test()
	{
		let userLocation = locationManager.location?.coordinate
		latDelta = (userLocation?.latitude)!
		lonDelta = (userLocation?.longitude)!
		let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=\(latDelta)&lon=\(lonDelta)&APPID=7e09cac8c143712d38166f92b28dc790&units=metric")!
		let getForecast = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
			// data var ise
			if let urlContent = data
			{
				// decode et
				do
				{
					let json = try JSONSerialization.jsonObject(with: urlContent) as? [String: Any]
					let list = json?["list"] as? [[String:Any]]
					for element in list!
					{
						let cloudData = element["clouds"] as! [String:Any]
						let date = element["dt_txt"] as! String
						print("Date: \(date) Cloudy: \(cloudData["all"]!)%")
					}
				}
				catch
				{
					print("Error deserializing JSON: \(error)")
				}
				let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)!
				// istedigin stringi ara
				//print(webContent)
			}
			
		})
		
		
		getForecast.resume()
		/*
		// boşlukları doldur.
		let input = inputCity.text?.replacingOccurrences(of: " ", with: "-")
		// string to url
		let url = URL(string: "http://www.weather-forecast.com/locations/" + input! + "/forecasts/latest")!
		// datayı al
		let getForecast = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
		// data var ise
		if let urlContent = data
		{
		// decode et
		let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)!
		// istedigin stringi ara
		let websiteArray = webContent.components(separatedBy: "Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
		if ( websiteArray.count > 1)
		{
		let forecast = websiteArray[1].components(separatedBy: "</span>")
		if (forecast.count > 1)
		{
		let weatherSummary = forecast[0].replacingOccurrences(of: "&deg;", with: "º")
		// ekranda goster
		DispatchQueue.main.async(execute: { () -> Void in
		self.displayLabel.text = weatherSummary
		self.displayLabel.textColor = UIColor.blue
		})
		print(weatherSummary)
		}
		}
		else
		{
		DispatchQueue.main.async(execute: { () -> Void in
		self.displayLabel.text = "Invalid City"
		self.displayLabel.textColor = UIColor.red
		})
		}
		}
		
		})
		
		
		getForecast.resume()
		*/
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		print(dateFormatter.string(from: NSDate() as Date))
		
		let date = dateFormatter.string(from: NSDate() as Date)
		let tokenizers = CharacterSet(charactersIn: "- :")
		let scanner = Scanner(string: date)
		scanner.charactersToBeSkipped = tokenizers
		
		var year:NSString?
		scanner.scanUpToCharacters(from: tokenizers, into: &year)
		
		print(year!)
		
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
		test()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
}

