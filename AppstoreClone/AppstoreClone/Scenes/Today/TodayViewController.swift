//
//  TodayViewController.swift
//  AppstoreClone
//
//  Created by 안종표 on 2023/04/12.
//
import SnapKit
import UIKit
final class TodayViewController: UIViewController{
    
    private var todayList: [Today] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        collectionView.register(TodayCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "TodayCollectionHeaderView")
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }
    func configureUI(){
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}



extension TodayViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as? TodayCollectionViewCell
        let today = self.todayList[indexPath.item]
        cell?.setup(today: today)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.todayList.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TodayCollectionHeaderView", for: indexPath) as? TodayCollectionHeaderView
        else {return UICollectionReusableView()}
        header.configureUI()
        return header
    }

}

extension TodayViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width - 32.0
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32.0, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 16
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let today = todayList[indexPath.item]
        let vc = AppDetailViewController(today: today)
        self.present(vc, animated: true)
    }
}

private extension TodayViewController{
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "Today", withExtension: "plist")else{ return }
        do{
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([Today].self, from: data)
            todayList = result
        }catch{
            fatalError()
        }
    }
}
