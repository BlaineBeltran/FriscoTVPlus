//
//  LayoutManager.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/8/23.
//

import UIKit

struct HeaderRegistrations {
    static let WatchNowHeroRegistration = "WatchNowHeroView"
}

enum WatchNowSections: Int, CaseIterable {
    case continueWatching
    case popular
    case becauseYouWatched
    case emphasize
    case comingSoon
}

struct LayoutManager {
    
    var headerConstraint: NSLayoutConstraint?
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { section, layoutEnv in
            guard let sectionKind = WatchNowSections(rawValue: section) else {
                preconditionFailure("Unable to find the section for \(section)")
            }
            
            switch sectionKind {
            /// They will all have the same section kind for now
            case .continueWatching:
                return createContinueWatchingSectionLayout()
            case .popular, .becauseYouWatched, .emphasize, .comingSoon:
                return createEmptySectionLayout()
            }
        }
        return layout
        
    }
    
    private func createContinueWatchingSectionLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // Add Header to Main section
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let watchNowHeroViewLayout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: HeaderRegistrations.WatchNowHeroRegistration, alignment: .topLeading)
        
        section.boundarySupplementaryItems = [watchNowHeroViewLayout]

        return section
    }
    
    private func createEmptySectionLayout() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // Add Header to Main section
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let watchNowHeroViewLayout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                 elementKind: HeaderRegistrations.WatchNowHeroRegistration, alignment: .top)
        
//        section.boundarySupplementaryItems = [watchNowHeroViewLayout]

        return section
    }
}
