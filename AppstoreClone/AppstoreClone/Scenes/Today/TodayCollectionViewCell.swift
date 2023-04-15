//
//  TodayCollectionViewCell.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/12.
//

import SnapKit

import UIKit

final class TodayCollectionViewCell: UICollectionViewCell{
    private var task: URLSessionDataTask!
    private let imageCache = NSCache<NSString, UIImage>()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup(today: Today) {
        configureUI()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
        
        self.subTitleLabel.text = today.subTitle
        self.descriptionLabel.text = today.description
        self.titleLabel.text = today.title
        if let cachedImage = imageCache.object(forKey: today.imageURL as NSString){
            self.imageView.image = cachedImage
            print("들어옴")
        }else{
            self.fetchImage(today.imageURL)
        }
    }
    
    func fetchImage(_ url: String){
        guard let url = URL(string: url) else {return}
        let urlRequest = URLRequest(url: url)
        self.task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error{
                fatalError(error.localizedDescription)
            }
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: "\(url)" as NSString)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        self.task.resume()
    }
}
private extension TodayCollectionViewCell{
    func configureUI(){
        [imageView, titleLabel, subTitleLabel, descriptionLabel].forEach{ addSubview($0)}
        
        self.subTitleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(24)
        }
        
        self.titleLabel.snp.makeConstraints{
            $0.leading.equalTo(subTitleLabel)
            $0.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(4)
        }
        
        self.descriptionLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-24)
        }
        self.imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
}
