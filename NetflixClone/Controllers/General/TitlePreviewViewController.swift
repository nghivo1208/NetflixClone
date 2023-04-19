//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 11/04/2023.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry Potter"
        label.numberOfLines = 3
        
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "Something overview"
        return label
    }()
    
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLable)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        configureConstrains()
        
    }
    
    private func configureConstrains(){
        let webKitConstrains = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleLableConstrains = [
            titleLable.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let overviewLableConstrains = [
            overviewLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        let downloadButtonConstrains = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webKitConstrains)
        NSLayoutConstraint.activate(titleLableConstrains)
        NSLayoutConstraint.activate(overviewLableConstrains)
        NSLayoutConstraint.activate(downloadButtonConstrains)
    }
    
    func configure(with model: TitlePreviewViewModel){
        titleLable.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "http://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
    
}
