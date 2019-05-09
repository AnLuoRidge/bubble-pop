//
// Created by AnLuoRidge on 2019-05-09.
// Copyright (c) 2019 UTS. All rights reserved.
//

import Foundation
import os.log

class ScoreDAO {
    internal static func saveScore(name: String, score: Int) {
        if var scores = UserDefaults.standard.dictionary(forKey: "scores") {
            scores[name] = score
            UserDefaults.standard.set(scores, forKey: "scores")
        } else {
            os_log("Failed to read scores", log: OSLog.default, type: .error)

        }
    }

    internal static func getScores() -> [Score] {
        var scores = [Score]()
        if let scoresDict = UserDefaults.standard.dictionary(forKey: "scores") {
            for (name, rawScore) in scoresDict {
                let score = rawScore as! Int
                scores.append(Score(name: name, score: score))
//                let customLog = OSLog(subsystem: "com.your_company.your_subsystem_name.plist", category: "your_category_name")
//            let msg = "name: \(name)\nscore: \(score)"
                os_log("Failed to read scores", log: OSLog.default, type: .error)
            }
        }
        return scores
    }

    internal static func sortScores(_ scores: [Score]) -> [Score] {
        var sortedScores = scores
        sortedScores.sort { score, score2 in score.score > score2.score }
        return sortedScores
    }
}