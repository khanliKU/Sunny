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
	
	let alert = UIAlertController(title: "Connecting", message: "Gathering solar radiation data and forecast", preferredStyle: UIAlertControllerStyle.alert)
	
	
	var latDelta:CLLocationDegrees = 0.01
	var lonDelta:CLLocationDegrees = 0.01
	
	var poa = [Double]()
	
	var year:Int = 0
	var month:Int = 0
	var day:Int = 0
	var hour:Int = 0
	
	func getSolarRadiationData()
	{
		let url = URL(string: "https://developer.nrel.gov/api/pvwatts/v5.json?api_key=PytdR7eeSMdiOWjlgsXMr7vZqIRutg9nIclhEISj&timeframe=hourly&module_type=0&losses=0&array_type=0&tilt=30&azimuth=180&lat=\(latDelta)&lon=\(lonDelta)&dataset=intl&radius=0&system_capacity=1")!
		let getForecast = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
			// data var ise
			if let urlContent = data
			{
				// decode et
				
				do
				{
					let json = try JSONSerialization.jsonObject(with: urlContent) as? [String: Any]
					let outputs = json?["outputs"] as? [String:Any]
					self.poa = (outputs?["poa"] as? [Double])!
					
					
					
				}
				catch
				{
					print("Error deserializing JSON: \(error)")
				}

				POA = self.poaForDate(month: self.month, day: self.day)
				print(POA)
				
				//let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)!
				// istedigin stringi ara
				//print(webContent)
			}
			
		})
		
		
		getForecast.resume()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		print(getSpecificDay(month: 3, day: 12))
		
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		print(dateFormatter.string(from: NSDate() as Date))
		
		let date = dateFormatter.string(from: NSDate() as Date)
		let tokenizers = CharacterSet(charactersIn: "- :")
		let scanner = Scanner(string: date)
		scanner.charactersToBeSkipped = tokenizers
		
		var year:NSString?
		scanner.scanUpToCharacters(from: tokenizers, into: &year)
		var month:NSString?
		scanner.scanUpToCharacters(from: tokenizers, into: &month)
		var day:NSString?
		scanner.scanUpToCharacters(from: tokenizers, into: &day)
		var hour:NSString?
		scanner.scanUpToCharacters(from: tokenizers, into: &hour)
		
		self.year = (year?.integerValue)!
		self.month = (month?.integerValue)!
		self.day = (day?.integerValue)!
		self.hour = (hour?.integerValue)!
		
		print(year!)
		
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
		alert.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: nil))

	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func button(_ sender: Any)
	{
		self.present(alert, animated: true, completion: nil)
		let userLocation = locationManager.location?.coordinate
		latDelta = (userLocation?.latitude)!
		lonDelta = (userLocation?.longitude)!
		getSolarRadiationData()
		getForecastData()
	}
	
	func getForecastData()
	{
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
						
						let tokenizers = CharacterSet(charactersIn: "- :")
						let scanner = Scanner(string: date)
						scanner.charactersToBeSkipped = tokenizers
						
						var year:NSString?
						scanner.scanUpToCharacters(from: tokenizers, into: &year)
						var month:NSString?
						scanner.scanUpToCharacters(from: tokenizers, into: &month)
						var day:NSString?
						scanner.scanUpToCharacters(from: tokenizers, into: &day)
						var hour:NSString?
						scanner.scanUpToCharacters(from: tokenizers, into: &hour)
						
						let Year = (year?.integerValue)!
						let Month = (month?.integerValue)!
						let Day = (day?.integerValue)!
						let Hour = (hour?.integerValue)!
						
						if (self.day == Day)
						{
							forecasts.append(Forecast(Day: Day, Month: Month, Year: Year, Cloud: cloudData["all"] as! Double))
						}
						
					}
				}
				catch
				{
					print("Error deserializing JSON: \(error)")
				}
				//let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)!
				// istedigin stringi ara
				//print(webContent)
			}
			
		})
		getForecast.resume()
	}
	
	func getSpecificDay(month: Int, day: Int) -> Int
	{
		if (day > 0)
		{
			return day + getSpecificDay(month: month,day: 0)
		}
		if (month == 12)
		{
			return 30 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 11)
		{
			return 31 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 10)
		{
			return 30 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 9)
		{
			return 31 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 8)
		{
			return 31 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 7)
		{
			return 30 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 6)
		{
			return 31 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 5)
		{
			return 30 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 4)
		{
			return 31 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 3)
		{
			return 28 + getSpecificDay(month: month-1,day: 0)
		}
		else if (month == 2)
		{
			return 31 + getSpecificDay(month: month-1,day: 0)
		}
		return 0
	}
	
	func poaForDate(month: Int, day:Int) -> [Double]
	{
		let start:Int = (getSpecificDay(month: month, day: day) - 1) * 24
		let end:Int = start+24
		return Array(poa[start..<end])
	}
}

