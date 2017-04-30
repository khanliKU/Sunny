//
//  Gadget.swift
//  Sunny
//
//  Created by Kutlay Hanli on 30/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit

class Gadget: NSObject
{
	var name:String
	var consumption:Double

	init(name: String, consumption: Double)
	{
		self.name = name
		self.consumption = consumption
	}
}
