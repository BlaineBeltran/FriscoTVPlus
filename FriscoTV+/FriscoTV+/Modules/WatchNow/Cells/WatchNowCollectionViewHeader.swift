//
//  WatchNowCollectionViewHeader.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/7/23.
//

import UIKit
import SwiftUI
import SnapKit

class WatchNowCollectionViewHeader: UICollectionReusableView {
    
    let HeroImageView: UIImageView = {
        let heroImage = UIImage(named: "Elemental")!
        let imageView = UIImageView(image: heroImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "\(genre) - \(movieLength)"
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A small description about the movie that actually pretty cool."
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    /// Probably need a page view controller instead
    let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 10
        if #available(iOS 17.0, *) {
            let progress = UIPageControlTimerProgress(preferredDuration: 20)
            control.progress = progress
        }
        return control
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        let clear = UIColor.clear
        let black = UIColor.black
        gradient.colors = [UIColor.clear.cgColor, black.cgColor ]
        layer.insertSublayer(gradient, at: 1)
        return gradient
    }()
    
    let genre = "Comedy"
    let movieLength = "2hr 30 min"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        installSubviews()
        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func installSubviews() {
        addSubview(HeroImageView)
        addSubview(infoLabel)
        addSubview(movieDescriptionLabel)
        addSubview(pageControl)
    }
    private func configureConstraints() {
        HeroImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(8)
            make.centerX.equalTo(infoLabel.snp.centerX)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

struct WatchNowCollectionViewHeader_Preview: PreviewProvider {
    static var previews: some View {
        WatchNowCollectionViewHeaderRepresentable()
            .frame(width: 375, height: 450)
            .previewLayout(.sizeThatFits)
    }
}

struct WatchNowCollectionViewHeaderRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return WatchNowCollectionViewHeader()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
