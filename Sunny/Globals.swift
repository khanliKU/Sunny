//
//  Globals.swift
//  Sunny
//
//  Created by Kutlay Hanli on 30/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit

var panels = [Panel(brand: "Elfland",model: "Harvester", m2: 0.5),Panel(brand: "Solar City",model: "Just Read The Instructions", m2: 0.5)]
var forecasts = [Forecast]()
var gadgets = [Gadget(name: "Phone",consumption: 5.45),Gadget(name: "Laptop",consumption: 40),Gadget(name: "Flashlight", consumption: 15)]
var POA = [Double]()

var totalArea = 0.0
var totalConsumption = 0.0
var totalGeneration = 0.0

class Globals: NSObject {

}
