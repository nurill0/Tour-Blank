//
//  TimeTableCell.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 04/09/23.
//

import UIKit

class TimeTableCell: UITableViewCell {
    
    static let identifer = "timetablecell"
    
    lazy var titleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = #colorLiteral(red: 0.2018019557, green: 0.4367944896, blue: 0.6234596372, alpha: 1)
        
        return v
    }()
    
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "12.07 / 14:00"
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = UIFont(name: "Kanit-Medium", size: 14)
        
        return lbl
    }()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Go to a restaurant downtown"
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = UIFont(name: "Kanit-Regular", size: 14)
        
        return lbl
    }()
    
    let userD = UserDefaultsManager.shared
    
    
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
    
    
}



//MARK: UI
extension TimeTableCell {
    
    fileprivate func configureUI(){
        timeLblConst()
        titleViewConst()
        titleLblConst()
    }
    
    fileprivate func timeLblConst(){
        self.addSubview(timeLbl)
        timeLbl.left(self.leftAnchor, 5)
        timeLbl.centerY(self.centerYAnchor)
    }
    
    
    fileprivate func titleViewConst(){
        self.addSubview(titleView)
        titleView.left(self.centerXAnchor, -50)
        titleView.centerY(self.centerYAnchor)
        titleView.height(25)
    }
    
    fileprivate func titleLblConst(){
        titleView.addSubview(titleLbl)
        titleLbl.top(titleView.topAnchor)
        titleLbl.bottom(titleView.bottomAnchor)
        titleLbl.left(titleView.leftAnchor, 15)
        titleLbl.right(titleView.rightAnchor, -15)
    }
    
    
}
