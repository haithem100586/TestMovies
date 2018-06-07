//
//  S2CDetails.swift
//  TestMovies
//
//  Created by Macbook on 15/10/2017.
//  Copyright © 2017 HE. All rights reserved.
//

import UIKit
import FloatRatingView

class S2CDetails: UITableViewCell {
    
    
    
    @IBOutlet var detailImage: UIImageView!
    @IBOutlet var realedDateLabel: UILabel!
    
    @IBOutlet var criticsRating: FloatRatingView!
    
    @IBOutlet var audienceRating: FloatRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


