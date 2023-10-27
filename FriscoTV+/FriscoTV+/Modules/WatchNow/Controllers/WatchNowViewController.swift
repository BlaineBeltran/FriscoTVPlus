//
//  WatchNowViewController.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/7/23.
//

import UIKit
import SnapKit

class WatchNowViewController: UIViewController {
    typealias Copy = Constants.home
    
    lazy var watchNowCollectionView: UICollectionView = {
        let layout = LayoutManager().createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var datasource: UICollectionViewDiffableDataSource<WatchNowSections, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        installSubviews()
        installConstraints()
        configureDatasource()
        
        let service = PopularMoviesService()
        Task {
            do {
                let results = try await service.fetchPopularMovies()
                print(results)
            } catch {
                print("GOT ERROR: \(error)")
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        /// Wait until we have the correct layout geometry before calculating the offset
        /// Ideally, as of iOS 17, this should be done in viewIsAppearing
        let contentOffset = self.topbarHeight
        watchNowCollectionView.contentInset = UIEdgeInsets(top: -contentOffset, left: 0, bottom: 0, right: 0)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func installSubviews() {
        view.addSubview(watchNowCollectionView)
    }
    
    private func installConstraints() {
        watchNowCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureViewController() {
        title = Copy.title
        navigationController?.navigationBar.isHidden = true
        navigationItem.titleView = UIView()
        
    }
    
    private func configureDatasource() {
        let watchNowHeroViewRegistration = watchNowHeroViewRegistration()
        
        /// Used to configure cells
        datasource = UICollectionViewDiffableDataSource(collectionView: watchNowCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let sectionKind = WatchNowSections(rawValue: indexPath.section) else {
                preconditionFailure("Received unknown section: \(indexPath.section)")
            }
            return UICollectionViewCell()
        })
        
        /// Used to configure headers/footers
        datasource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            if indexPath.section == 0 {
                let watchNowHeroView = collectionView.dequeueConfiguredReusableSupplementary(using: watchNowHeroViewRegistration, for: indexPath)
                return watchNowHeroView
            }
            return nil
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<WatchNowSections,Int>()
        snapshot.appendSections(WatchNowSections.allCases)
        datasource.apply(snapshot, animatingDifferences: false)
    }
    
    private func watchNowHeroViewRegistration() -> UICollectionView.SupplementaryRegistration<WatchNowCollectionViewHeader> {
        let headerRegistration = UICollectionView.SupplementaryRegistration<WatchNowCollectionViewHeader>(elementKind: HeaderRegistrations.WatchNowHeroRegistration) { supplementaryView, elementKind, indexPath in
            /// Configure header cell here
            print(supplementaryView)
        }
        return headerRegistration
    }
}
