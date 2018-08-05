//
//  TodayViewController.swift
//  Twitch Top 3
//
//  Created by Wallace Souza Silva on 24/07/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import UIKit
import NotificationCenter
import SDWebImage

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var firstImageView: UIImageView?
    @IBOutlet weak var firstNameLabel: UILabel?
    @IBOutlet weak var firstActivityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var secondImageView: UIImageView?
    @IBOutlet weak var secondNameLabel: UILabel?
    @IBOutlet weak var secondActivityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var thirdImageView: UIImageView?
    @IBOutlet weak var thirdNameLabel: UILabel?
    @IBOutlet weak var thirdActivityIndicator: UIActivityIndicatorView?
    
    
    private let twitchClient = TwitchClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel?.text = nil
        secondNameLabel?.text = nil
        thirdNameLabel?.text = nil
        
        twitchClient.fetchPage(after: nil, withLimit: 3) { [weak self] result in
            switch result {
            case .success(let feedResult):
                self?.renderResult(feedResult.games)
                break
            case .failure(let error):
                print("ERROR: Erro buscando top 3\n\(error)")
                break
            }
        }
    }
    
    private func renderResult(_ games: [GameModel]) {
        firstNameLabel?.text = games[0].name
        firstImageView?.sd_setImage(with: URL(string: games[0].boxArtThumbnailUrl)) { [weak self] _, _, _, _ in
            self?.firstActivityIndicator?.stopAnimating()
        }
        secondNameLabel?.text = games[1].name
        secondImageView?.sd_setImage(with: URL(string: games[1].boxArtThumbnailUrl)) { [weak self] _, _, _, _ in
            self?.secondActivityIndicator?.stopAnimating()
        }
        thirdNameLabel?.text = games[2].name
        thirdImageView?.sd_setImage(with: URL(string: games[2].boxArtThumbnailUrl)) { [weak self] _, _, _, _ in
            self?.thirdActivityIndicator?.stopAnimating()
        }
        
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
