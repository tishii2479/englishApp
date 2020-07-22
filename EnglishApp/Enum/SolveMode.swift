//
//  SolveMode.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/15.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

enum SolveMode {
    // 問題集の問題のうち、まだ解いたことがない問題
    case onlyNew
    // 問題集の問題のうち、間違えたことがある問題
    case onlyMissed
    // 問題集の問題全て
    case all
    // 問題集の問題全て、確認テスト用
    case test
    // 問題集の問題のうち、お気に入りした問題
    case liked
    // 全ての問題の中からランダムに解く
    case random
}
