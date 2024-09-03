//
//  WeatherTableViewCell.swift
//  TestAir
//
//  Created by Rimvydas on 2024-08-31.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "WeatherTableViewCell"
    static let nib = UINib(nibName:  "WeatherTableViewCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

