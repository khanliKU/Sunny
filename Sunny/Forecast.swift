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
	private (set) var day:Int
	private (set) var month:Int
	private (set) var year:Int
	private (set) var cloud:Double = 0.0
	init(Day: Int, Month: Int, Year: Int, Cloud:Double)
	{
		day = Day
		month = Month
		year = Year
		cloud = Cloud
	}
}
