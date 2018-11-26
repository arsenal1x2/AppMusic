//
//  ListSongsViewController.swift
//  Music
//
//  Created by LTT on 11/20/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import Alamofire

protocol ListSongViewControllerDelegate: class {
    func listSongViewController(tracks: Tracks, index: Int)
}

class ListSongsViewController: UIViewController {
    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var imgBackground: UIImageView!
    var tracks: Tracks!
    var activityView:UIView!
    weak var delegate:ListSongViewControllerDelegate?
    var indexPlay: Int = 0
    var indexSelected: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        activityView = showActivityIndicatory(uiView: view)
        loadData()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setupTableView() {
        songTableView.register(SongTableViewCell.self)
        songTableView.dataSource = self
        songTableView.delegate = self
        songTableView.tableFooterView = UIView(frame: .zero)
        if(tracks == nil){
            return
        }
    }

    func loadData() {
        DataService.shared.fetchTrack { (success, tracks, error) in
            DispatchQueue.main.async {
                self.tracks = tracks
                self.songTableView.reloadData()
                self.activityView.isHidden = true
            }
        }
    }

    func showActivityIndicatory(uiView: UIView) -> UIView {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.init(hexString: "0xffffff").withAlphaComponent(0.3)
        let loadingView: UIView = UIView()

        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.init(hexString: "0x444444").withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        return container
    }
}

//MARK: TableViewDelegate
extension ListSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       imgBackground.cacheImage(urlString: self.tracks.tracks[indexPath.row].avatar)
       indexPlay = indexPath.row
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }

    func backToPlayViewController(index: Int) {
        let storyboard = UIStoryboard(storyboard: .main)
        let vc: PlayViewController = storyboard.instantiateViewController()
        self.delegate = vc
        vc.delegateListSongViewController = self
        tracks.currentIndexOfTrack = index
        delegate?.listSongViewController(tracks: tracks, index: index)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:TableViewDataSource
extension ListSongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tracks == nil) { return 0 }
        return tracks.tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SongTableViewCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
        let track = tracks.tracks[indexPath.row]
        cell.configCell(with: track)
        cell.delegate = self
        return cell
    }
}

//SongTableViewCellDelegate
extension ListSongsViewController: SongTableViewCellDelegate {

    func songTableViewCellDidClickPlayButton() {
        backToPlayViewController(index: indexPlay)
    }
}

extension ListSongsViewController: ViewControllerDelegate {
    func playViewController(_ playViewController: PlayViewController, indexIsPlaying: Int) {
        self.indexSelected = indexIsPlaying
        let indexpath = IndexPath(row: indexSelected, section: 0)
        songTableView.selectRow(at: indexpath, animated: false, scrollPosition: .bottom)
    }
}
