//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 07/04/2023.
//

import UIKit
import SDWebImage


class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionCellView"
    
    private let posterImgView: UIImageView = {
        
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 12
        return imgView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImgView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImgView.frame = contentView.bounds
    }
    
    public func configure(with model: String){
        guard let url  = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else{
            return
        }
        print(model)
        posterImgView.sd_setImage(with: url, completed: nil) //delêt from code
    }
    
}
