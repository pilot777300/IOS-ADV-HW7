//
//  PostTableViewCell.swift
//  NavigTest
//
//  Created by Mac on 02.09.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
  
    

    
    
    lazy var backView: UILabel = {
        let authorlbl = UILabel()
        authorlbl.translatesAutoresizingMaskIntoConstraints = false
        if isGreenThemeActivated == true {
            authorlbl.backgroundColor = GreenTheme().backgroundColor
        } else if isDarkThemeActivated {
            authorlbl.backgroundColor = DarkTheme().backgroundColor
        } else if isLightThemeActivatd {
            authorlbl.backgroundColor = LightTheme().backGroundForPost
        } else {
        authorlbl.backgroundColor = .white
        }
      return authorlbl
    }()
    
     lazy var postAuthor: UILabel = {
       let postaut = UILabel()
        let font: UIFont = UIFont.boldSystemFont(ofSize: 20)
        postaut.translatesAutoresizingMaskIntoConstraints = false
        postaut.font = font
        postaut.numberOfLines = 2
         if isDarkThemeActivated {
             postaut.textColor = DarkTheme().textColor
         } else if isGreenThemeActivated {
             postaut.textColor = GreenTheme().textColor
         } else if isLightThemeActivatd {
             postaut.textColor = LightTheme().textColor
         } else {
        postaut.textColor = .black
         }
         if isGreenThemeActivated {
             postaut.backgroundColor = GreenTheme().backgroundColor
         } else if  isDarkThemeActivated {
             postaut.backgroundColor = DarkTheme().backgroundColor
         } else {
        postaut.backgroundColor = .white
         }
        return postaut
    }()
    
     lazy var postTxt: UILabel = {
        let ptxt = UILabel()
        let font: UIFont = UIFont.systemFont(ofSize: 14)
        ptxt.translatesAutoresizingMaskIntoConstraints = false
        ptxt.font = font
        ptxt.numberOfLines = 0
        // postTxt.addInteraction(UIDropInteraction(delegate: self)) //!!!! для Drag and drop
       //  postTxt.isUserInteractionEnabled = true  //----
       //  postTxt.addInteraction(UIDragInteraction(delegate: self))  //====
         if isDarkThemeActivated {
             ptxt.textColor = DarkTheme().textColor
         } else if isLightThemeActivatd {
        ptxt.textColor = .black
         } else if isGreenThemeActivated{
             ptxt.textColor = GreenTheme().textColor
         } else {
             ptxt.textColor = .black
         }
         if isGreenThemeActivated == true {
             ptxt.backgroundColor = GreenTheme().backgroundColor
         } else if isDarkThemeActivated {
             ptxt.backgroundColor = DarkTheme().backgroundColor
         } else {
        ptxt.backgroundColor = .white
         }
        return ptxt
    }()
    
     lazy var postImage: UIImageView = {
        let postImg = UIImageView()
        postImg.translatesAutoresizingMaskIntoConstraints = false
        postImg.contentMode = .scaleAspectFit
        postImg.clipsToBounds = true
        // postImg.addInteraction(UIDragInteraction(delegate: self))
        // postImg.addInteraction(UIDropInteraction(delegate: self))
         postImg.isUserInteractionEnabled = true
         if isGreenThemeActivated == true {
             postImg.backgroundColor = GreenTheme().backgroundColor
         } else if isDarkThemeActivated {
             postImg.backgroundColor = DarkTheme().backgroundColor
         } else if isLightThemeActivatd {
             postImg.backgroundColor = LightTheme().backgroundColor
         } else {
        postImg.backgroundColor = .black
         }
        return postImg
    }()
    
      lazy var views: UILabel = {
       let lbl = UILabel()
        let font: UIFont = UIFont.systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = font
          if isDarkThemeActivated {
              lbl.textColor = DarkTheme().textColor
          } else if isLightThemeActivatd {
              lbl.textColor = LightTheme().textColor
          } else if isGreenThemeActivated {
              lbl.textColor = GreenTheme().textColor
          } else {
        lbl.textColor = .black
          }
          if isGreenThemeActivated {
              lbl.backgroundColor = GreenTheme().backgroundColor
          } else if isDarkThemeActivated {
              lbl.backgroundColor = DarkTheme().backgroundColor
          } else {
        lbl.backgroundColor = .white
          }
        return lbl
    }()
    
     lazy var likes: UILabel = {
       let like = UILabel()
        let font: UIFont = UIFont.systemFont(ofSize: 16)
        like.translatesAutoresizingMaskIntoConstraints = false
        like.font = font
        
         if isDarkThemeActivated {
             like.textColor = DarkTheme().textColor
         } else if isLightThemeActivatd {
             like.textColor = LightTheme().textColor
         } else if isGreenThemeActivated {
             like.textColor = GreenTheme().textColor
         } else {
        like.textColor = .black
         }
         if isGreenThemeActivated {
             like.backgroundColor = GreenTheme().backgroundColor
         } else if isDarkThemeActivated{
             like.backgroundColor = DarkTheme().backgroundColor
         } else {
        like.backgroundColor = .white
         }
        return like
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        backView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(postAuthor)
        backView.addSubview(postTxt)
        backView.addSubview(postImage)
        backView.addSubview(views)
        backView.addSubview(likes)
        cellConstraints()
    }
    
    func cellConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        
            backView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            backView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            backView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            backView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            backView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, constant: -1),
            
            postAuthor.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16),
            postAuthor.leftAnchor.constraint(equalTo: backView.leftAnchor,constant: 15),
            postAuthor.widthAnchor.constraint(equalTo: backView.widthAnchor, constant: -25),
            postAuthor.heightAnchor.constraint(equalToConstant: 20),
            
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: 12),
            postImage.leftAnchor.constraint(equalTo: backView.leftAnchor),
            postImage.rightAnchor.constraint(equalTo: backView.rightAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 170),
            
            postTxt.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 5),
            postTxt.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 15),
            postTxt.rightAnchor.constraint(equalTo: backView.rightAnchor),
            postTxt.bottomAnchor.constraint(equalTo: likes.topAnchor, constant: -7),
            
            likes.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16),
            likes.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16),
            likes.widthAnchor.constraint(equalToConstant: 150),
            likes.heightAnchor.constraint(equalToConstant: 20),
            
            views.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16),
            views.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16),
            views.widthAnchor.constraint(equalToConstant: 150),
            views.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
}
