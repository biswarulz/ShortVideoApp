//
//  ExploreViewController.swift
//  ShortVideoApp
//
//  Created by Biswajyoti Sahu on 05/05/21.
//

import UIKit

class ExploreViewController: UIViewController {

    var exploreList: [Expolre] = []
    var albumsCollectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0, weight: .bold)]
        title = "Explore"
        readData()
        configureCollectionView()
    }

    func readData() {
        
        if let path = Bundle.main.path(forResource: "assignment", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
           let exploreData = try? JSONDecoder().decode([Expolre].self, from: data) {
            
            exploreList = exploreData
        }
    }
    
    func configureCollectionView() {
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: "ExploreCell")
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: "section_header", withReuseIdentifier: "HeaderCell")
        albumsCollectionView = collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(180), heightDimension: .absolute(300))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "section_header", alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
        
        return layout
    }
}

extension ExploreViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return exploreList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return exploreList[section].nodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as? ExploreCollectionViewCell else {
            
            fatalError("cannot create header view")
        }
        let node = exploreList[indexPath.section].nodes[indexPath.item]
        cell.sectionIndex = indexPath.section
        cell.itemIndex = indexPath.item
        cell.fillData(node, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath) as? HeaderCollectionReusableView else {
            
            fatalError("cannot create header view")
        }
        let data = exploreList[indexPath.section]
        header.fillData(data)
        return header
    }
}

extension ExploreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = VideoViewController()
        let nodes = exploreList[indexPath.section].nodes
        detailVC.nodeData = nodes
        detailVC.indexPathToLoad = indexPath
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

