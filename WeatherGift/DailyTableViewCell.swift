//
//  DailyTableViewCell.swift
//  WeatherGift
//
//  Created by Korlin Favara on 1/14/22.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyWeekdayLabel: UILabel!
    @IBOutlet weak var dailySummaryView: UITextView!
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    
    var dailyWeather: DailyWeather! {
        didSet{
                dailyImageView.image = UIImage(named: dailyWeather.dailyIcon)
                dailyWeekdayLabel.text = dailyWeather.dailyWeekday
                dailySummaryView.text = dailyWeather.dailySummary
                dailyHighLabel.text = "\(dailyWeather.dailyHigh)°"
                dailyLowLabel.text = "\(dailyWeather.dailyLow)°"
            }
        }
    }
