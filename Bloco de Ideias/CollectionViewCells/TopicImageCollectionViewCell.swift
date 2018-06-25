//
//  TopicImageCollectionViewCell.swift
//  Bloco de Ideias
//
//  Created by Ada 2018 on 20/06/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class TopicImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet var view: UIView!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var viewBlur: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 4.0
        
        deleteButton.layer.isHidden = true
        
        viewBlur.backgroundColor = UIColor.white
    }
        
    //---------------- Wiggling -------------
    func startWiggling() {
        guard view.layer.animation(forKey: "wiggle") == nil else { return }
        guard view.layer.animation(forKey: "bounce") == nil else { return }
        
        deleteButton.layer.isHidden = false
        let angle = 0.04
        
        //--- wiggle
        let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        wiggle.values = [-angle, angle]
        
        wiggle.autoreverses = true
        wiggle.duration = randomInterval(interval: 0.2, variance: 0.030)
        wiggle.repeatCount = Float.infinity
        
        contentView.layer.add(wiggle, forKey: "wiggle")
        
        //--- bounce
        let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounce.values = [4.0, 0.0]
        
        bounce.autoreverses = true
        bounce.duration = randomInterval(interval: 0.12, variance: 0.025)
        bounce.repeatCount = Float.infinity
        
        contentView.layer.add(bounce, forKey: "bounce")
    }
    
    func stopWiggling() {
        deleteButton.layer.isHidden = true
        contentView.layer.removeAllAnimations()
    }
    
    func randomInterval(interval: TimeInterval, variance: Double) -> TimeInterval {
        return interval + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopWiggling()
    }

}
