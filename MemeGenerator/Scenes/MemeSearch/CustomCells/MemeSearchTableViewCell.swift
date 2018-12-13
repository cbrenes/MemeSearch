//
//  MemeSearchTableViewCell.swift
//  MemeGenerator
//
//  Created by Cesar Brenes on 12/9/18.
//  Copyright © 2018 César Brenes. All rights reserved.
//

import UIKit
import Kingfisher

class MemeSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memeImageView: UIImageView!

    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func setupCell(displayedMeme: MemeSearch.DataSource.ViewModel.WithData.DisplayedMeme) {
            nameLabel.text = displayedMeme.name
            memeImageView.kf.indicatorType = .activity
            memeImageView.kf.setImage(with: displayedMeme.url, placeholder: displayedMeme.defaultImage, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
