//
//  TripPlanVC.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 26/08/23.
//

import UIKit

var scheduleTime = [String]()
var schedulePlan = [String]()

class TripPlanDescripVC: BaseVC {
    
    
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
        btn.setTitleColor(.titleLblColor(), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .clear
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        
        return btn
    }()
    
    lazy var planBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("plan", for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(.titleLblColor().withAlphaComponent(0.4), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        btn.titleLabel?.textAlignment = .center
        
        return btn
    }()
    
    lazy var countryTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -20, y: -20, width: -20, height: -20))
        tf.textColor = .white
        tf.isUserInteractionEnabled = false
        
        return tf
    }()
    
    lazy var cityTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .center
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -20, y: -20, width: -20, height: -20))
        tf.textColor = .white
        tf.isUserInteractionEnabled = false
        
        return tf
    }()
    
    lazy var dateTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.textAlignment = .center
        tf.backgroundColor = #colorLiteral(red: 0.4537174702, green: 0.6885462999, blue: 0.8925844431, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -20, y: -20, width: -20, height: -20))
        tf.textColor = .white
        tf.isUserInteractionEnabled = false
        tf.returnKeyType = .done
        tf.keyboardType = .numberPad
        
        return tf
    }()
    
    lazy var scheduleBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "scheduleBtn"), for: .normal)
        btn.tag = 1
        btn.addTarget(self, action: #selector(changeReminderToSchedule(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var reminderBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "reminderBtn"), for: .normal)
        btn.tag = 2
        btn.addTarget(self, action: #selector(changeReminderToSchedule(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var scheduleFrameImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "scheduleFrame")
        img.contentMode = .scaleAspectFill
        img.isHidden = true
        
        return img
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(addTimeAndPlans), for: .touchUpInside)
        btn.isHidden = true
        
        return btn
    }()
    
    lazy var timeTableView: UITableView = {
        let tbV = UITableView()
        tbV.translatesAutoresizingMaskIntoConstraints = false
        tbV.autoresizesSubviews = true
        tbV.register(TimeTableCell.self, forCellReuseIdentifier: TimeTableCell.identifer)
        tbV.delegate = self
        tbV.dataSource = self
        tbV.separatorStyle = .none
        tbV.rowHeight = UITableView.automaticDimension
        tbV.backgroundColor = .clear
        tbV.isScrollEnabled = true
        tbV.showsVerticalScrollIndicator = false
        tbV.isUserInteractionEnabled = false
        tbV.isHidden = true
        
        return tbV
    }()
    
    lazy var reminderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isHidden = true
        
        return view
    }()
    
    lazy var reminderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy var firstItemView: ReminderItem = {
        let view = ReminderItem()
        view.textField.text = "Passport photo"
        
        return view
    }()
    
    lazy var secondItemView: ReminderItem = {
        let view = ReminderItem()
        view.textField.text = "Pack a suitcase"
        
        return view
    }()
    
    lazy var thirdItemView: ReminderItem = {
        let view = ReminderItem()
        view.textField.text = "Cat-sitter"
        
        return view
    }()
    
    lazy var fourthItemView: ReminderItem = {
        let view = ReminderItem()
        
        return view
    }()
    
    lazy var fivesItemView: ReminderItem = {
        let view = ReminderItem()
        
        return view
    }()
    
    
    var alert = UIAlertController()
    let userD = UserDefaultsManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameImage.isHidden = false
        countryTF.isHidden = false
        cityTF.isHidden = false
        dateTF.isHidden = false
        setupTripPlanUI()
    }
    
}



//MARK: actions
extension TripPlanDescripVC {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc func addTimeAndPlans(){
        alert = UIAlertController(title: "Add time scheduling", message: "Please add time and your plans", preferredStyle: .alert)
        alert.addTextField{ field in
            field.placeholder = "00:00 / 01:00"
            field.delegate = self
            field.returnKeyType = .next
            field.keyboardType = .numberPad
        }
        alert.addTextField{ field in
            field.placeholder = "Your plans..."
            field.returnKeyType = .next
            field.delegate = self
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [self] _ in
            guard let fields = alert.textFields, fields.count == 2 else { return }
            let timeTF = fields[0]
            let planTF = fields[1]
            guard let time = timeTF.text,  !time.isEmpty,
                  let plan = planTF.text, !plan.isEmpty else {
                return
            }
            schedulePlan.append(plan)
            scheduleTime.append(time)
            userD.saveScheduleTime(items: scheduleTime)
            userD.saveScheduleTitle(items: schedulePlan)
            timeTableView.reloadData()
        }))
        present(alert, animated: true)
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
            showInfoAlert()
        }
    }
    
    
    @objc func changeReminderToSchedule(sender: UIButton){
        switch sender.tag {
        case 1:
            scheduleBtn.setImage(UIImage(named: "selectedSchedule"), for: .normal)
            reminderBtn.setImage(UIImage(named: "reminderBtn"), for: .normal)
            scheduleFrameImgView.isHidden = false
            addBtn.isHidden = false
            timeTableView.isHidden = false
            reminderView.isHidden = true
            reminderStackView.isHidden = true
            frameImage.isHidden = true
        case 2:
            scheduleBtn.setImage(UIImage(named: "scheduleBtn"), for: .normal)
            reminderBtn.setImage(UIImage(named: "selectedReminder"), for: .normal)
            scheduleFrameImgView.isHidden = true
            addBtn.isHidden = true
            timeTableView.isHidden = true
            frameImage.isHidden = true
            reminderView.isHidden = false
            reminderStackView.isHidden = false
        default: print("error")
        }
    }
    
    
    func showInfoAlert(){
        var alert = UIAlertController()
        alert = UIAlertController(title: "Saved", message: "Your changes saved", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [self] action in
            scheduleFrameImgView.isHidden = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}



//MARK: delegates
extension TripPlanDescripVC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let newLength = text.count
        if textField == alert.textFields?[0] {
            switch newLength {
            case 3: alert.textFields?[0].text?.append(":")
            case 6: alert.textFields?[0].text?.append("/")
            case 9: alert.textFields?[0].text?.append(":")
            case 12: alert.textFields?[0].isUserInteractionEnabled = false
            default:  print("nothing")
            }
        }
        return true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedulePlan.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableCell.identifer, for: indexPath) as! TimeTableCell
        cell.timeLbl.text = scheduleTime[indexPath.row]
        cell.titleLbl.text = schedulePlan[indexPath.row]
        return cell
    }
    
}



//MARK: UI
extension TripPlanDescripVC {
    
    
    fileprivate func setupTripPlanUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
        reminderBtnConst()
        scheduleBtnConst()
        scheduleFrameConst()
        addBtnConst()
        timeTableViewConst()
        reminderViewConst()
        reminderStackViewConst()
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
        topFrameImage.top(backBtn.bottomAnchor, 10)
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
            frameImage.height(280)
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
            countryTF.width(180)
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
            cityTF.width(180)
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
            dateTF.width(180)
        }
        dateTF.centerX(frameImage.centerXAnchor)
        dateTF.height(50)
    }
    
    
    fileprivate func scheduleBtnConst(){
        view.addSubview(scheduleBtn)
        scheduleBtn.bottom(reminderBtn.topAnchor, -10)
        scheduleBtn.right(view.rightAnchor, -30)
        scheduleBtn.height(50)
        scheduleBtn.width(50)
    }
    
    
    fileprivate func reminderBtnConst(){
        view.addSubview(reminderBtn)
        reminderBtn.bottom(bottomPanelImgV.topAnchor, -10)
        reminderBtn.right(view.rightAnchor, -30)
        reminderBtn.height(50)
        reminderBtn.width(50)
    }
    
    
    fileprivate func scheduleFrameConst(){
        view.addSubview(scheduleFrameImgView)
        scheduleFrameImgView.bottom(scheduleBtn.topAnchor, -10)
        scheduleFrameImgView.left(topFrameImage.leftAnchor)
        scheduleFrameImgView.right(topFrameImage.rightAnchor)
    }
    
    
    fileprivate func addBtnConst(){
        view.addSubview(addBtn)
        addBtn.bottom(scheduleFrameImgView.bottomAnchor, -15)
        addBtn.left(scheduleFrameImgView.leftAnchor, 25)
        addBtn.height(25)
        addBtn.width(25)
    }
    
    
    fileprivate func timeTableViewConst(){
        view.addSubview(timeTableView)
        timeTableView.top(scheduleFrameImgView.topAnchor, 60)
        timeTableView.left(scheduleFrameImgView.leftAnchor)
        timeTableView.bottom(addBtn.topAnchor, -5)
        timeTableView.right(scheduleFrameImgView.rightAnchor)
    }
    
    
    fileprivate func reminderViewConst(){
        view.addSubview(reminderView)
        reminderView.top(topFrameImage.bottomAnchor, 20)
        reminderView.right(topFrameImage.rightAnchor)
        reminderView.left(topFrameImage.leftAnchor)
        reminderView.bottom(scheduleBtn.topAnchor, -15)
    }
    
    
    fileprivate func reminderStackViewConst(){
        reminderView.addSubview(reminderStackView)
        reminderStackView.addArrangedSubview(firstItemView)
        reminderStackView.addArrangedSubview(secondItemView)
        reminderStackView.addArrangedSubview(thirdItemView)
        reminderStackView.addArrangedSubview(fourthItemView)
        reminderStackView.addArrangedSubview(fivesItemView)
        reminderStackView.top(reminderView.topAnchor, 10)
        reminderStackView.bottom(reminderView.bottomAnchor, -10)
        reminderStackView.right(reminderView.rightAnchor, -10)
        reminderStackView.left(reminderView.leftAnchor, 10)
        
    }
    
}




