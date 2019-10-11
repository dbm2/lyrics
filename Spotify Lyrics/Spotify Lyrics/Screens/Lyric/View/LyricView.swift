//
//  LyricView.swift
//  Spotify Lyrics
//
//  Created by Daniel Maranhão on 10/10/19.
//  Copyright © 2019 Daniel Maranhão. All rights reserved.
//

import UIKit

final class LyricView: UIViewController {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var stackTrackInformations: UIStackView!
    @IBOutlet private weak var constraintUserProfileViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var imgUserProfilePicture: UILoadableImageView!
    @IBOutlet private weak var lblUserName: UILabel!
    @IBOutlet private weak var imgTrackAlbumPicture: UILoadableImageView!
    @IBOutlet private weak var lblTrackName: UILabel!
    @IBOutlet private weak var lblTrackArtistName: UILabel!
    @IBOutlet private weak var lblTrackAlbumName: UILabel!
    @IBOutlet private weak var viewUserInformations: UIView!
    @IBOutlet private weak var lblLyric: UILabel!
    
    private let backgroundLayer = CAGradientLayer()
    
    private var viewModel: LyricViewModelProtocol = LyricViewModel()
    
    static func present(in view: UIViewController) {
        let lyricView = LyricView()
        lyricView.modalPresentationStyle = .fullScreen
        view.present(lyricView, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        viewModel.prepareContent()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundLayer.frame = view.bounds
    }
    
    private func setupView() {
        viewUserInformations.clipsToBounds = true
        viewUserInformations.layer.cornerRadius = 15.0
        viewUserInformations.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        constraintUserProfileViewBottom.constant = -200.0
        
        imgUserProfilePicture.layer.cornerRadius = 30.0
        
        stackTrackInformations.isHidden = true
        lblLyric.isHidden = true
        
        backgroundLayer.colors = [UIColor.black.cgColor, UIColor.black.cgColor]
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    @IBAction private func logout(_ sender: UIButton) {
        viewModel.logout()
    }
}

extension LyricView: LyricViewModelDelegate {
    
    func didUpdateUserInformations() {
        activityIndicator.isHidden = true
        
        lblUserName.text = viewModel.userName
        imgUserProfilePicture.load(from: viewModel.userProfilePictureURL,
                                   placeholder: UIImage(named: "icon_user"))

        constraintUserProfileViewBottom.constant = 0
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    func didUpdateTrackInformations(changedAlbum: Bool) {
        lblLyric.isHidden = true
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
    
    func didUpdateLyricInformations() {
        lblLyric.isHidden = false
        guard viewModel.hasLyric else {
            lblLyric.text = "Sorry, we couldn’t find any lyrics for this song."
            return
        }
        
        lblLyric.text = viewModel.lyric
    }
    
    func presentApp() {
        AppView.present(in: self)
    }
}
