//
//  SongTableViewCell.swift
//  Music
//
//  Created by LTT on 11/20/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit


class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var viewButton: UIView!
    weak var delegate: SongTableViewCellDelegate?
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var nameSinger: UILabel!

    func setView(view: UIView, hidden: Bool) {
            view.isHidden = hidden
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI(isSelected: selected)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewAvatar.isHidden = true
        viewButton.isHidden = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameSong.textColor =  UIColor.black
        self.nameSinger.textColor =  UIColor.black
    }

    @IBAction func clickPlayButton(_ sender: Any) {
        delegate?.songTableViewCellDidClickPlayButton()
    }

    func configCell(with track: Track) {
        nameSinger.text = track.singer
        nameSong.text = track.name
        imageSong.cacheImage(urlString: track.avatar)
    }

    func setupUI(isSelected: Bool) {
        let hidden = self.isSelected ? false : true
        setView(view: viewAvatar, hidden: hidden)
        setView(view: viewButton, hidden: hidden)
        let color = UIColor(hexString: "#A901DB")
        self.nameSong.textColor = self.isSelected ? color : UIColor.white
        self.nameSinger.textColor = self.isSelected ? color : UIColor.white
    }
}

protocol SongTableViewCellDelegate: class {
    func songTableViewCellDidClickPlayButton()
}
