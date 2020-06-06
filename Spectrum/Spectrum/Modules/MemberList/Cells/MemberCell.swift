//
//  MemberCell.swift
//  Spectrum
//
//  Created by Derick on 6/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit


class MemberCell: BaseTableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameAndAgeLabel: MainLabel!
    @IBOutlet weak var emailLabel: TertiaryLabel!
    @IBOutlet weak var phoneLabel: TertiaryLabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var member: Member?
    
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
    
    func setupCell(member: Member) {
        self.member = member
        
        var age = ""
        
        if let memberAge = member.age {
            age = String(memberAge)
        }
        
        nameAndAgeLabel.text = "\(member.name?.first ?? "") \(member.name?.last ?? ""), \(age)"
        emailLabel.text = member.email ?? ""
        phoneLabel.text = member.phone ?? ""
        
        if member.isFavorite {
            favoriteButton.setImage(UIImage(named: "FilledStar")!, for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "EmptyStar")!, for: .normal)
        }
    }
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        guard let member = member else { return }
        
        member.isFavorite = !member.isFavorite
        
        if member.isFavorite {
            favoriteButton.setImage(UIImage(named: "FilledStar")!, for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "EmptyStar")!, for: .normal)
        }
    }
}
