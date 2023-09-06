//  MapLocationController.swift
//  RTO
//
//  Created by Nurillo Domlajonov on 13/07/22.
//
import CoreLocation
import MapKit
import UIKit

var savedPlaces: [String] = []
var savedLatitude: [Double] = []
var savedLongtitude: [Double] = []



class MapVC: UIViewController,CLLocationManagerDelegate {
    
    var lat  = 0.0
    var long = 0.0
    var regionInMeters: Double = 1000
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    let userDefaultsManager = UserDefaultsManager.shared
    var savelat = 0.0
    var savelong = 0.0
    
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.tintColor = .red
        map.showsUserLocation = true
        map.isPitchEnabled = true
        map.isRotateEnabled = false
        map.isZoomEnabled = true
        map.isExclusiveTouch = true
        map.mapType = .standard
        
        return map
    }()
    
    lazy var pinImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "mappin")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var userLocationBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "arrow"), for: .normal)
        btn.layer.cornerRadius = 30
        btn.imageView?.contentMode = .scaleAspectFill
        
        return btn
    }()
    
    lazy var panelImgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "leftPanel")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var bottomPanel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 35
        view.backgroundColor = #colorLiteral(red: 0.2533306479, green: 0.5079666376, blue: 0.7529734969, alpha: 1)
        view.addBorders(edges: .top, color: .white)
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
    }()
    
    lazy var countryTitleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Connecting..."
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = UIFont(name: "Kanit-SemiBold" , size: 22)
        
        return lbl
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var clearBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "clear")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        btn.backgroundColor =  #colorLiteral(red: 0.2533306479, green: 0.5079666376, blue: 0.7529734969, alpha: 1)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(clearData), for: .touchUpInside)
        btn.layer.cornerRadius = 25
        
        return btn
    }()
    
    lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "addBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(addPlaces), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServices()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        render()
        checkLocationServices()
        userLocationBtn.addTarget(self, action: #selector(getUserLocation), for: .touchUpInside)
    }
    
}




extension MapVC{
    
    //MARK: Button actions
    @objc func addPlaces(){
        savedPlaces.append(countryTitleLbl.text ?? "unknown")
        savedLatitude.append(savelat)
        savedLongtitude.append(savelong)
        if userDefaultsManager.loadPlaces().count < 5 {
            showAddAlert(message: "The places you've been have been successfully added", title: "Successed")
            userDefaultsManager.savePlaces(items: savedPlaces)
            userDefaultsManager.saveLatitude(items: savedLatitude)
            userDefaultsManager.saveLongtitude(items: savedLongtitude)
            
        }else{
            showAddAlert(message: "You can't add places you've been.Please delete old places you have been", title: "Failed")
        }
    }
    
    
    @objc func goBack(){
        dismiss(animated: true)
    }
    
    
    @objc func clearData(){
        showClearAlert()
    }
    
    
    @objc func goPinnedPlace(sender: UIButton){
        if userDefaultsManager.loadLatitude().count >= sender.tag {
            if userDefaultsManager.loadPlaces().isEmpty == false {
                let coordinate = CLLocationCoordinate2D(latitude: userDefaultsManager.loadLatitude()[sender.tag-1], longitude: userDefaultsManager.loadLongtitude()[sender.tag-1])
                let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }else{
                
            }
        }
    }
    
    
    @objc func getUserLocation(){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01 )
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    @objc func longpressAction(sender: UIButton){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        showInfoAlert(index: sender.tag)
    }
    
    //MARK: Alert functions
    func showAddAlert(message: String, title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if userDefaultsManager.loadPlaces().count < 5 {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] action in
                addAnnoitation(subTitle: "This place you have been a few years ago", lat: savelat, long: savelong)
            }))
        }else{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showClearAlert(){
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete places information you have been?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] action in
            savedPlaces = []
            savedLatitude = []
            savedLongtitude = []
            userDefaultsManager.savePlaces(items: savedPlaces)
            userDefaultsManager.saveLatitude(items: savedLatitude)
            userDefaultsManager.saveLongtitude(items: savedLongtitude)
            dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showInfoAlert(index: Int){
        var alert = UIAlertController()
        if userDefaultsManager.loadLatitude().count >= index{
            alert = UIAlertController(title: "Information", message: "\(userDefaultsManager.loadPlaces()[index-1]) this is you have been there a few years ago", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {  action in
            }))
        }else{
            alert = UIAlertController(title: "Information", message: "You have do not add places where you have been yet", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {  action in
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: Annotation functions
    func addAnnoitation(subTitle: String, lat: CLLocationDegrees, long: CLLocationDegrees){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let pin = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1 )
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        pin.coordinate = coordinate
        pin.title = "Mark the places you've been"
        pin.subtitle = subTitle
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
    }
    
    
    func render(){
        for i in 0..<(userDefaultsManager.loadPlaces().count){
            let coordinate = CLLocationCoordinate2D(latitude: userDefaultsManager.loadLatitude()[i], longitude: userDefaultsManager.loadLongtitude()[i])
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1 )
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title =  "Mark the places you've been"
            pin.subtitle = "This place you have been a few years ago"
            mapView.addAnnotation(pin)
            mapView.showAnnotations([pin], animated: true)
        }
    }
    
    
}



//MARK: UI
extension MapVC{
    
    
    private func initViews(){
        backBtnConst()
        clearBtnConst()
        mapViewConst()
        pinImageConst()
        panelImgVConst()
        bottomPanelConst()
        userLocationBtnConst()
        countrTitleLblConst()
        addBtnConst()
        setupStackViewAndConst()
    }
    
    
    fileprivate func backBtnConst(){
        view.addSubview(backBtn)
        backBtn.top(view.safeAreaLayoutGuide.topAnchor, 20)
        backBtn.left(view.leftAnchor, 20)
        backBtn.height(50)
        backBtn.width(50)
    }
    
    
    fileprivate func clearBtnConst(){
        view.addSubview(clearBtn)
        clearBtn.top(view.safeAreaLayoutGuide.topAnchor, 20)
        clearBtn.right(view.rightAnchor, -20)
        clearBtn.height(50)
        clearBtn.width(50)
    }
    
    
    fileprivate func mapViewConst(){
        view.addSubview(mapView)
        mapView.top(view.topAnchor)
        mapView.bottom(view.bottomAnchor)
        mapView.right(view.rightAnchor)
        mapView.left(view.leftAnchor)
    }
    
    
    fileprivate func pinImageConst(){
        mapView.addSubview(pinImage)
        pinImage.centerY(mapView.centerYAnchor, -20)
        pinImage.centerX(mapView.centerXAnchor)
        pinImage.height(40)
        pinImage.width(40)
    }
    
    
    fileprivate func panelImgVConst(){
        view.addSubview(panelImgView)
        panelImgView.left(view.leftAnchor)
        panelImgView.centerY(view.centerYAnchor)
        panelImgView.width(70)
        panelImgView.height(360)
    }
    
    
    fileprivate func bottomPanelConst(){
        view.addSubview(bottomPanel)
        bottomPanel.right(view.rightAnchor)
        bottomPanel.left(view.leftAnchor)
        bottomPanel.bottom(view.bottomAnchor)
        if view.frame.height > 670 {
            bottomPanel.height(120)
        }else{
            bottomPanel.height(80)
        }
        
    }
    
    
    fileprivate func userLocationBtnConst(){
        view.addSubview(userLocationBtn)
        view.sendSubviewToBack(mapView)
        userLocationBtn.bottom(bottomPanel.topAnchor, -10)
        userLocationBtn.right(view.rightAnchor, -20)
        userLocationBtn.height(50)
        userLocationBtn.width(50)
    }
    
    
    fileprivate func countrTitleLblConst(){
        bottomPanel.addSubview(countryTitleLbl)
        countryTitleLbl.centerY(bottomPanel.centerYAnchor)
        countryTitleLbl.left(bottomPanel.leftAnchor, 10)
        countryTitleLbl.right(bottomPanel.rightAnchor, -70)
    }
    
    
    fileprivate func addBtnConst(){
        bottomPanel.addSubview(addBtn)
        addBtn.centerY(bottomPanel.centerYAnchor)
        addBtn.right(bottomPanel.rightAnchor, -20)
        addBtn.height(50)
        addBtn.width(50)
    }
    
    
    fileprivate func setupStackViewAndConst(){
        view.addSubview(stackView)
        view.bringSubviewToFront(stackView)
        stackView.top(panelImgView.topAnchor, 5)
        stackView.bottom(panelImgView.bottomAnchor, -5)
        stackView.right(panelImgView.rightAnchor, -5)
        stackView.left(panelImgView.leftAnchor)
        stackView.userActivity = .none
        for i in 1...5 {
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.tag = i
            btn.setImage(UIImage(named: "\(i)"), for: .normal)
            btn.addTarget(self, action: #selector(goPinnedPlace(sender:)), for: .touchUpInside)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.addTarget(self, action: #selector(longpressAction(sender: )), for: .touchDownRepeat)
            stackView.addArrangedSubview(btn)
        }
    }
    
}



//MARK: mapview delegate
extension MapVC: MKMapViewDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        lat = (locations.last?.coordinate.latitude)!
        long = (locations.last?.coordinate.longitude)!
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self]  (placemarks, error) in
            guard self != nil else { return }
            
            if let _ = error {
                //show alert informing to user
                return
            }
            
            guard let placemarks = placemarks?.first else {
                //show alert informing to user
                return
            }
            
            let cityTitile = placemarks.administrativeArea ?? "unknown"
            let countryTitle = placemarks.country ?? "unknown"
            let coordinates = placemarks.location
            self?.savelat = coordinates?.coordinate.latitude ?? 0.0
            self?.savelong = coordinates?.coordinate.longitude ?? 0.0
            DispatchQueue.main.async {
                self?.countryTitleLbl.text = "\(countryTitle), \(cityTitile)"
            }
        }
    }
}



//map functions
extension MapVC {
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longtitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longtitude)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
    func startTackingUserLocation(){
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.setupLocationManager()
                self.checkLocationAuthorization()
            }
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions break
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            //
            break
        default:
            //
            break
        }
    }
}
