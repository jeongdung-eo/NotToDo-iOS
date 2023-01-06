//
//  CustomTabBarView.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/06.
//

import UIKit

import Then
import SnapKit

protocol CustomTabBarDelegate: AnyObject {
    func scrollToIndex(to index: Int)
}
class CustomTabBarView: UIView {
    
    var defaultIndex: Int = 0
    weak var delegate: CustomTabBarDelegate?
    let titleList: [CustomTabBarItem] = CustomTabBarItem.items
    //data
    enum Section : Int,Hashable {
        case main
    }
    typealias Item = AnyHashable
    var dataSource : UICollectionViewDiffableDataSource<Section,Item>! = nil
    lazy var collectionview = UICollectionView(frame: self.bounds, collectionViewLayout: layout()).then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setViews()
        registerSubViews()
        setupCollectioView()
        setupCustomTabBar()
        setupDataSource() // presentation
        reloadData() // data
        collectionview.reloadData()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setViews(){
        self.addSubview(collectionview)
    }
    private func registerSubViews(){
        collectionview.register(CustomTabBarCell.self, forCellWithReuseIdentifier: CustomTabBarCell.reusedId)
    }
    private func setupCollectioView(){
        //  초기 tapBar selectedItem 설정
        collectionview.isScrollEnabled = false
        let indexPath = IndexPath(item: 0, section: 0)
        collectionview.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    private func setupCustomTabBar(){
        collectionview.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.top.equalToSuperview()
        }
    }
    private func setupDataSource(){
        //presentation
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionview, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabBarCell.reusedId, for: indexPath) as? CustomTabBarCell else { return UICollectionViewCell()}
            cell.config(item as! CustomTabBarItem, isSelected: indexPath.item == self.defaultIndex)
            return cell
        })
    }
    private func reloadData(){
        //data
        var snapShot = NSDiffableDataSourceSnapshot<Section,Item>()
        defer{
            dataSource.apply(snapShot,animatingDifferences: true)
        }
        snapShot.appendSections([.main])
        snapShot.appendItems(titleList,toSection: .main)
    }
    private func layout() -> UICollectionViewCompositionalLayout{
        //layout
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(82)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension:.absolute(104)), subitem: item, count: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
extension CustomTabBarView : UICollectionViewDelegate{
    // 셀을 클릭했을 때, 콘텐츠 뷰를 해당 index로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //눌렀을 때 글씨색 변화
        defaultIndex = indexPath.item
        delegate?.scrollToIndex(to: indexPath.item)
        collectionview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
}

