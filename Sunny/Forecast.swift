//
//  Forecast.swift
//  Sunny
//
//  Created by Kutlay Hanli on 29/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit

class Forecast: NSObject
{
	private (set) var day:Double = 0.0
	private (set) var month:Double = 0.0
	private (set) var year:Double = 0.0
	private (set) var cloud:Double = 0.0
	private (set) var humidity:Double = 0.0
	private (set) var angle:Double = 0.0
	
	init(Day: String, Month: String, Year: String, Cloud:String, Humidity:String)
	{
		super.init()
		day = Double(Day)!
		month = Double(Month)!
		year = Double(Year)!
		cloud = Double(Cloud)!
		humidity = Double(Humidity)!
		self.sunAngle()
	}
	
	func sunAngle()
    {
	
	}
}
