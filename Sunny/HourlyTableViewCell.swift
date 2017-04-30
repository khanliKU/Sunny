//
//  HourlyTableViewCell.swift
//  Sunny
//
//  Created by Kutlay Hanli on 30/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

	@IBOutlet weak var hour: UILabel!
	@IBOutlet weak var kwh: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
