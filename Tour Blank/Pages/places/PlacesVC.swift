//
//  PlacesVC.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 26/08/23.
//

import UIKit
import Cosmos

class PlacesVC: BaseVC {

    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var bottomPanelImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "bottomPanelPlaces")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    
    lazy var tripFrameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.appGreenColor().cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 32
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var topFrameImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "topframe")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.masksToBounds = true
    
        return img
    }()
    
    lazy var newBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("new", for: .normal)
        btn.setTitleColor(.titleLblColor(), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .clear
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        btn.addTarget(self, action: #selector(changeNewToRatedRatedToNew(sender: )), for: .touchUpInside)
        btn.tag = 1
        
        return btn
    }()
    
    lazy var ratedBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("rated", for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(.titleLblColor().withAlphaComponent(0.4), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(changeNewToRatedRatedToNew(sender: )), for: .touchUpInside)
        btn.tag = 2
        
        return btn
    }()

    lazy var sightseeingImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "a")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
//    lazy var landMarkImageview: UIImageView = {
//        let img = UIImageView()
//        img.translatesAutoresizingMaskIntoConstraints = false
//        img.image = UIImage(named: "b")
//        img.contentMode = .scaleAspectFit
//
//        return img
//    }()
    
    lazy var addSighseeingBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addBtn"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(createSightseeing), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var addLandmarkBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addBtn"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(createSightseeing), for: .touchUpInside)

        return btn
    }()
    
    lazy var firstCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SightseeingCell.self, forCellWithReuseIdentifier: SightseeingCell.id)
        collectionView.isHidden = true
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    
    var userD = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("datasss: \(userD.loadImages())")
        setUpPlacesUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstCollectionView.reloadData()
    }
    

}


extension PlacesVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userD.loadSightSee().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SightseeingCell.id, for: indexPath) as! SightseeingCell
        cell.initItems(imgUrl: userD.loadImages()[indexPath.item], title: userD.loadSightSee()[indexPath.item], rateCount: userD.loadRateAmount()[indexPath.item])
        cell.collectionView = self.firstCollectionView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
}



extension PlacesVC {
    
    @objc func goBack(){
        dismiss(animated: true)
    }
    
    @objc func createSightseeing(sender: UIButton){
        let vc = CreateLandMarkVC()
        switch sender.tag {
        case 1: vc.pageType = "sight"
        case 2: vc.pageType = "landmark"
        default: print("")
        }
       
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func changeNewToRatedRatedToNew(sender: UIButton){
        switch sender.tag {
        case 1:
            newBtn.setTitleColor(.titleLblColor(), for: .normal)
            ratedBtn.setTitleColor(.titleLblColor().withAlphaComponent(0.6), for: .normal)
            sightseeingImage.isHidden = false
            addSighseeingBtn.isHidden = false
            addLandmarkBtn.isHidden = false
            firstCollectionView.isHidden = true
        case 2:
            ratedBtn.setTitleColor(.titleLblColor(), for: .normal)
            newBtn.setTitleColor(.titleLblColor().withAlphaComponent(0.6), for: .normal)
            sightseeingImage.isHidden = true
            addSighseeingBtn.isHidden = true
            addLandmarkBtn.isHidden = true
            firstCollectionView.isHidden = false

        default: print("error")
        }
    }
}



extension PlacesVC {
    
    fileprivate func setUpPlacesUI(){
        backBtnConst()
        bottomPanelImgConst()
        tripFrameImgConst()
        topFrameImgConst()
        newBtnConst()
        ratedBtnConst()
        sightSeeingImgConst()
//        planSightSeeingImgConst()
        addSightseeingBtnConst()
//        addLandmarkBtnConst()
        firscollectionViewConst()    }

    
    fileprivate func backBtnConst(){
        view.addSubview(backBtn)
        backBtn.top(view.safeAreaLayoutGuide.topAnchor, 20)
        backBtn.left(view.leftAnchor, 20)
        backBtn.height(50)
        backBtn.width(50)
    }
    
    
    fileprivate func bottomPanelImgConst(){
        view.addSubview(bottomPanelImage)
        bottomPanelImage.right(view.rightAnchor, -20)
        bottomPanelImage.left(view.leftAnchor, 20)
        bottomPanelImage.bottom(view.safeAreaLayoutGuide.bottomAnchor, -10)
        bottomPanelImage.height(60)
    }
    
    
    fileprivate func  tripFrameImgConst(){
        view.addSubview(tripFrameView)
        tripFrameView.bottom(bottomPanelImage.topAnchor, -20)
        tripFrameView.right(view.rightAnchor, -30)
        tripFrameView.left(view.leftAnchor, 30)
        tripFrameView.top(backBtn.bottomAnchor, 20)
    }
    
    
    fileprivate func topFrameImgConst(){
        tripFrameView.addSubview(topFrameImage)
        topFrameImage.top(tripFrameView.topAnchor)
        topFrameImage.left(tripFrameView.leftAnchor)
        topFrameImage.right(tripFrameView.rightAnchor)
        topFrameImage.height(70)
    }
    
    fileprivate func newBtnConst(){
        view.addSubview(newBtn)
        newBtn.centerY(topFrameImage.centerYAnchor)
        newBtn.left(topFrameImage.leftAnchor)
        newBtn.right(topFrameImage.centerXAnchor)
    }
    
    fileprivate func ratedBtnConst(){
        view.addSubview(ratedBtn)
        ratedBtn.centerY(topFrameImage.centerYAnchor)
        ratedBtn.right(topFrameImage.rightAnchor)
        ratedBtn.left(topFrameImage.centerXAnchor)
    }
    
    fileprivate func sightSeeingImgConst(){
        tripFrameView.addSubview(sightseeingImage)
        sightseeingImage.centerY(tripFrameView.centerYAnchor)
        sightseeingImage.centerX(tripFrameView.centerXAnchor)
        sightseeingImage.right(tripFrameView.rightAnchor, -10)
        sightseeingImage.left(tripFrameView.leftAnchor, 10)
        sightseeingImage.height(240)
    }
    
//    fileprivate func planSightSeeingImgConst(){
//        tripFrameView.addSubview(landMarkImageview)
//        landMarkImageview.top(sightseeingImage.bottomAnchor, 30)
//        landMarkImageview.centerX(tripFrameView.centerXAnchor)
//        landMarkImageview.width(180)
//        landMarkImageview.height(160)
//    }
    
    
    fileprivate func addSightseeingBtnConst(){
        view.addSubview(addSighseeingBtn)
        addSighseeingBtn.centerY(sightseeingImage.centerYAnchor)
        addSighseeingBtn.centerX(sightseeingImage.centerXAnchor)
        addSighseeingBtn.height(50)
        addSighseeingBtn.width(50)
    }
    
    fileprivate func firscollectionViewConst(){
        view.addSubview(firstCollectionView)
 
        firstCollectionView.width(320)
        firstCollectionView.height(290)
        firstCollectionView.centerY(tripFrameView.centerYAnchor)
        firstCollectionView.centerX(tripFrameView.centerXAnchor)
    }
    
//    fileprivate func addLandmarkBtnConst(){
//        view.addSubview(addLandmarkBtn)
//        addLandmarkBtn.top(landMarkImageview.topAnchor, 25)
//        addLandmarkBtn.centerX(landMarkImageview.centerXAnchor)
//        addLandmarkBtn.height(50)
//        addLandmarkBtn.width(50)
//    }
}

