//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 05/04/2023.
//

import UIKit

class HeaderUIView: UIView {
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.red
        button.layer.cornerRadius = 7
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.red
        button.layer.cornerRadius = 7
        return button
    }()
    
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.image = UIImage(named: "JokerImg")
        return imageView
    }()

    func addGradient( ){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
//            UIColor.systemBackground.cgColor
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints(){
        let ButtonConstrains = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55),
            downloadButton.widthAnchor.constraint(equalToConstant: 100),
        ]
        NSLayoutConstraint.activate(ButtonConstrains)
    }
    
    public func configure(with model: TitleViewModel){
        guard let url  = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else{
            return
        }
        headerImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
