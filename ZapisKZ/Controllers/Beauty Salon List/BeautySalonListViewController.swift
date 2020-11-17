//
//  BeautySalonListViewController.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SnapKit

class BeautySalonListViewController: UIViewController {
    
    //MARK: - Views
    var collectionView: UICollectionView!
    
    //MARK: - Coordinator
    var coordinator: BeautySalonListCoordinator?
    
    //MARK: - ViewModel
    var viewModel: BeautySalonListViewModel?
    
    //MARK: - CollectionView Data Source
    var dataSource: UICollectionViewDiffableDataSource<Section, BeautyProvider>?
    
    //MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        setupCollectionView()
        registerCollectionViewCells()
        bindData()
        guard let viewModel = viewModel else { return }
        viewModel.fetchMainPageData()
    }
    
    //MARK: - MVVM Data Binding
    
    func bindData() {
        if let viewModel = viewModel {
            
            viewModel.mainPageData.bind { [weak self] in
                guard let value = $0 else { return }
                let snapshot = viewModel.prepareDataSourceSnapshot(data: value)
                self?.createDataSource()
                self?.reloadData(withSnapshot: snapshot)
            }
        }
    }    
}

extension BeautySalonListViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
    }
    
    func setupNavigationBar() {
        self.title = "Главная"
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewCompositionalLayout())
        collectionView.backgroundColor = .white
        collectionView.clipsToBounds = false
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.delegate = self
    }
    
    func registerCollectionViewCells() {
        collectionView.register(UINib(nibName: "BeautyProviderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BeautyProviderCollectionViewCell.reuseID)
        collectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseID)
    }
    
    func createDataSource() {
        guard let viewModel = viewModel else { return }
        
        dataSource = UICollectionViewDiffableDataSource<Section, BeautyProvider>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, beautyProvider) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeautyProviderCollectionViewCell.reuseID, for: indexPath) as? BeautyProviderCollectionViewCell else { fatalError("Unable to dequeue cell") }
            
            switch viewModel.sections[indexPath.section].sectionType {
            case .salon:
                cell.viewModel = BeautyProviderCollectionViewCellViewModel(beautyProvider: beautyProvider, indexPath: indexPath, sectionType: .salon)
                return cell
            case .master:
                cell.viewModel = BeautyProviderCollectionViewCellViewModel(beautyProvider: beautyProvider, indexPath: indexPath, sectionType: .master)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseID, for: indexPath) as? SectionHeaderView else { return nil }
            
            guard let beautyProvider = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(containingItem: beautyProvider) else { return nil }
            
            sectionHeader.sectionTitleLabel.text = section.sectionTitle
            sectionHeader.sectionDescriptionLabel.text = section.sectionDescription
            return sectionHeader
        }
    }
    
    func reloadData(withSnapshot snapshot: NSDiffableDataSourceSnapshot<Section, BeautyProvider>) {
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func createCollectionViewCompositionalLayout() -> UICollectionViewLayout {
        guard let viewModel = viewModel else { return UICollectionViewLayout() }
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.createBeautyProviderSection()
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createBeautyProviderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.top = 5
        item.contentInsets.bottom = 5
        item.contentInsets.leading = 10
        item.contentInsets.trailing = 10
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .absolute(UIScreen.main.bounds.height * 0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

extension BeautySalonListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let beautyProvider = dataSource?.itemIdentifier(for: indexPath), let id = beautyProvider.id else { return }
        coordinator?.coordinateToBeautyProviderDetail(beautyProviderID: id)
    }
}
