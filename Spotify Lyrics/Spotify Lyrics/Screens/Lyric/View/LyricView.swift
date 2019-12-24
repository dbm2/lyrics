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
    @IBOutlet private weak var scrollView: UIScrollView!
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
    @IBOutlet private weak var lblNoMusic: UILabel!
    
    private var currentLyricScale: CGFloat?
    private let backgroundLayer = CAGradientLayer()
    private let refreshControl = UIRefreshControl()
    
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
        lblNoMusic.isHidden = true
        
        let defaultColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1.0)
        backgroundLayer.colors = [defaultColor.cgColor, defaultColor.cgColor]
        view.layer.insertSublayer(backgroundLayer, at: 0)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .white
        scrollView.refreshControl = refreshControl
    }
    
    @IBAction private func logout(_ sender: UIButton) {
        viewModel.logout()
    }
    
    @IBAction private func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began, let currentScale = currentLyricScale {
            sender.scale = currentScale
        } else if sender.state == .ended {
            currentLyricScale = sender.scale
        }
        let fontSize: CGFloat = min(max(17.0, sender.scale * 17), 35.0)
        lblLyric.font = UIFont(name: "Helvetica Neue", size: fontSize)
    }
    
    private func updateBackground() {
        guard let image = imgTrackAlbumPicture.image else { return }
        let albumGradientScale = image.averageColor().gradientScale().map { $0.cgColor }
        backgroundLayer.animate(to: albumGradientScale, with: 0.25)
    }
    
    private func updateBackgroundDefault() {
        let defaultColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1.0)
        backgroundLayer.animate(to: [defaultColor.cgColor, defaultColor.cgColor], with: 0.25)
    }
    
    @objc private func refresh() {
        guard !refreshControl.isRefreshing, activityIndicator.isHidden else { return }
        viewModel.refresh()
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
        guard viewModel.isPlaying else {
            lblNoMusic.isHidden = false
            lblLyric.isHidden = true
            stackTrackInformations.isHidden = true
            updateBackgroundDefault()
            return
        }
        
        lblNoMusic.isHidden = true
        lblLyric.isHidden = false
        stackTrackInformations.isHidden = false
        lblLyric.animate(to: 0.0, with: 0.15)
        
        stackTrackInformations.animate(to: 1.0, with: 0.25)
        
        UILabel.animate(with: 0.25, viewsTexts: (lblTrackName, viewModel.trackName),
                                                (lblTrackArtistName, viewModel.trackArtistName),
                                                (lblTrackAlbumName, viewModel.trackAlbumName))
    
        if changedAlbum {
            imgTrackAlbumPicture.load(from: viewModel.trackAlbumPictureURL,
                                      placeholder: UIImage(named: "icon_album")) { [weak self] in
                self?.updateBackground()
            }
        }
    }
    
    func didUpdateLyricInformations() {
        lblLyric.animate(to: 1.0, with: 0.15)
        lblLyric.animate(to: viewModel.lyric, with: 0.25)
    }
    
    func didEndRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func presentApp() {
        LoginView.present(in: self)
    }
}
