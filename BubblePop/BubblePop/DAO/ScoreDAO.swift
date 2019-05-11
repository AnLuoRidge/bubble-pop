//
// Created by AnLuoRidge on 2019-05-09.
// Copyright (c) 2019 UTS. All rights reserved.
//

import Foundation
import os.log

class ScoreDAO {
    private static let scoresKey = "scores"
    internal static func saveScore(name: String, score: Int) {
        if var scores = UserDefaults.standard.dictionary(forKey: scoresKey) {
            if scores[name] != nil {
                if score < scores[name] as! Int {
                    return
                } else {
                    scores[name] = score
                    UserDefaults.standard.set(scores, forKey: scoresKey)
                }
            } else {
                scores[name] = score
                UserDefaults.standard.set(scores, forKey: scoresKey)
            }
        } else {
            // inital DB
            let scores = [name:score]
            UserDefaults.standard.set(scores, forKey: scoresKey)
//            os_log("%@：Failed to save scores.", log: OSLog.default, type: .error, #function)
        }
    }

    internal static func getSortedScores() -> [Score] {
        return sortScores(getScores())
    }

    internal static func getScores() -> [Score] {
        var scores = [Score]()
        if let scoresDict = UserDefaults.standard.dictionary(forKey: scoresKey) {
            for (name, rawScore) in scoresDict {
                let score = rawScore as! Int
                scores.append(Score(name: name, score: score))
//                let customLog = OSLog(subsystem: "com.your_company.your_subsystem_name.plist", category: "your_category_name")
//            let msg = "name: \(name)\nscore: \(score)"
                os_log("Failed to read scores", log: OSLog.default, type: .debug)
            }
        }
        return scores
    }

    internal static func sortScores(_ scores: [Score]) -> [Score] {
        var sortedScores = scores
        sortedScores.sort { score, score2 in score.score > score2.score }
        return sortedScores
    }
    
    #if DEBUG
    internal static func clearEmptyNames() {
        if var scoresDict = UserDefaults.standard.dictionary(forKey: scoresKey) {
            scoresDict.removeValue(forKey: "")
            UserDefaults.standard.set(scoresDict, forKey: scoresKey)
        }
    }
    #endif
}
