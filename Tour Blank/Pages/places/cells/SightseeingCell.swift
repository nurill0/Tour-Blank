//
//  SightseeingCell.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 05/09/23.
//

import UIKit
import Cosmos

class SightseeingCell: UICollectionViewCell {
    static let id = "sightseeingcell"
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        return view
    }()
    
    lazy var sightseeingImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "addSightForPlaces")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var pictureImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "addSightForPlaces")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var cosmosView: CosmosView = {
        let cosmos = CosmosView()
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        cosmos.settings.totalStars = 5
        cosmos.settings.starSize = 20
        cosmos.settings.fillMode = .half
        cosmos.settings.updateOnTouch = false
        
        return cosmos
    }()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Statue of Liberty"
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Kanit-SemiBold", size: 18)
        
        
        return lbl
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "delete"), for: .normal)
        btn.backgroundColor = .clear
                btn.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    var imgurl = ""
    var userD = UserDefaultsManager.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
      
    }
    
    
    func initItems(imgUrl: String, title: String, rateCount: Double){
        titleLbl.text = title
        cosmosView.rating = rateCount
        
        ImageDownloader.downloadImage(imgUrl) { [self]
            image, urlString in
            imgurl = urlString ?? ""
            if let imageObject = image {
                // performing UI operation on main thread
                DispatchQueue.main.async {
                    self.pictureImage.image = imageObject
                }
            }
        }
    }
    
    @objc func deleteData(){
        savedSightsee.remove(object: titleLbl.text!)
        savedRates.remove(object: cosmosView.rating)
        savedImages.remove(object: imgurl)
        userD.saveSightSee(items: savedSightsee)
        userD.saveRateAmount(items: savedRates)
        userD.saveImages(items: savedImages)
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



extension SightseeingCell{
    
    fileprivate func setupUI(){
        containerViewConst()
        frameImgConst()
        pictureimgConst()
        titleLblConst()
        rateLblConst()
        deleteBtnConst()
    }
    
    fileprivate func containerViewConst(){
        self.addSubview(containerView)
        containerView.top(self.topAnchor)
        containerView.bottom(self.bottomAnchor)
        containerView.right(self.rightAnchor)
        containerView.left(self.leftAnchor)
    }
    
    
    fileprivate func frameImgConst(){
        self.addSubview(sightseeingImage)
        sightseeingImage.centerX(containerView.centerXAnchor)
        sightseeingImage.centerY(containerView.centerYAnchor)
    }
    
    fileprivate func pictureimgConst(){
        self.addSubview(pictureImage)
        pictureImage.top(containerView.topAnchor, 90)
        pictureImage.centerX(containerView.centerXAnchor)
        pictureImage.height(110)
        pictureImage.width(200)
    }
    
    
    fileprivate func titleLblConst(){
        sightseeingImage.addSubview(titleLbl)
        titleLbl.top(pictureImage.bottomAnchor)
        titleLbl.right(containerView.rightAnchor)
        titleLbl.left(containerView.leftAnchor)
    }
    
    fileprivate func rateLblConst(){
        sightseeingImage.addSubview(cosmosView)
        cosmosView.top(titleLbl.bottomAnchor)
        cosmosView.centerX(containerView.centerXAnchor)
    }
    
    fileprivate func deleteBtnConst(){
        self.addSubview(deleteBtn)
        deleteBtn.bottom(sightseeingImage.bottomAnchor,20)
        deleteBtn.left(containerView.leftAnchor, 20)
        deleteBtn.height(60)
        deleteBtn.width(60)
    }
    
}
