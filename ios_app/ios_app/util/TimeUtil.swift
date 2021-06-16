//
//  TimeUtil.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/6/16.
//
import Foundation

func currentTime() -> String{
    let formater = DateFormatter()
    formater.dateFormat = "HH:mm:ss.SSS"
    return formater.string(from: Date())
}
