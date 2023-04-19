//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Vo Le Dinh Nghi on 05/04/2023.
//

import UIKit

enum Sections: Int{
    case TrendingMovies = 0
    case TrendingTvs = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovies: Title?
    private var headerView: HeaderUIView?
    
    let sectionTitle = ["Trending Movie", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]

    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.separatorColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500 ))
        homeFeedTable.tableHeaderView = headerView
        
//        navigationController?.pushViewController(TitlePreviewViewController(), animated: true)
        configureHeroHeaderView()
        
    }
    
    private func configureHeroHeaderView(){
        APICaller.share.getTrendingMovies{result in
            switch result{
            case .success(let titles):

                let selectedTitle = titles.randomElement()
                
                self.randomTrendingMovies = selectedTitle
                self.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar(){
        //extens resizeTo method from UIImage to give logo a fix size handle issue logo view have a fit width with content view
        let img = UIImage(named: "NetflixLogo")?.withRenderingMode(.alwaysOriginal)
                        .resizeTo(size: CGSize(width: 40, height: 40))
//        var imgLogo = UIImageView(image: img)
//        img = img?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .red
    }
    
}
extension UIImage {
    func resizeTo(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }
        
        return image.withRenderingMode(self.renderingMode)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            APICaller.share.getTrendingMovies{result in
                switch result{
                case .success(let titles):      //ask for title
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sections.TrendingTvs.rawValue:
            APICaller.share.getTrendingTvs { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sections.Upcoming.rawValue:
            APICaller.share.getTrendingTvs { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sections.Popular.rawValue:
            APICaller.share.getPopular { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sections.TopRated.rawValue:
            APICaller.share.getTopRated { result in
                switch result{
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x+20,
                                         y: header.bounds.origin.y,
                                         width: 100,
                                         height: header.bounds.height)
        header.textLabel?.textColor = .red
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
//    ======>>>>>ASK<<<<<=======
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int)  -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate{
    func collectionViewTableViewDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
