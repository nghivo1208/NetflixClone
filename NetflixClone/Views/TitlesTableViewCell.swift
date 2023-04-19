//
//  TitlesTableViewCell.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 10/04/2023.
//

import UIKit

class TitlesTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image  = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLable: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        label.numberOfLines = 3
        return label
    }()
    
    private let titlePosterUIImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints(){
        let titlePosterUIImageViewConstrains = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant:100)
        ]
        
        let titleLableConstrains = [
            titleLable.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor, constant: 20),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLable.heightAnchor.constraint(equalTo: titlePosterUIImageView.heightAnchor),
            titleLable.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: -5)
        ]
        
        let playTitleButtonContrains = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playTitleButton.widthAnchor.constraint(equalToConstant: 70)
        ]
        
        NSLayoutConstraint.activate(titlePosterUIImageViewConstrains)
        NSLayoutConstraint.activate(titleLableConstrains)
        NSLayoutConstraint.activate(playTitleButtonContrains)
    }
    
    func configure(with model: TitleViewModel){
        guard let url  = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else{
            return
        }
        titlePosterUIImageView.sd_setImage(with: url, completed: nil)
        titleLable.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
