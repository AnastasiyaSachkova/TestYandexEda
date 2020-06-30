//
//  PlacesTVC.swift
//  test.yandex.eda
//
//  Created by MacMini Elis on 07/09/2018.
//  Copyright © 2018 MacMini Build. All rights reserved.
//

import UIKit

class PlacesTVC: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descr: TTTAttributedLabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var data: PlaceModel?
    private var width = "75"
    private var height = "100"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descr.delegate = self
        descr.enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
        activityIndicator.hidesWhenStopped = true
    }
    
    func setData(with data: [FoundPlaceModel], index: Int){
        activityIndicator.startAnimating()
        name.text = data[index].place?.name
        descr.text = data[index].place?.description
        //setDescription(with: data.place?.description)
        setupImage(uri: data[index].place?.picture?.uri)
        
    }
    
    private func setupImage(uri: String?) {
        guard let uri = uri else { return }
        let fullString = NetworkApi.shared.imgURL + uri
        let url = fullString.replacingOccurrences(of: "{w}", with: height).replacingOccurrences(of: "{h}", with: width )
        guard let fullURL = URL(string: url) else { return }
        img.setCache(for: fullURL){ [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    
    
    
// преобразование html в string занимает определенное время, для одной строки нормально работает, для таблицы не очень
    private func setDescription(with htmlStr: String?){
        guard let descriptionStr = htmlStr else { return }
        
        let modified = String(format: "<html><head><style>html,body,p { font-family: -apple-system); font-size: 14; font-weight: 400 }</style></head><body>%@</body></html>", descriptionStr)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 1
        paragraphStyle.minimumLineHeight = 1
        paragraphStyle.maximumLineHeight = 1
        DispatchQueue.main.async(execute: {
            if let attributedString = try? NSAttributedString(
                
                data: modified.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                
                options: [
                    .documentType: NSAttributedString.DocumentType.html.rawValue,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                    NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): paragraphStyle,
                    NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedStringKey.font.rawValue): self.descr.font],
                
                documentAttributes: nil) {
                
                let mutableString = NSMutableAttributedString(attributedString: attributedString)
                
                self.descr.attributedText = mutableString
                
                mutableString.enumerateAttribute(NSAttributedStringKey.link,
                                                 in: mutableString.string.getStringRange(),
                                                 options: [],
                                                 using: { attributeValue, range, stop in
                                                    guard let value = attributeValue else { return }
                                                    
                                                    self.descr.addLink(to: value as! URL, with: range)
                })
            } else {
                print("Unable to create attributed string from html string: \(self)")
            }
        })
    }
}

extension PlacesTVC: TTTAttributedLabelDelegate {
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
