//
//  Panel.swift
//  Sunny
//
//  Created by Kutlay Hanli on 30/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit

class Panel: NSObject
{
	var m2:Double
	var model:String
	var brand:String
	init(brand: String, model: String, m2: Double)
	{
		self.brand = brand
		self.m2 = m2
		self.model = model
	}
}
