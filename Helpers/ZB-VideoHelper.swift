//
//  ZB-VideoHelper.swift
//  ZenBanana LLC
//
//  This file helps with the video set up process. This includes
//  retrieving a picture from the video to display as the preview
//  image, extracting information from services such as youtube and
//  vimeo, and more.
//
//  Created by Tanner Juby on 3/30/17.
//  Copyright © 2017 ZenBanana LLP. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

func getYoutubeVideoId(url: String) -> String {
    
    var id = ""
    
    if url.contains("youtube.com") {
        id = url.components(separatedBy: "=").last!
    } else if url.contains("youtu.be") {
        id = url.components(separatedBy: ".be/").last!
    }
    
    return id
}

func getVimeoId(url: String) -> String {
    
    var id = ""
    
    id = url.components(separatedBy: ".com/").last!
    
    return id
}


func getVideoThumbnail(url: URL, success: @escaping (String) -> ()) {
    
    let urlString = url.absoluteString
    
    if regexTest(input: urlString, forRegex: .YoutubeUrl) {
        // Video is a Youtube video
        let id = getYoutubeVideoId(url: urlString)
        
        success("http://img.youtube.com/vi/\(id)/0.jpg")
        
    } else if regexTest(input: urlString, forRegex: .VimeoUrl) {
         // Video is a Vimeo video
        
        let id = getVimeoId(url: urlString)
        
        let url = "http://vimeo.com/api/v2/video/\(id).json"
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                log.verbose("Video was retrieved")
                
                // MARK: TODO - Finish doing other things
                let json = JSON(value)
            
                let urlString = json[0]["thumbnail_large"].stringValue
                
                success(urlString)
                
            case .failure(let error):
                log.verbose("Unable to find thumbnail")
                log.error(error)
                success("")
            }
        })
        
    } else {
        log.verbose("Unable to find thumbnail")
        success("")
    }
}
