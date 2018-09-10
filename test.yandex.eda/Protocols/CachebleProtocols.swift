//
//  CachebleProtocols.swift
//  test.yandex.eda
//
//  Created by MacMini Elis on 07/09/2018.
//  Copyright © 2018 MacMini Build. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage
import Nuke

private struct CachebleKeyProperties{
    static var cacheTypeKey = "CacheTypeKeyProperty"
}

protocol CachebleProtocols: class {
    var cacheType: CacheType { get set }
    func setCache(for imageView: UIImageView, with url: URL, completion: VoidCompletion?)
}

extension CachebleProtocols{
    
    /// Caching typy - .kingfisher, .nuke, .sdwebimage, .undefind (not cached)
    var cacheType: CacheType {
        get{
            guard let type = objc_getAssociatedObject(self, &CachebleKeyProperties.cacheTypeKey) as? CacheType else {
                var returnType: CacheType = .undefind
                let userDefaults = UserDefaults.standard
                if let storedRawType = userDefaults.value(forKey: "cache_type") as? Int, let storedType = CacheType(rawValue: storedRawType){
                    objc_setAssociatedObject(self, &CachebleKeyProperties.cacheTypeKey, storedType, .OBJC_ASSOCIATION_RETAIN)
                    returnType = storedType
                }
                return returnType
            }
            return type
        }
        set{
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(newValue.rawValue, forKeyPath: "cache_type")
            objc_setAssociatedObject(self, &CachebleKeyProperties.cacheTypeKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /// Set cache for UIImageView
    ///
    /// - Parameters:
    ///   - imageView: UIImageView
    ///   - url: image url
    func setCache(for imageView: UIImageView, with url: URL, completion: VoidCompletion? = nil) {
        setCache(for: imageView, with: url, continousType: nil, completion: completion)
    }
    
    /// Set cache for UIImageView with type for continues caching mechanic (nuke, sd, kingfisher or w/o)
    ///
    /// - Parameters:
    ///   - imageView: UIImageView
    ///   - url: image url
    ///   - continousType: cache type for next caches
    func setCache(for imageView: UIImageView, with url: URL, continousType: CacheType?, completion: VoidCompletion? = nil) {
        if let continousType = continousType{
            cacheType = continousType
        }
        switch cacheType{
        case .undefind:
            FileDownloader.get(for: url) { data in
                if let data = data, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
                completion?()
            }
        case .kingfisher: imageView.kf.setImage(with: url, completionHandler: {_, _, _, _ in completion?() })
        case .sdwebimage:
            imageView.sd_setImage(with: url, completed: {_, _, _, _ in completion?() })
        case .nuke:
            Nuke.loadImage(with: url, into: imageView, completion: {_, _ in completion?() })
        }
    }
    
}

//wrapper singltone
class Cacher: CachebleProtocols{
    static let shared = Cacher()
    private init(){}
}


private var CacherStorerKeyProperty: UInt8 = 0
extension UIImageView{
    private var cacher: Cacher{
        return Cacher.shared
    }
    
    func setCache(for url: URL){
        cacher.setCache(for: self, with: url)
    }
    
    func setCache(for url: URL, completion: @escaping () -> Void){
        cacher.setCache(for: self, with: url, completion: completion)
    }
}

typealias VoidCompletion = () -> Void
typealias DataCompletion = (Data?) -> Void
class FileDownloader{
    class func get(for url: URL, completion: @escaping DataCompletion){
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error{
                print(error)
            }
            completion(data)
        }).resume()
    }
}

enum CacheType: Int{
    case kingfisher
    case sdwebimage
    case nuke
    case undefind
}
