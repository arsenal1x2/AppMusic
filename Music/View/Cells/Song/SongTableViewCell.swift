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
    override var isSelected: Bool {
        didSet {
                let hidden = self.isSelected ? false : true
                setView(view: viewAvatar, hidden: hidden)
                setView(view: viewButton, hidden: hidden)
                let color = UIColor(hexString: "#A901DB")
                self.nameSong.textColor = self.isSelected ? color : UIColor.black
                self.nameSinger.textColor = self.isSelected ? color : UIColor.black
        }
    }

    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewAvatar.isHidden = true
        viewButton.isHidden = true
        self.nameSong.textColor =  UIColor.black
        self.nameSinger.textColor =  UIColor.black
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        //isSelected = false
        self.nameSong.textColor =  UIColor.black
        self.nameSinger.textColor =  UIColor.black
    }

    @IBAction func clickPlayButton(_ sender: Any) {
        delegate?.songTableViewCellDidClickPlayButton()
    }

    func configCell(with track: Track) {
        guard let singer = track.singer else { return }
        guard let avatar = track.avatar else { return }
        guard let name = track.name else { return }
        nameSinger.text = singer
        nameSong.text = name
        guard let url = URL(string: avatar) else { return }
        imageSong.sd_setImage(with: url, completed: nil)
    }
}

protocol SongTableViewCellDelegate: class {
    func songTableViewCellDidClickPlayButton()
}
