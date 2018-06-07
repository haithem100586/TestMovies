//
//  MovieCell.swift
//  TestMovies
//
//  Created by Macbook on 15/10/2017.
//  Copyright © 2017 HE. All rights reserved.
//

import UIKit
import Spring

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImage: DesignableImageView!
    @IBOutlet weak var movieLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
