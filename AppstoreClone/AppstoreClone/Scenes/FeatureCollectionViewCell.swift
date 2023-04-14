//
//  FeatureCollectionViewCell.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/13.
//
import SnapKit

import UIKit

final class FeatureCollectionViewCell: UICollectionViewCell{
    
    private var task: URLSessionDataTask!
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemBlue
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        return imageView
    }()
    
    func setup(_ feature: Feature){
        self.configureUI()
        
        self.subTitleLabel.text = feature.type
        self.titleLabel.text = feature.appName
        self.descriptionLabel.text = feature.description
        self.fetchImage(feature.imageURL)
    }
}
private extension FeatureCollectionViewCell{
    func configureUI(){
        [subTitleLabel, titleLabel, descriptionLabel, imageView].forEach{
            addSubview($0)
        }
        self.subTitleLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints{
            $0.top.equalTo(self.subTitleLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(self.titleLabel.snp.bottom).inset(4)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        self.imageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    func fetchImage(_ url: String){
        guard let url = URL(string: url) else {return}
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                fatalError(error.localizedDescription)
            }
            
            guard let data = data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }
        self.task.resume()
    }
}
