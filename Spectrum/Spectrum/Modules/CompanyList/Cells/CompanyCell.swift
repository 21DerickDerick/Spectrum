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
    @IBOutlet weak var companyEmailLabel: TertiaryLabel!
    @IBOutlet weak var companyDescriptionLabel: TertiaryLabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var followButton: FollowButton!
    
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
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapFollowButton(_ sender: FollowButton) {
    }
}
