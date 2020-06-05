//
//  FollowButton.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

class FollowButton: UIButton {
    let width: CGFloat = 88
    let height: CGFloat = 32
    let topAndBottomInset: CGFloat = 12
    let leftAndRightInset: CGFloat = 4
    let cornerRadius: CGFloat = 4
    let activeColor = UIColor.spectrumFollowButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    override var intrinsicContentSize: CGSize {
        let s = super.intrinsicContentSize
        return CGSize(
            width: s.width + leftAndRightInset + leftAndRightInset,
            height: s.height + topAndBottomInset + topAndBottomInset)
    }
    
    private func setupUI() {
        layer.cornerRadius = cornerRadius
        backgroundColor = activeColor
        setTitleColor(UIColor.white, for: .normal)
        
        widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
        titleEdgeInsets = UIEdgeInsets(
            top: topAndBottomInset,
            left: leftAndRightInset,
            bottom: topAndBottomInset,
            right: leftAndRightInset)
        
        titleLabel?.font = .secondary
    }
}
