//
//  MissionCollectionViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/04.
//

import UIKit

import SnapKit
import Then

class MissionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    static var identifier = "MissionCollectionViewCell"

    // MARK: - UI Components
    
    private var label = CustomAchieveLabel(color: .nottodoBlack!, font: .PretendardSemiBold(size: 14))
    var image = UIImageView()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension MissionCollectionViewCell {
    private func setUI() {
        backgroundColor = .clear
        
        image.do {
            $0.image = UIImage.rank1
        }
    }
    
    private func setLayout() {
        addSubview(image)
        image.addSubview(label)
        
        image.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(41)
        }
    }
    
    func config(_ item: MissionList) {
        label.text = item.title
    }
}