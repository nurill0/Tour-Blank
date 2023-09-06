//
//  MenuVC.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 26/08/23.
//

import UIKit

class MenuVC: BaseVC {
    
    lazy var menuBgImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "menu")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var mapBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "map"), for: .normal)
        btn.backgroundColor = .clear
        btn.tag = 1
        btn.addTarget(self, action: #selector(goPages(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var tripPlanBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "tripPlan"), for: .normal)
        btn.backgroundColor = .clear
        btn.tag = 2
        btn.addTarget(self, action: #selector(goPages(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var placesBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "places"), for: .normal)
        btn.backgroundColor = .clear
        btn.tag = 3
        btn.addTarget(self, action: #selector(goPages(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuUI()
    }
    
    
}



extension MenuVC {
    
    @objc func goPages(sender: UIButton){
        var vc = UIViewController()
        switch sender.tag {
        case 1: vc = MapVC()
        case 2: vc = TripPlanVC()
        case 3: vc = PlacesVC()
        default: vc = UIViewController()
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
       present(vc, animated: true)
    }
}



extension MenuVC {
    
    fileprivate func setUpMenuUI(){
        menuBgImageConst()
        mapBtnConst()
        tripPlanBtnConst()
        placesBtnConst()
    }
    
    
    fileprivate func menuBgImageConst(){
        view.addSubview(menuBgImage)
        menuBgImage.top(view.safeAreaLayoutGuide.topAnchor)
        menuBgImage.bottom(view.safeAreaLayoutGuide.bottomAnchor)
        menuBgImage.right(view.rightAnchor)
        menuBgImage.left(view.leftAnchor)
    }
    
    
    fileprivate func mapBtnConst(){
        view.addSubview(mapBtn)
        mapBtn.bottom(menuBgImage.centerYAnchor, -90)
        mapBtn.left(menuBgImage.leftAnchor, 20)
        mapBtn.height(110)
        mapBtn.width(110)
    }
    
    
    fileprivate func tripPlanBtnConst(){
        view.addSubview(tripPlanBtn)
        tripPlanBtn.bottom(mapBtn.topAnchor, 10)
        tripPlanBtn.left(mapBtn.rightAnchor, 20)
        tripPlanBtn.height(110)
        tripPlanBtn.width(110)
    }
    
    
    fileprivate func placesBtnConst(){
        view.addSubview(placesBtn)
        placesBtn.bottom(menuBgImage.centerYAnchor, -100)
        placesBtn.right(menuBgImage.rightAnchor, -20)
        placesBtn.height(110)
        placesBtn.width(110)
    }
    
    
}
