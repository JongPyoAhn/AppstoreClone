//
//  RankingFeatureSectionCollectionViewCell.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/13.
//
import SnapKit

import UIKit
final class RankingFeatureSectionCollectionViewCell: UICollectionViewCell{
    static var height: CGFloat {70.0}
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor.secondaryLabel
        return label
    }()
    private lazy var receiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 12
        return button
    }()
    private lazy var inAppPurchaseInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = UIColor.secondaryLabel
        label.text = "앱 내 구입"
        return label
    }()
    func setup(_ rankingFeature: RankingFeature){
        configureUI()
        
        titleLabel.text = rankingFeature.title
        descriptionLabel.text = rankingFeature.description
        inAppPurchaseInfoLabel.isHidden = !rankingFeature.isInPurchaseApp
    }
    
}
private extension RankingFeatureSectionCollectionViewCell{
    func configureUI(){
        [imageView, titleLabel, descriptionLabel, receiveButton, inAppPurchaseInfoLabel].forEach{
            addSubview($0)
        }
        
        self.imageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(self.imageView.snp.height)
        }
        self.receiveButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(50)
        }
        self.inAppPurchaseInfoLabel.snp.makeConstraints{
            $0.centerX.equalTo(self.receiveButton.snp.centerX)

            $0.top.equalTo(self.receiveButton.snp.bottom)
        }
        self.titleLabel.snp.makeConstraints{
            
            $0.leading.equalTo(self.imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(self.receiveButton.snp.leading)
            $0.top.equalTo(self.imageView.snp.top).inset(8)
        }
        self.descriptionLabel.snp.makeConstraints{
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4)
        }

    }
}

