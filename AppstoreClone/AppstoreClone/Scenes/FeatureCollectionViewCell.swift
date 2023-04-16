//
//  FeatureCollectionViewCell.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/13.
//
import SnapKit

import UIKit

final class FeatureCollectionViewCell: UICollectionViewCell{
    private let imageCache = NSCache<NSString, UIImage>()
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
        if let cachedImage = imageCache.object(forKey: feature.imageURL as NSString){
            self.imageView.image = cachedImage
        }else{
            self.fetchImage(feature.imageURL)
        }
    }
}
extension FeatureCollectionViewCell{
    func fetchImage(_ url: String){
        guard let url = URL(string: url) else {return}
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                fatalError(error.localizedDescription)
            }
            
            guard let data = data, let image = self.downsample(imageAt: data, to: CGSize(width: 300, height: 300)) else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }
        self.task.resume()
    }
    
    func downsample(imageAt imageData: Data, to pointSize: CGSize) -> UIImage? {
        // 이미지 속성을 가져옵니다.
        let options = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithData(imageData as CFData, options) else {
            return nil
        }
        // 다운샘플링할 이미지의 최대 크기를 픽셀로 계산합니다.
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * UIScreen.main.scale
        // 다운샘플링 옵션을 설정합니다.
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        // 이미지를 다운샘플링합니다.
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions) else {
            return nil
        }
        // 다운샘플링된 이미지를 UIImage로 변환합니다.
        return UIImage(cgImage: downsampledImage)
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
}
