//
//  ListSongsViewController.swift
//  Music
//
//  Created by LTT on 11/20/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import Alamofire
class ListSongsViewController: UIViewController {
    @IBOutlet weak var songTableView: UITableView!
    var photos: [Track] = [Track]()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        songTableView.register(SongTableViewCell.self)
        songTableView.dataSource = self
        songTableView.delegate = self
        
        activityIndicator.startAnimating()
        songTableView.tableFooterView = UIView(frame: .zero)
    }

    func loadData() {
        DataService.shared.fetchTrack { (success, tracks, error) in
            DispatchQueue.main.async {
                self.photos = tracks!
                self.songTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

//MARK: TableViewDelegate
extension ListSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let cell: SongTableViewCell = tableView.cellForRow(at: indexPath) as! SongTableViewCell
       cell.isSelected = true
        guard let url = URL(string: photos[indexPath.row].avatar!) else {
            return
        }
       imgBackground.sd_setImage(with: url, completed: nil)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell: SongTableViewCell = tableView.cellForRow(at: indexPath) as! SongTableViewCell
        cell.isSelected = false
    }
}

//MARK:TableViewDataSource
extension ListSongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SongTableViewCell = songTableView.dequeueResuableCell(forIndexPath: indexPath)
        let track = photos[indexPath.row]
        cell.configCell(with: track)
        return cell
    }
}
