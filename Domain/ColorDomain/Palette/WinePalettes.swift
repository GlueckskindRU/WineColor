//
//  WinePalettes.swift
//  WineColor
//
//  Created by Yuri Ivashin on 01.06.2025.
//

import SwiftUI

enum WinePalettes {
    static let all: [WineType: WinePalette] = [
        .white: WinePalette(
            wineType: .white,
            colors: [
                Color(red: 250/255, green: 248/255, blue: 232/255),
                Color(red: 248/255, green: 248/255, blue: 221/255),
                Color(red: 244/255, green: 242/255, blue: 229/255),
                Color(red: 248/255, green: 245/255, blue: 201/255),
                Color(red: 243/255, green: 240/255, blue: 209/255),
                Color(red: 241/255, green: 238/255, blue: 211/255),
                Color(red: 245/255, green: 237/255, blue: 201/255),
                Color(red: 243/255, green: 240/255, blue: 189/255),
                Color(red: 239/255, green: 236/255, blue: 208/255),
                Color(red: 244/255, green: 239/255, blue: 139/255),
                Color(red: 242/255, green: 234/255, blue: 140/255),
                Color(red: 232/255, green: 227/255, blue: 183/255),
                Color(red: 243/255, green: 224/255, blue: 158/255),
                Color(red: 238/255, green: 219/255, blue: 133/255),
                Color(red: 225/255, green: 220/255, blue: 161/255),
                Color(red: 232/255, green: 217/255, blue: 150/255),
                Color(red: 237/255, green: 218/255, blue: 101/255),
                Color(red: 237/255, green: 203/255, blue: 107/255),
            ]
        ),
        .amber: WinePalette(
            wineType: .amber,
            colors: [
                Color(red: 248/255, green: 237/255, blue: 202/255),
                Color(red: 244/255, green: 227/255, blue: 184/255),
                Color(red: 245/255, green: 219/255, blue: 141/255),
                Color(red: 244/255, green: 215/255, blue: 156/255),
                Color(red: 234/255, green: 213/255, blue: 172/255),
                Color(red: 224/255, green: 199/255, blue: 180/255),
                Color(red: 232/255, green: 198/255, blue: 160/255),
                Color(red: 233/255, green: 186/255, blue: 154/255),
                Color(red: 220/255, green: 174/255, blue: 110/255),
                Color(red: 235/255, green: 168/255, blue: 78/255),
                Color(red: 202/255, green: 157/255, blue: 70/255),
                Color(red: 220/255, green: 128/255, blue: 60/255),
                Color(red: 186/255, green: 94/255, blue: 55/255),
                Color(red: 162/255, green: 99/255, blue: 52/255),
                Color(red: 141/255, green: 57/255, blue: 41/255),
                Color(red: 112/255, green: 48/255, blue: 33/255),
                Color(red: 102/255, green: 38/255, blue: 28/255),
                Color(red: 64/255, green: 44/255, blue: 24/255),
            ]

        ),
        .rose: WinePalette(
            wineType: .rose,
            colors: [
                Color(red: 248/255, green: 235/255, blue: 232/255),
                Color(red: 244/255, green: 235/255, blue: 235/255),
                Color(red: 243/255, green: 234/255, blue: 233/255),
                Color(red: 245/255, green: 232/255, blue: 234/255),
                Color(red: 244/255, green: 231/255, blue: 217/255),
                Color(red: 245/255, green: 229/255, blue: 214/255),
                Color(red: 244/255, green: 223/255, blue: 217/255),
                Color(red: 241/255, green: 217/255, blue: 215/255),
                Color(red: 244/255, green: 219/255, blue: 191/255),
                Color(red: 225/255, green: 170/255, blue: 169/255),
                Color(red: 222/255, green: 176/255, blue: 133/255),
                Color(red: 227/255, green: 169/255, blue: 155/255),
                Color(red: 221/255, green: 127/255, blue: 67/255),
                Color(red: 223/255, green: 117/255, blue: 88/255),
                Color(red: 220/255, green: 107/255, blue: 117/255),
                Color(red: 215/255, green: 97/255, blue: 69/255),
                Color(red: 194/255, green: 82/255, blue: 54/255),
                Color(red: 183/255, green: 55/255, blue: 70/255),
            ]

        ),
        .red: WinePalette(
            wineType: .red,
            colors: [
                Color(red: 219/255, green: 165/255, blue: 139/255),
                Color(red: 225/255, green: 142/255, blue: 151/255),
                Color(red: 206/255, green: 141/255, blue: 85/255),
                Color(red: 209/255, green: 118/255, blue: 115/255),
                Color(red: 207/255, green: 92/255, blue: 125/255),
                Color(red: 200/255, green: 97/255, blue: 76/255),
                Color(red: 188/255, green: 80/255, blue: 87/255),
                Color(red: 188/255, green: 70/255, blue: 108/255),
                Color(red: 185/255, green: 62/255, blue: 104/255),
                Color(red: 149/255, green: 43/255, blue: 62/255),
                Color(red: 148/255, green: 43/255, blue: 39/255),
                Color(red: 128/255, green: 39/255, blue: 54/255),
                Color(red: 121/255, green: 34/255, blue: 31/255),
                Color(red: 88/255, green: 31/255, blue: 53/255),
                Color(red: 97/255, green: 31/255, blue: 24/255),
                Color(red: 95/255, green: 25/255, blue: 43/255),
                Color(red: 82/255, green: 29/255, blue: 39/255),
                Color(red: 66/255, green: 26/255, blue: 40/255),
            ]

        )
    ]

    static func palette(for type: WineType) -> WinePalette {
        all[type] ?? WinePalette(wineType: type, colors: [.white])
    }
}
