//
//  TVShowCell.swift
//  RateTheShowApp
//
//  Created by Анна Никифорова on 14.04.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class TVShowCell: UITableViewCell {
    
    @IBOutlet weak var tvShowView: UIView!
    @IBOutlet weak var tvShowPoster: UIImageView!
    @IBOutlet weak var tvShowNameLabel: UILabel!
    @IBOutlet weak var tvShowRatingLabel: UILabel!
    @IBOutlet weak var tvShowFirstAirDateLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    
    func setTVShow(tvShow: TVShowInfo) {
        tvShowNameLabel.text = tvShow.name
        tvShowRatingLabel.text = String(Int((tvShow.vote_average ?? 0) * 10))
        tvShowRatingLabel.layer.cornerRadius = 15
        tvShowRatingLabel.layer.masksToBounds = true
        
        // TODO: add genre label
        tvShowFirstAirDateLabel.text = "\(tvShow.genre_ids)"
        
        // date formatting
//        func formatDate(dateMovie: String) -> String {
//            let dateFormatterGet = DateFormatter()
//            dateFormatterGet.dateFormat = "yyyy-MM-dd"
//
//            let dateFormatterPrint = DateFormatter()
//            dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
//
//            if let date = dateFormatterGet.date(from: tvShow.first_air_date ?? "") {
//                return dateFormatterPrint.string(from: date)
//            } else {
//                print("There was an error decoding the string")
//            }
//            return ""
//        }
//        tvShowFirstAirDateLabel.text = formatDate(dateMovie: tvShow.first_air_date ?? "")
        
        // image converting
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (tvShow.poster_path ?? "")) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.tvShowPoster.image = image
                    }
                }
            }
        }
        
        // TODO: add image fading shadow
        tvShowView.layer.shadowColor = UIColor.gray.cgColor
        tvShowView.layer.shadowOpacity = 0.5
        tvShowView.layer.shadowOffset = .zero
        tvShowView.layer.shadowRadius = 6
        tvShowView.layer.shouldRasterize = true
        tvShowView.layer.rasterizationScale = UIScreen.main.scale

        
        rateButton.titleLabel?.numberOfLines = 1
        rateButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    
    @IBAction func rateButtonTapped(_ sender: UIButton) {
        sender.pulsate()
    }
}

