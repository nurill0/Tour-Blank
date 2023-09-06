//
//  CreateLandMarkVC.swift
//  Tour Blank
//
//  Created by Nurillo Domlajonov on 04/09/23.

import UIKit
import UnsplashPhotoPicker
import Cosmos

var savedImages = [String]()
var savedSightsee = [String]()
var savedImpression = [String]()
var savedRates = [Double]()
enum SelectionType: Int {
    case single
    case multiple
}


class CreateLandMarkVC: BaseVC, UITextFieldDelegate{
    var rate: Int = 0
    private var imageDataTask: URLSessionDataTask?
    private static var cache: URLCache = {
        let memoryCapacity = 50 * 1024 * 1024
        let diskCapacity = 100 * 1024 * 1024
        let diskPath = "unsplash"
        
        if #available(iOS 13.0, *) {
            return URLCache(
                memoryCapacity: memoryCapacity,
                diskCapacity: diskCapacity,
                directory: URL(fileURLWithPath: diskPath, isDirectory: true)
            )
        }
        else {
#if !targetEnvironment(macCatalyst)
            return URLCache(
                memoryCapacity: memoryCapacity,
                diskCapacity: diskCapacity,
                diskPath: diskPath
            )
#else
            fatalError()
#endif
        }
    }()
    
    
    var pageType = ""
    
    lazy var rateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.appGreenColor().cgColor
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 15
        view.isHidden = true
        
        return view
    }()
    
    
    lazy var cosmosView: CosmosView = {
        let cosmos = CosmosView()
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        cosmos.settings.totalStars = 5
        cosmos.settings.starSize = 30
        cosmos.settings.fillMode = .half
        
        return cosmos
    }()
    
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
        btn.setTitleColor(.titleLblColor().withAlphaComponent(0.4), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .clear
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        
        return btn
    }()
    
    lazy var ratedBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("rated", for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(.titleLblColor(), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Kanit-SemiBold" , size: 27)
        btn.titleLabel?.textAlignment = .center
        
        return btn
    }()
    
    lazy var sightseeingImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "addSight")
        img.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseImg))
        img.addGestureRecognizer(tap)
        img.isUserInteractionEnabled = true
        
        return img
    }()
    
    lazy var sightseeingTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(
            string: "Sightseeing describe...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.textAlignment = .center
        tf.backgroundColor = #colorLiteral(red: 0.850980401, green: 0.850980401, blue: 0.850980401, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -10, y: -10, width: -10, height: -10))
        tf.textColor = .white
        tf.keyboardType = .default
        tf.adjustsFontSizeToFitWidth = true
        
        return tf
    }()
    
    
    lazy var impressionTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(
            string: "Impression...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        tf.font = UIFont(name: "Kanit-Regular", size: 20)
        tf.textAlignment = .center
        tf.backgroundColor = #colorLiteral(red: 0.850980401, green: 0.850980401, blue: 0.850980401, alpha: 1)
        tf.leftView = UIView(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.rightView = UIView(frame: CGRect(x: -10, y: -10, width: -10, height: -10))
        tf.textColor = .white
        tf.adjustsFontSizeToFitWidth = true
        
        return tf
    }()
    
    lazy var rateBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "rateBtn"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(rateSightseeing), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "v"), for: .normal)
        btn.backgroundColor = .clear
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "x"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        return btn
    }()
    
    private var photos = [UnsplashPhoto]()
    var img = UIImage()
    let userD = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
        setUpPlacesUI()
    }
    
    
}


//MARK: read and write image from api
extension CreateLandMarkVC: UnsplashPhotoPickerDelegate  {
    
    func downloadPhoto(_ photo: UnsplashPhoto) {
        guard let url = photo.urls[.regular] else { return }
        savedImages.append(url.absoluteString)
        
    }
    
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        print("Unsplash photo picker did select \(photos.count) photo(s)")
        self.photos = photos
        downloadPhoto(photos[0])
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        print("Unsplash photo picker did cancel")
    }
}


extension CreateLandMarkVC {
    
    
    func showSearchAlert(){
        var alert = UIAlertController()
        alert = UIAlertController(title: "Search", message: "You can any photos from unsplash pictures", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField{ field in
            field.placeholder = "Search photos..."
            field.returnKeyType = .search
            field.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Search", style: .default, handler: {  _ in
            guard let fields = alert.textFields, fields.count == 1 else { return }
            let timeTF = fields[0]
            guard let time = timeTF.text,  !time.isEmpty else {
                return
            }
            let allowsMultipleSelection =  SelectionType.single.rawValue
            let configuration = UnsplashPhotoPickerConfiguration(
                accessKey: "M8PQBcknVrOegoY1NicgD-g7R41snjTKKrld5DXLtuo",
                secretKey: "M8PQBcknVrOegoY1NicgD-g7R41snjTKKrld5DXLtuo",
                query: time,
                allowsMultipleSelection: (allowsMultipleSelection != 0)
            )
            let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
            unsplashPhotoPicker.photoPickerDelegate = self
            unsplashPhotoPicker.modalPresentationStyle = .popover
            self.present(unsplashPhotoPicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {  action in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRateAlert(){
        var alert = UIAlertController()
        alert = UIAlertController(title: "Rate", message: "Would you give \(cosmosView.rating) rates", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {  _ in
            savedRates.append(self.cosmosView.rating)
            self.rateView.isHidden = true
        }))
        
        alert.addAction(UIAlertAction(title: "Change", style: .cancel, handler: {  action in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func chooseImg(){
        showSearchAlert()
    }
    
    @objc func rateSightseeing(){
        rateView.isHidden = false
        cosmosView.didTouchCosmos = { rating in
            self.showRateAlert()
        }
    }
    
    @objc func cancel(){
        dismiss(animated: true)
    }
    
    @objc func save(){
        guard let sightSeeing = sightseeingTF.text, !sightSeeing.isEmpty,
              let impression = impressionTF.text, !impression.isEmpty else {return}
        
        savedSightsee.append(sightSeeing)
        savedImpression.append(impression)
        userD.saveImages(items: savedImages)
        userD.saveSightSee(items: savedSightsee)
        userD.saveImpression(items: savedImpression)
        userD.saveRateAmount(items: savedRates)
        dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func goBack(){
        dismiss(animated: true)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3
        let curveRawValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let curve: UIView.AnimationCurve = UIView.AnimationCurve(rawValue: curveRawValue) ?? .easeInOut
        
        UIViewPropertyAnimator(duration: duration, curve: curve, animations: {
            self.additionalSafeAreaInsets.bottom = self.view.frame.height - endFrame.origin.y
            self.view.layoutIfNeeded()
        }).startAnimation()
    }
}



extension CreateLandMarkVC {
    
    fileprivate func setUpPlacesUI(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        backBtnConst()
        bottomPanelImgConst()
        tripFrameImgConst()
        topFrameImgConst()
        newBtnConst()
        ratedBtnConst()
        impressionTFConst()
        sightseeingTFConst()
        sightSeeingImgConst()
        rateBtnConst()
        saveBtnConst()
        cancelBtnConst()
        rateViewConst()
        cosmosViewConst()
    }
    
    
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
        topFrameImage.addSubview(newBtn)
        newBtn.centerY(topFrameImage.centerYAnchor)
        newBtn.left(topFrameImage.leftAnchor)
        newBtn.right(topFrameImage.centerXAnchor)
    }
    
    fileprivate func ratedBtnConst(){
        topFrameImage.addSubview(ratedBtn)
        ratedBtn.centerY(topFrameImage.centerYAnchor)
        ratedBtn.right(topFrameImage.rightAnchor)
        ratedBtn.left(topFrameImage.centerXAnchor)
    }
    
    
    fileprivate func impressionTFConst(){
        view.addSubview(impressionTF)
        impressionTF.bottom(tripFrameView.bottomAnchor, -20)
        impressionTF.left(tripFrameView.leftAnchor, 20)
        impressionTF.right(tripFrameView.rightAnchor, -20)
        impressionTF.height(60)
    }
    
    fileprivate func sightseeingTFConst(){
        view.addSubview(sightseeingTF)
        sightseeingTF.bottom(impressionTF.topAnchor, -15)
        sightseeingTF.left(tripFrameView.leftAnchor, 20)
        sightseeingTF.right(tripFrameView.rightAnchor, -20)
        sightseeingTF.height(60)
    }
    
    fileprivate func sightSeeingImgConst(){
        tripFrameView.addSubview(sightseeingImage)
        sightseeingImage.top(topFrameImage.bottomAnchor, 20)
        sightseeingImage.centerX(tripFrameView.centerXAnchor)
        sightseeingImage.left(tripFrameView.leftAnchor, 20)
        sightseeingImage.right(tripFrameView.rightAnchor, -20)
        sightseeingImage.bottom(sightseeingTF.topAnchor, -20)
    }
    
    fileprivate func rateBtnConst(){
        view.addSubview(rateBtn)
        if view.frame.height > 670 {
            rateBtn.bottom(sightseeingImage.bottomAnchor, -30)
            rateBtn.height(50)
            rateBtn.width(50)
        }else {
            rateBtn.bottom(sightseeingImage.bottomAnchor, -10)
            rateBtn.height(40)
            rateBtn.width(40)
        }
        rateBtn.centerX(sightseeingImage.centerXAnchor)
        
    }
    
    fileprivate func saveBtnConst(){
        view.addSubview(saveBtn)
        if view.frame.height > 740 {
            saveBtn.top(sightseeingImage.topAnchor, 30)
            saveBtn.right(tripFrameView.rightAnchor, -10)
            saveBtn.height(50)
            saveBtn.width(50)
        }else{
            saveBtn.top(sightseeingImage.topAnchor, 5)
            saveBtn.right(sightseeingImage.rightAnchor, -30)
            saveBtn.height(40)
            saveBtn.width(40)
        }
        
    }
    
    fileprivate func cancelBtnConst(){
        view.addSubview(cancelBtn)
        if view.frame.height > 740 {
            cancelBtn.top(sightseeingImage.topAnchor, 30)
            cancelBtn.left(tripFrameView.leftAnchor, 10)
            cancelBtn.height(50)
            cancelBtn.width(50)
        }else{
            cancelBtn.top(sightseeingImage.topAnchor, 5)
            cancelBtn.left(sightseeingImage.leftAnchor, 30)
            cancelBtn.height(40)
            cancelBtn.width(40)
        }
    }
    
    fileprivate func rateViewConst(){
        view.addSubview(rateView)
        rateView.centerY(view.centerYAnchor)
        rateView.right(topFrameImage.rightAnchor, -20)
        rateView.left(topFrameImage.leftAnchor, 20)
        rateView.height(250)
    }
    
    fileprivate func cosmosViewConst(){
        rateView.addSubview(cosmosView)
        cosmosView.centerY(view.centerYAnchor)
        cosmosView.centerX(view.centerXAnchor)
    }
}

