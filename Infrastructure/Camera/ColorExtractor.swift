//
//  ColorExtractor.swift
//  WineColor
//
//  Created by Yuri Ivashin on 15.07.2025.
//

import UIKit.UIImage
import SwiftUI
import CoreMedia

struct ColorExtractor {
    static func sampleBufferToUIImage(_ buffer: CMSampleBuffer) -> UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    static func extractCenterPixelColor(from image: UIImage) -> Color? {
        guard let cgImage = image.cgImage else { return nil }

        let width = cgImage.width
        let height = cgImage.height

        // Размер области в центре для анализа
        let regionSize = 34
        let halfRegion = regionSize / 2

        // Центр изображения
        let centerX = width / 2
        let centerY = height / 2

        // Координаты вырезки 34x34
        let cropRect = CGRect(
            x: centerX - halfRegion,
            y: centerY - halfRegion,
            width: regionSize,
            height: regionSize
        )

        guard let croppedCGImage = cgImage.cropping(to: cropRect) else { return nil }

        // Создаём пиксельный буфер для вырезки
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * regionSize
        let bitsPerComponent = 8
        let dataSize = regionSize * regionSize * bytesPerPixel
        var pixelData = [UInt8](repeating: 0, count: dataSize)

        guard let context = CGContext(
            data: &pixelData,
            width: regionSize,
            height: regionSize,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        context.draw(croppedCGImage, in: CGRect(x: 0, y: 0, width: regionSize, height: regionSize))

        // Усредняем 5x5 пикселей в центре
        let centerStart = regionSize / 2 - 2
        let centerEnd = regionSize / 2 + 2

        var totalR = 0
        var totalG = 0
        var totalB = 0
        var count = 0

        for y in centerStart...centerEnd {
            for x in centerStart...centerEnd {
                let index = (y * regionSize + x) * bytesPerPixel
                totalR += Int(pixelData[index])
                totalG += Int(pixelData[index + 1])
                totalB += Int(pixelData[index + 2])
                count += 1
            }
        }

        guard count > 0 else { return nil }

        let avgR = Double(totalR) / Double(count) / 255.0
        let avgG = Double(totalG) / Double(count) / 255.0
        let avgB = Double(totalB) / Double(count) / 255.0

        return Color(red: avgR, green: avgG, blue: avgB)
    }
}
