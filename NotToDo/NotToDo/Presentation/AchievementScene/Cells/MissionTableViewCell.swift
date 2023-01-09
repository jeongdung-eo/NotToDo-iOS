//
//  MissionTableViewCell.swift
//  NotToDo
//
//  Created by JEONGEUN KIM on 2023/01/09.
//

import UIKit

class MissionTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    static var identifier = "MissionTableViewCell"

    // MARK: - UI Components
    
    private var label = CustomAchieveLabel(color: .nottodoBlack!, font: .PretendardSemiBold(size: 14))
    var missionImage = UIImageView()
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    override func layoutSubviews() {
      super.layoutSubviews()
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension MissionTableViewCell {
    private func setUI() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10.0, left: 0, bottom: 0, right: 0))
        backgroundColor = .clear
        missionImage.do {
            $0.image = UIImage.rank1
        }
    }
    
    private func setLayout() {
        contentView.addSubview(missionImage)
        missionImage.addSubview(label)
        
        missionImage.snp.makeConstraints {
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