//
//  FeedbacksCell.swift
//  Gym Team Fit
//
//  Created by Nurillo Domlajonov on 09/08/23.
//

import UIKit

class PlanCell: UITableViewCell {
    
    static let identifer = "plancell"
    
    lazy var containerV: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        
        return v
    }()
    
    
    lazy var countryLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Russia"
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = UIFont(name: "Kanit-Regular", size: 20)
        
        return lbl
    }()
    
    
    lazy var cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Moscow, Tula"
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = UIFont(name: "Kanit-Regular", size: 20)
        
        return lbl
    }()
    
    
    lazy var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "12.07.23-30.07.23"
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = UIFont(name: "Kanit-Regular", size: 20)
        
        return lbl
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "delete"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(deleteTripPlan), for: .touchUpInside)
        
        return btn
    }()
    
    let userD = UserDefaultsManager.shared
    var tabView = UITableView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
        self.backgroundColor = .clear
    }
    
    @objc func deleteTripPlan(){
        savedCountry.remove(object: countryLabel.text!)
        savedCities.remove(object: cityLabel.text!)
        savedDate.remove(object: dateLabel.text!)
        userD.saveCountry(items: savedCountry)
        userD.saveCities(items: savedCities)
        userD.saveDate(items: savedDate)
        tabView.reloadData()
    }
    
}



//MARK: UI
extension PlanCell {
    
    fileprivate func configureUI(){
        containerVCOnst()
        countryLblConst()
        citiesLblConst()
        dateLblConst()
        deleteBtnConst()
    }
    
    
    fileprivate func containerVCOnst(){
        contentView.addSubview(containerV)
        containerV.top(contentView.topAnchor, 10)
        containerV.left(contentView.leftAnchor)
        containerV.right(contentView.rightAnchor)
        containerV.bottom(contentView.bottomAnchor, -10)
    }
 
    
    
    fileprivate func countryLblConst(){
        containerV.addSubview(countryLabel)
        countryLabel.top(containerV.topAnchor, 10)
        countryLabel.left(containerV.leftAnchor, 10)
    }
    
    fileprivate func citiesLblConst(){
        containerV.addSubview(cityLabel)
        cityLabel.top(countryLabel.bottomAnchor)
        cityLabel.left(countryLabel.leftAnchor)
    }

    fileprivate func dateLblConst(){
        containerV.addSubview(dateLabel)
        dateLabel.top(cityLabel.bottomAnchor)
        dateLabel.left(countryLabel.leftAnchor)
        dateLabel.bottom(containerV.bottomAnchor, -10)
    }
  
    fileprivate func deleteBtnConst(){
        containerV.addSubview(deleteBtn)
        deleteBtn.centerY(countryLabel.centerYAnchor)
        deleteBtn.right(containerV.rightAnchor, -10)
        deleteBtn.height(40)
        deleteBtn.width(40)
    }
}
