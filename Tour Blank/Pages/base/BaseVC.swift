//
//  ViewController.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 26/08/23.
//

import UIKit

class BaseVC: UIViewController {
    
    lazy var bgImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "bgImage")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


    
}



extension BaseVC {
    
    fileprivate func setupUI(){
        bgImageConst()
    }
    
    fileprivate func bgImageConst(){
        view.addSubview(bgImage)
        bgImage.top(view.topAnchor)
        bgImage.bottom(view.bottomAnchor)
        bgImage.right(view.rightAnchor)
        bgImage.left(view.leftAnchor)
    }
    
}
