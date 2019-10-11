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
        lyricView.modalTransitionStyle = .crossDissolve
        view.present(lyricView, animated: true)
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
        constraintUserProfileViewBottom.constant = -200.0
        viewUserInformations.clipsToBounds = true
        viewUserInformations.layer.cornerRadius = 15.0
        viewUserInformations.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        imgUserProfilePicture.layer.cornerRadius = 30.0
        stackTrackInformations.alpha = 0.0
        lblLyric.alpha = 0.0
        
        let defaultColor = UIColor(white: 0.70, alpha: 1.0)
        backgroundLayer.colors = [defaultColor.cgColor, defaultColor.cgColor]
        view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    @IBAction private func logout(_ sender: UIButton) {
        viewModel.logout()
    }
    
    private func updateBackground() {
        guard let image = imgTrackAlbumPicture.image else { return }
        let albumGradientScale = image.averageColor().gradientScale().map { $0.cgColor }
        backgroundLayer.animate(to: albumGradientScale, with: 0.25)
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
        lblLyric.animate(to: 0.0, with: 0.15)
        guard viewModel.isPlaying else {
            stackTrackInformations.animate(to: 0.0, with: 0.25)
            return
        }
        
        stackTrackInformations.animate(to: 1.0, with: 0.25)
        
        UILabel.animate(with: 0.25, viewsTexts: (lblTrackName, viewModel.trackName),
                                                (lblTrackArtistName, viewModel.trackArtistName),
                                                (lblTrackAlbumName, viewModel.trackAlbumName))
        
        imgTrackAlbumPicture.load(from: viewModel.trackAlbumPictureURL,
                                  placeholder: UIImage(named: "icon_album")) { [weak self] in
            guard changedAlbum else { return }
            self?.updateBackground()
        }
    }
    
    func didUpdateLyricInformations() {
        lblLyric.animate(to: 1.0, with: 0.15)
        lblLyric.animate(to: viewModel.lyric, with: 0.25)
    }
    
    func presentApp() {
        LoginView.present(in: self)
    }
}
