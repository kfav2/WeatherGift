//
//  HourlyCollectionViewCell.swift
//  WeatherGift
//
//  Created by Korlin Favara on 1/14/22.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var hourlyTemperature: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    var hourlyWeather: HourlyWeather! {
        didSet{
            hourLabel.text = hourlyWeather.hour
            iconImageView.image = UIImage(systemName: hourlyWeather.hourlyIcon)
            hourlyTemperature.text = "\(hourlyWeather.hourlyTemp)°"
        }
    }
}
