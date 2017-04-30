//
//  PanelTableViewCell.swift
//  Sunny
//
//  Created by Kutlay Hanli on 30/04/2017.
//  Copyright © 2017 Kutlay Hanli. All rights reserved.
//

import UIKit

class PanelTableViewCell: UITableViewCell {

	@IBOutlet weak var brand: UILabel!
	@IBOutlet weak var model: UILabel!
	@IBOutlet weak var m2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
