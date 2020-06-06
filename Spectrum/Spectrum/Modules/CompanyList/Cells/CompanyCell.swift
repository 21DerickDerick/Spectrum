//
//  CompanyCell.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyCell: BaseTableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: MainLabel!
    @IBOutlet weak var companyWebsiteLabel: TertiaryLabel!
    @IBOutlet weak var companyDescriptionLabel: TertiaryLabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var followButton: FollowButton!
    
    var company: Company?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setupUI() {
        super.setupUI()
        
        cardView.layer.cornerRadius = 4
    }
    
    func setupCell(company: Company) {
        
        logoImageView.layer.cornerRadius = 4
        logoImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        if let urlString = company.logo, let url = URL(string: urlString) {
            logoImageView.kf.setImage(with: url)
        }
        
        companyNameLabel.text = company.name ?? ""
        companyWebsiteLabel.text = company.website ?? ""
        companyDescriptionLabel.text = company.about ?? ""
        
        self.company = company
        
        if company.isFollowed {
            followButton.setTitle("Following", for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
        }
        
        if company.isFavorite {
            favoriteButton.imageView?.image = UIImage(named: "FilledStar")!
        } else {
            favoriteButton.imageView?.image = UIImage(named: "EmptyStar")!
        }
    }
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        guard let company = company else { return }
        
        company.isFavorite = !company.isFavorite
        
        if company.isFavorite {
            favoriteButton.setImage(UIImage(named: "FilledStar")!, for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "EmptyStar")!, for: .normal)
        }
    }
    
    @IBAction func didTapFollowButton(_ sender: FollowButton) {
        guard let company = company else { return }
        
        company.isFollowed = !company.isFollowed
        
        if company.isFollowed {
            followButton.setTitle("Following", for: .normal)
        } else {
            followButton.setTitle("Follow", for: .normal)
        }
    }
}
