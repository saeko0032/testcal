//
//  CalendarCell.swift
//  Calminder
//
//  Created by saekof on 2017-04-04.
//  Copyright © 2017 saeko0032. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var mainTaskLabel: UILabel!
    @IBOutlet weak var subTaskLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dayLabel.text = nil
        mainTaskLabel.text = nil
        subTaskLabel.text = nil
    }
}
