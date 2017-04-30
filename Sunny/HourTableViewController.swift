//
//  HourTableViewController.swift
//  Sunny
//
//  Created by Kutlay Hanli on 30/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit

class HourTableViewController: UITableViewController {
	
	var needed = [Bool](repeating: false, count: 24)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		totalGeneration = 0.0
		totalArea = 0.0
		totalConsumption = 0.0
		
		for panel in panels
		{
			totalArea += panel.m2
		}
		
		for gadget in gadgets
		{
			totalConsumption += gadget.consumption
		}
		
		findTimeIntervalNeeded(index: 12)
		self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return POA.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourly", for: indexPath) as! HourlyTableViewCell

        cell.hour.text = "\(indexPath.row):00"
		cell.kwh.text = "\(POA[indexPath.row] * totalArea * (1 - 0.3) * 0.12) Wh"

		if (needed[indexPath.row])
		{
			cell.backgroundColor = UIColor.green
		}
		
        return cell
    }
	

	func findTimeIntervalNeeded(index: Int)
	{
		if (totalGeneration >= totalConsumption)
		{
			return
		}
		totalGeneration += POA[index] * totalArea * (1 - 0.3) * 0.12
		if (index == 12)
		{
			findTimeIntervalNeeded(index: 13)
		}
		else if (index == 13)
		{
			findTimeIntervalNeeded(index: 11)
		}
		else if (index == 11)
		{
			findTimeIntervalNeeded(index: 14)
		}
		else if (index == 14)
		{
			findTimeIntervalNeeded(index: 10)
		}
		else if (index == 10)
		{
			findTimeIntervalNeeded(index: 15)
		}
		needed[index] = true
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
