//
//  TripPlanVC.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 26/08/23.
//

import UIKit

var savedCountry = [String]()
var savedCities = [String]()
var savedDate = [String]()


class TripPlanVC: BaseVC {
    
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var topFrameImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "topframe")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 32
        img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return img
    }()
    
    lazy var frameImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "tripframe")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var bottomPanelImgV: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "bottomPanelTripPlan")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "saveBtn"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(saveInformations), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var tripBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("trip", for: .normal)
        btn.setTitleColor(.titleLblColor().withAlphaComponent(0.4), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .clear
        btn.tag = 2
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        btn.addTarget(self, action: #selector(changeTripToPlanPlanToTrip(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var planBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("plan", for: .normal)
        btn.tag = 1
        btn.backgroundColor = .clear
        btn.setTitleColor(.titleLblColor(), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(changeTripToPlanPlanToTrip(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var countryTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(
            string: "Country of visit",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        tf.textAlignment = .center
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -20, y: -20, width: -20, height: -20))
        tf.textColor = .white
        
        return tf
    }()
    
    lazy var cityTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(
            string: "Cities of visit",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        tf.textAlignment = .center
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -20, y: -20, width: -20, height: -20))
        tf.textColor = .white
        
        return tf
    }()
    
    lazy var dateTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(
            string: "Date of visit",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.textAlignment = .center
        tf.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -20, y: -20, width: -20, height: -20))
        tf.textColor = .white
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.adjustsFontSizeToFitWidth = true
        
        return tf
    }()
    
    lazy var plansTableView: UITableView = {
        let tbV = UITableView()
        tbV.translatesAutoresizingMaskIntoConstraints = false
        tbV.autoresizesSubviews = true
        tbV.register(PlanCell.self, forCellReuseIdentifier: PlanCell.identifer)
        tbV.delegate = self
        tbV.dataSource = self
        tbV.separatorStyle = .none
        tbV.rowHeight = UITableView.automaticDimension
        tbV.backgroundColor = .clear
        tbV.showsVerticalScrollIndicator = false
        
        return tbV
    }()
    
    
    let userD = UserDefaultsManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plansTableView.isHidden = true
        frameImage.isHidden = false
        countryTF.isHidden = false
        cityTF.isHidden = false
        dateTF.isHidden = false
        setupTripPlanUI()
    }
    
}




//MARK: actions
extension TripPlanVC {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func goBack(){
        dismiss(animated: true)
    }
    
    
    @objc func saveInformations(){
        guard let country = countryTF.text else {return}
        guard let city = cityTF.text else {return}
        guard let date = dateTF.text else {return}
        if !country.isEmpty && !city.isEmpty && !date.isEmpty {
            savedCountry.append(country)
            savedCities.append(city)
            savedDate.append(date)
            userD.saveCountry(items: savedCountry)
            userD.saveCities(items: savedCities)
            userD.saveDate(items: savedDate)
            plansTableView.reloadData()
            showInfoAlert()
        }
    }
    
    
    @objc func changeTripToPlanPlanToTrip(sender: UIButton){
        switch sender.tag {
        case 1:
            planBtn.setTitleColor(.titleLblColor(), for: .normal)
            tripBtn.setTitleColor(.titleLblColor().withAlphaComponent(0.6), for: .normal)
            plansTableView.isHidden = true
            frameImage.isHidden = false
            countryTF.isHidden = false
            cityTF.isHidden = false
            dateTF.isHidden = false
            saveBtn.isHidden = false
        case 2:
            tripBtn.setTitleColor(.titleLblColor(), for: .normal)
            planBtn.setTitleColor(.titleLblColor().withAlphaComponent(0.6), for: .normal)
            plansTableView.isHidden = false
            saveBtn.isHidden = true
            frameImage.isHidden = true
            countryTF.isHidden = true
            cityTF.isHidden = true
            dateTF.isHidden = true
        default: print("error")
        }
    }
    
    
    func showInfoAlert(){
        var alert = UIAlertController()
        alert = UIAlertController(title: "Saved", message: "Your plans added your trip plans list", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [self] action in
            countryTF.becomeFirstResponder()
            countryTF.text = ""
            cityTF.text = ""
            dateTF.text = ""
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}



//MARK: Delegates
extension TripPlanVC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let newLength = text.count
        if textField == dateTF {
            switch newLength {
            case 3: dateTF.text?.append(".")
            case 6: dateTF.text?.append(".")
            case 9: dateTF.text?.append("-")
            case 12: dateTF.text?.append(".")
            case 15: dateTF.text?.append(".")
            case 18: dateTF.isUserInteractionEnabled = false
            default:  print("nothing")
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userD.loadCountry().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlanCell.identifer, for: indexPath) as! PlanCell
        cell.countryLabel.text = userD.loadCountry()[indexPath.row]
        cell.cityLabel.text = userD.loadCities()[indexPath.row]
        cell.dateLabel.text = userD.loadDate()[indexPath.row]
        cell.tabView = plansTableView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TripPlanDescripVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.countryTF.text = userD.loadCountry()[indexPath.row]
        vc.cityTF.text = userD.loadCities()[indexPath.row]
        vc.dateTF.text = userD.loadDate()[indexPath.row]
        present(vc, animated: true)
    }
    
}



//MARK: UI
extension TripPlanVC {
    
    fileprivate func setupTripPlanUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        topFrameImage.addGestureRecognizer(tap)
        frameImage.isUserInteractionEnabled = true
        frameImage.addGestureRecognizer(tap)
        savedCountry = userD.loadCountry()
        savedCities = userD.loadCities()
        savedDate = userD.loadDate()
        bottomPanelImgConst()
        backBtnConst()
        topFrameImgConst()
        tripFrameConst()
        saveBtnConst()
        tripBtnConst()
        planBtnConst()
        countryTFConst()
        citesTFConst()
        dateTFConst()
        plansTableVConst()
    }
    
    
    fileprivate func backBtnConst(){
        view.addSubview(backBtn)
        backBtn.top(view.safeAreaLayoutGuide.topAnchor, 20)
        backBtn.left(view.leftAnchor, 20)
        backBtn.height(50)
        backBtn.width(50)
    }
    
    
    fileprivate func topFrameImgConst(){
        view.addSubview(topFrameImage)
        topFrameImage.top(backBtn.bottomAnchor, 20)
        topFrameImage.right(view.rightAnchor, -30)
        topFrameImage.left(view.leftAnchor, 30)
        topFrameImage.height(70)
    }
    
    
    fileprivate func tripFrameConst(){
        view.addSubview(frameImage)
        frameImage.top(topFrameImage.bottomAnchor, 20)
        frameImage.centerX(topFrameImage.centerXAnchor)
        if view.frame.height > 670 {
            frameImage.height(400)
        }else{
            frameImage.height(320)
        }
    }
    
    
    fileprivate func bottomPanelImgConst(){
        view.addSubview(bottomPanelImgV)
        bottomPanelImgV.right(view.rightAnchor, -20)
        bottomPanelImgV.left(view.leftAnchor, 20)
        bottomPanelImgV.bottom(view.safeAreaLayoutGuide.bottomAnchor, -10)
        bottomPanelImgV.height(60)
    }
    
    
    fileprivate func saveBtnConst(){
        view.addSubview(saveBtn)
        saveBtn.bottom(bottomPanelImgV.topAnchor, -10)
        saveBtn.centerX(view.centerXAnchor)
        saveBtn.height(40)
        saveBtn.width(100)
    }
    
    
    fileprivate func planBtnConst(){
        view.addSubview(planBtn)
        planBtn.centerY(topFrameImage.centerYAnchor)
        planBtn.left(topFrameImage.leftAnchor)
        planBtn.right(topFrameImage.centerXAnchor)
    }
    
    
    fileprivate func tripBtnConst(){
        view.addSubview(tripBtn)
        tripBtn.centerY(topFrameImage.centerYAnchor)
        tripBtn.right(topFrameImage.rightAnchor)
        tripBtn.left(topFrameImage.centerXAnchor)
    }
    
    
    fileprivate func countryTFConst(){
        view.addSubview(countryTF)
        if view.frame.height > 670 {
            countryTF.top(frameImage.topAnchor, 100)
            countryTF.width(220)
        }else{
            countryTF.top(frameImage.topAnchor, 70)
            countryTF.width(200)
        }
        countryTF.centerX(frameImage.centerXAnchor)
        countryTF.height(50)
    }
    
    
    fileprivate func citesTFConst(){
        view.addSubview(cityTF)
        if view.frame.height > 670 {
            cityTF.top(countryTF.bottomAnchor, 10)
            cityTF.width(220)
        }else{
            cityTF.top(countryTF.bottomAnchor, 10)
            cityTF.width(200)
        }
        cityTF.centerX(frameImage.centerXAnchor)
        cityTF.height(50)
    }
    
    
    fileprivate func dateTFConst(){
        view.addSubview(dateTF)
        if view.frame.height > 670 {
            dateTF.top(cityTF.bottomAnchor, 10)
            dateTF.width(220)
        }else{
            dateTF.top(cityTF.bottomAnchor, 10)
            dateTF.width(200)
        }
        dateTF.centerX(frameImage.centerXAnchor)
        dateTF.height(50)
    }
    
    
    fileprivate func plansTableVConst(){
        view.addSubview(plansTableView)
        plansTableView.top(topFrameImage.bottomAnchor, 20)
        plansTableView.right(topFrameImage.rightAnchor)
        plansTableView.left(topFrameImage.leftAnchor)
        plansTableView.bottom(bottomPanelImgV.topAnchor, -20)
    }
    
}



