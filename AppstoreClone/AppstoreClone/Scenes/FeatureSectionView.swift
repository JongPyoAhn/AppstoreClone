//
//  FeatureSectionView.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/13.
//
import SnapKit

import UIKit

protocol FeatureSectionViewDelegate: AnyObject {
    func presentUI(_ feature: Feature)
}

final class FeatureSectionView: UIView{
     
    weak var delegate: FeatureSectionViewDelegate?
    
    private var featureList: [Feature] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: "FeatureCollectionViewCell")
        return collectionView
    }()
    
    private let separatorView = SeparatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.fetchData()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        [
            collectionView, separatorView
        ].forEach{
            addSubview($0)
        }
        
        self.collectionView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(snp.width)
            $0.bottom.equalToSuperview()
        }
        self.separatorView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(self.collectionView.snp.bottom).offset(16)
        }
    }
}
extension FeatureSectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as? FeatureCollectionViewCell else {return UICollectionViewCell()}
        cell.setup(self.featureList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.featureList.count
    }
}
extension FeatureSectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width - 32, height: frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        32.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.presentUI(self.featureList[indexPath.item])
        
    }
    
}
extension FeatureSectionView{
    func fetchData(){
        guard let url = Bundle.main.url(forResource: "Feature", withExtension: "plist") else {return}
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Feature].self, from: data)
            self.featureList = result
        }catch(let err){
            fatalError(err.localizedDescription)
        }
    }
}
    

