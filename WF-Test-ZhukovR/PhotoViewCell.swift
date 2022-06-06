//
//  PhotoViewCell.swift
//  WF-Test-ZhukovR
//
//  Created by Roman Zhukov on 05.06.2022.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
