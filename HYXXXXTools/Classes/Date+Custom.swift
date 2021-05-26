//
//  NSDate+Custom.swift
//  Soda
//
//  Created by DarkAngel on 2020/4/26.
//  Copyright © 2020 噗呲科技. All rights reserved.
//

import Foundation

protocol DateTransformer: BinaryInteger {
    var date: Date { get }
}
extension DateTransformer {
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(self))
    }
}

extension Date {
    
    static var nowTimeStampSince1970: Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    /// 根据Date 获取月份
    var getMonth: String {
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = "MM"
        return formatter.string(from: self)
    }
    /// 根据Date 获取天
    var getDay: String {
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    /// 刚刚，几小时前，昨天，月日时分，年月日
    var timePassed: String {
        
        let diff = Date().timeIntervalSince(self)
        if diff < 60 {
            return "刚刚"
        }
        if diff < 3600 {
            let minutes = diff / 60
            return "\(Int(minutes))分钟前"
        }
        if diff < 24 * 3600 {
            let hours = diff / (3600)
            return "\(Int(hours))小时前"
        }
        if diff < 2 * 24 * 3600 {
            let formatter = DateFormatter()
            formatter.locale = NSLocale.autoupdatingCurrent
            formatter.dateFormat = "HH:mm"
            return "昨天\(formatter.string(from: self))"
        }
        if diff < 3 * 24 * 3600 {
            let formatter = DateFormatter()
            formatter.locale = NSLocale.autoupdatingCurrent
            formatter.dateFormat = "HH:mm"
            return "前天\(formatter.string(from: self))"
        }
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = "yyyy"
        let nowYear = formatter.string(from: Date())
        if nowYear == formatter.string(from: self) {
            formatter.dateFormat = "MM.dd"
            return formatter.string(from: self)
        } else {
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.string(from: self)
        }
    }
    
    /// 刚刚，几小时前，昨天，月日时分，年月日 【不包含 时分秒】
    var timePassedNoHHmm: String {
        
        let diff = Date().timeIntervalSince(self)
        if diff < 60 {
            return "刚刚"
        }
        if diff < 3600 {
            let minutes = diff / 60
            return "\(Int(minutes))分钟前"
        }
        if diff < 24 * 3600 {
            let hours = diff / (3600)
            return "\(Int(hours))小时前"
        }
        if diff < 2 * 24 * 3600 {
            return "昨天)"
        }
        if diff < 3 * 24 * 3600 {
            return "前天"
        }
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = "yyyy"
        let nowYear = formatter.string(from: Date())
        if nowYear == formatter.string(from: self) {
            formatter.dateFormat = "MM.dd"
            return formatter.string(from: self)
        } else {
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.string(from: self)
        }
    }
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int64(timeInterval)
        return timeStamp
    }

    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : Int64 {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = Int64(round(timeInterval*1000))
        return millisecond
    }
    
    // MARK: - 返回字符串："yyyy-MM-dd HH:mm:ss"
    /// 默认返回格式："yyyy-MM-dd HH:mm:ss"
    func getFormatTime(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    var timeString: String {
        let diff = Date().timeIntervalSince(self)
        if diff < 60 {
            return "刚刚"
        }
        if diff < 3600 {
            let minutes = diff / 60
            return "\(Int(minutes))分钟前"
        }
        if diff < 24 * 3600 {
            let hours = diff / (3600)
            return "\(Int(hours))小时前"
        }
        if diff <= 7 * 24 * 3600 {
            return "\(Int(diff / (24 * 3600)))天前"
        }
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = "yyyy"
        let nowYear = formatter.string(from: Date())
        if nowYear == formatter.string(from: self) {
            formatter.dateFormat = "MM/dd"
            return formatter.string(from: self)
        } else {
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter.string(from: self)
        }
    }
}

extension Int: DateTransformer {}
extension Int64: DateTransformer {}
extension Double {
    
    var date: Date {
        Date(timeIntervalSince1970: self)
    }
    
    var dateFormat: String {
        let date = self.date
        let diff = Date().timeIntervalSince(date)
        if diff < 60 {
            return "刚刚"
        }
        if diff < 3600 {
            let minutes = diff / 60
            return "\(Int(minutes))分钟前"
        }
        if diff < 24 * 3600 {
            let hours = diff / (3600)
            return "\(Int(hours))小时前"
        }
        if diff <= 7 * 24 * 3600 {
            return "\(Int(diff / (24 * 3600)))天前"
        }
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = "yyyy"
        let nowYear = formatter.string(from: Date())
        if nowYear == formatter.string(from: date) {
            formatter.dateFormat = "MM/dd"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter.string(from: date)
        }
    }
    
    var timeFormat: String {
        var durationText = "00:00"
        if self.isNaN || self <= 0 {
            return durationText
        }
        
        var duration = Int(self)
        
        let seconds = duration % 60
        
        duration /= 60
        let minutes = duration % 60
        
        duration /= 60
        let hours = duration
        if hours <= 0 {
            durationText = String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
        } else {
            durationText = String(format: "%02d", hours) + ":" + String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
        }
        
        return durationText
    }
}
