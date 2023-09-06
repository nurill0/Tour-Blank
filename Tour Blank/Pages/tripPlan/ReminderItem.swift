//
//  ReminderItem.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 04/09/23.
//

import Foundation
import UIKit


class ReminderItem: UIView {
    
    var selected = false
    
    lazy var selectedBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "unselected"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(checkSelect), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: "Kanit-Regular", size: 14)
        tf.textAlignment = .left
        tf.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -10, y: -10, width: -10, height: -10))
        tf.textColor = .white
        tf.returnKeyType = .done
        tf.delegate = self
        
        return tf
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "cancelBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var lineImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "line")
        img.contentMode = .scaleAspectFit
        img.isHidden = true
        
        return img
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        check()
        configureUI()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        check()
    }
    
    
    convenience init(text: String) {
        self.init(frame: .zero)
        textField.text = text
        check()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension ReminderItem: UITextFieldDelegate {
    
    
    func check(){
        if textField.text?.isEmpty == false  {
            cancelBtn.isHidden = false
        }else{
            cancelBtn.isHidden = true
        }
    }
    
    
    @objc func cancelAction(){
        selectedBtn.setImage(UIImage(named: "unselected"), for: .normal)
        lineImgView.isHidden = true
        textField.text = ""
        textField.isUserInteractionEnabled = true
        cancelBtn.isHidden = true
    }
    
    
    @objc func checkSelect(){
        if textField.text?.isEmpty == false {
            if selected {
                selectedBtn.setImage(UIImage(named: "unselected"), for: .normal)
                lineImgView.isHidden = true
                textField.isUserInteractionEnabled = true
            }else{
                selectedBtn.setImage(UIImage(named: "selected"), for: .normal)
                lineImgView.isHidden = false
                textField.isUserInteractionEnabled = false
            }
            selected.toggle()
        }else{
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        check()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        check()
        return true
    }
    
}


extension ReminderItem {
    
    fileprivate func configureUI(){
        self.translatesAutoresizingMaskIntoConstraints = false
        selectBtnConst()
        cancelBtnConst()
        textFieldConst()
        lineImgConst()
    }
    
    
    fileprivate func selectBtnConst(){
        self.addSubview(selectedBtn)
        selectedBtn.left(self.leftAnchor, 10)
        selectedBtn.centerY(self.centerYAnchor)
        selectedBtn.height(35)
        selectedBtn.width(35)
    }
    
    
    fileprivate func cancelBtnConst(){
        self.addSubview(cancelBtn)
        cancelBtn.right(self.rightAnchor, -10)
        cancelBtn.centerY(self.centerYAnchor)
        cancelBtn.height(20)
        cancelBtn.width(20)
    }
    
    
    fileprivate func textFieldConst(){
        self.addSubview(textField)
        textField.left(selectedBtn.rightAnchor, 10)
        textField.right(cancelBtn.leftAnchor, -10)
        textField.height(40)
        textField.centerY(self.centerYAnchor)
    }
    
    
    fileprivate func lineImgConst(){
        self.addSubview(lineImgView)
        lineImgView.centerY(textField.centerYAnchor)
        lineImgView.left(textField.leftAnchor, 5)
        lineImgView.right(textField.rightAnchor, -5)
    }
    
}
