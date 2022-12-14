//
//  Post.swift
//  CollegeMessanger
//
//  Created by Студент on 14.12.2022.
//

import Foundation

struct PostModel{
    let postAuthorName: String
    let postAuthorUId: String
    let postFiles: [String?]?
    let postPictures: [String?]?
    let postText: String
    let postTimestamp: Timestamp?
    let postTitle: String
}
