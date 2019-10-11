//
//  LyricView.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

final class LyricView: UIViewController {
    
    @IBOutlet private weak var stackTrackInformations: UIStackView!
    @IBOutlet private weak var cnstUserProfileViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var imgUserProfilePicture: UILoadableImageView!
    @IBOutlet private weak var lblUserName: UILabel!
    @IBOutlet private weak var imgTrackAlbumPicture: UILoadableImageView!
    @IBOutlet private weak var lblTrackName: UILabel!
    @IBOutlet private weak var lblTrackArtistName: UILabel!
    @IBOutlet private weak var lblTrackAlbumName: UILabel!
    
    private let backgroundLayer = CAGradientLayer()
    
    private var viewModel: LyricViewModelProtocol!
    
    static func present(in view: UIViewController, with viewModel: LyricViewModelProtocol) {
        let lyricView = LyricView(with: viewModel)
        lyricView.modalPresentationStyle = .fullScreen
        view.present(lyricView, animated: false)
    }
    
    convenience init(with viewModel: LyricViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        viewModel.prepareContent()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundLayer.frame = view.bounds
    }
    
    private func setupView() {
        stackTrackInformations.isHidden = true
        
        cnstUserProfileViewBottom.constant = -200.0
        imgUserProfilePicture.layer.cornerRadius = 30.0
        
        backgroundLayer.colors = [UIColor.black.cgColor, UIColor.black.cgColor]
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
}

extension LyricView: LyricViewModelDelegate {
    
    func didUpdateUserInformations() {
        lblUserName.text = viewModel.userName
        imgUserProfilePicture.load(from: viewModel.userProfilePictureURL,
                                   placeholder: UIImage(named: "icon_user"))

        cnstUserProfileViewBottom.constant = 0
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    func didUpdateTrackInformations(changedAlbum: Bool) {
        guard viewModel.isPlaying else {
            stackTrackInformations.isHidden = true
            return
        }
        
        stackTrackInformations.isHidden = false
        lblTrackName.text = viewModel.trackName
        lblTrackArtistName.text = viewModel.trackArtistName
        lblTrackAlbumName.text = viewModel.trackAlbumName
        
        imgTrackAlbumPicture.load(from: viewModel.trackAlbumPictureURL,
                                  placeholder: UIImage(named: "icon_album")) { [weak self] in
            guard let self = self, changedAlbum, let image = self.imgTrackAlbumPicture.image else { return }
            
            let albumGradientScale = image.averageColor().gradientScale().map { $0.cgColor }
            self.backgroundLayer.animate(toColors: albumGradientScale, withDuration: 0.25)
        }
        
    }
}
