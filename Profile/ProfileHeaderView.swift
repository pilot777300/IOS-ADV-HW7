//
//  ProfileHeaderView.swift
//  NavigTest
//
//  Created by Mac on 18.07.2022.
//

import UIKit



struct PicturesData {
    var picture: String?
}

class ProfileHeaderView: UIView {
    
    
    var pictureData = [PicturesData]()
    
     lazy var profileView = UIImageView()
    
    lazy var status: UILabel = {
       let status = UILabel()
        if isGreenThemeActivated {
            status.backgroundColor = GreenTheme().backgroundColor
        } else if isDarkThemeActivated {
            status.backgroundColor = DarkTheme().backgroundColor
        } else if isLightThemeActivatd {
            status.backgroundColor = LightTheme().backgroundColor
        }
        status.text = "Пилот Баранкин"
        status.font = UIFont.boldSystemFont(ofSize: 20)
        if isDarkThemeActivated {
            status.textColor = DarkTheme().textColor
        } else {
            status.textColor = .black
        }
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var newStatus: UILabel = {
       let newstatus = UILabel()
        if isGreenThemeActivated {
            newstatus.backgroundColor = GreenTheme().backgroundColor
        } else if isDarkThemeActivated {
            newstatus.backgroundColor = DarkTheme().backgroundColor
        } else if isLightThemeActivatd {
            newstatus.backgroundColor = LightTheme().backgroundColor
        } else {
            newstatus.backgroundColor = .systemGray5
        }
        newstatus.text = " "
        if isDarkThemeActivated {
            newstatus.textColor = DarkTheme().textColor
        }
        newstatus.font = UIFont.systemFont(ofSize: 16)
        newstatus.translatesAutoresizingMaskIntoConstraints = false
        return newstatus
    }()
    
    private lazy var setStatus = UITextField ()
    
    lazy var changeStatusButton: UIButton = {
        let changeStatusButton = UIButton()
        if isGreenThemeActivated {
            changeStatusButton.backgroundColor = GreenTheme().buttonBackGround
        } else {
        changeStatusButton.backgroundColor = .blue
        }
        changeStatusButton.layer.cornerRadius = 4
        changeStatusButton.setTitle(NSLocalizedString("Change_Status", comment: ""), for: .normal)
        if isGreenThemeActivated {
            changeStatusButton.setTitleColor(GreenTheme().textColor, for: .normal)
        } else {
        changeStatusButton.setTitleColor(.white, for: .normal)
        }
        changeStatusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        changeStatusButton.layer.shadowRadius = 4
        changeStatusButton.layer.shadowColor = UIColor.black.cgColor
        changeStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        changeStatusButton.layer.shadowOpacity = 0.7
        changeStatusButton.layer.masksToBounds = false
        changeStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        changeStatusButton.isUserInteractionEnabled = true
        changeStatusButton.translatesAutoresizingMaskIntoConstraints = false
        return changeStatusButton
    }()
    
    private lazy var changedText: String = ""

      override init(frame: CGRect){
        super.init(frame: frame)
          
          pictureData.append(PicturesData(picture: "Boston.jpg"))
          pictureData.append(PicturesData(picture: "Aeroplan.jpeg"))
          pictureData.append(PicturesData(picture: "Avatarka1.jpg"))
          pictureData.append(PicturesData(picture: "Brothers.tiff"))
          pictureData.append(PicturesData(picture: "A330-300.jpg"))
          
        profileView.backgroundColor = .systemGray5
        profileView.image = UIImage(named: "Avatarka1.jpg")
        profileView.layer.borderColor = UIColor.white.cgColor
        profileView.layer.borderWidth = 3.0
        profileView.layer.cornerRadius = 50
        profileView.layer.masksToBounds = true
          profileView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileView)
          self.addSubview(status)
          self.addSubview(newStatus)
          
          setStatus.placeholder = NSLocalizedString("Set_Status", comment: "")
          setStatus.backgroundColor = .systemGray6
          setStatus.layer.borderWidth = 1
          setStatus.layer.borderColor = .init(_colorLiteralRed: 0, green: 0, blue: 100, alpha: 9)
          setStatus.layer.cornerRadius = 9
          setStatus.font = UIFont.systemFont(ofSize: 15)
          setStatus.keyboardType = UIKeyboardType.default
          setStatus.returnKeyType = UIReturnKeyType.done
          setStatus.clearButtonMode = UITextField.ViewMode.whileEditing;
          setStatus.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
          setStatus.addTarget(self, action: #selector(editingChanged), for: UIControl.Event.editingChanged)
          setStatus.translatesAutoresizingMaskIntoConstraints = false
          self.addSubview(setStatus)
          
//          changeStatusButton.backgroundColor = .blue
//          changeStatusButton.layer.cornerRadius = 4
//          changeStatusButton.setTitle(NSLocalizedString("Change_Status", comment: ""), for: .normal)
//          changeStatusButton.setTitleColor(.white, for: .normal)
//          changeStatusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//          changeStatusButton.layer.shadowRadius = 4
//          changeStatusButton.layer.shadowColor = UIColor.black.cgColor
//          changeStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
//          changeStatusButton.layer.shadowOpacity = 0.7
//          changeStatusButton.layer.masksToBounds = false
//          changeStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//          changeStatusButton.isUserInteractionEnabled = true
//          changeStatusButton.translatesAutoresizingMaskIntoConstraints = false
          self.addSubview(changeStatusButton)
          
        setupConstrains()
        //  changeStatusButton.setTitle(buttonTitle, for: .normal)
}
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      private  func setupConstrains() {
             let safeArea = self.safeAreaLayoutGuide
          NSLayoutConstraint.activate([
          
            profileView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16.0),
            profileView.widthAnchor.constraint(equalToConstant: 100),
            profileView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16.0),
            profileView.heightAnchor.constraint(equalToConstant: 100),
            
            status.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 137),
            status.widthAnchor.constraint(equalToConstant: 250),
            status.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 27),
            status.heightAnchor.constraint(equalToConstant: 25),
            
            setStatus.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 137),
            setStatus.widthAnchor.constraint(equalToConstant: 150),
            setStatus.heightAnchor.constraint(equalToConstant: 25),
            setStatus.bottomAnchor.constraint(equalTo: changeStatusButton.topAnchor, constant: -14),
            
            newStatus.bottomAnchor.constraint(equalTo: setStatus.topAnchor, constant: -11),
            newStatus.heightAnchor.constraint(equalToConstant: 15),
            newStatus.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 137),
            newStatus.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -5),
            
            changeStatusButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            changeStatusButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16.0),
            changeStatusButton.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 16),
            changeStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
          ])
    }

    @objc func editingChanged(textField: UITextField) {
        changedText = setStatus.text!
    }
    
    @objc func buttonPressed(sender: UIButton) {
        newStatus.text = changedText
    }

}

