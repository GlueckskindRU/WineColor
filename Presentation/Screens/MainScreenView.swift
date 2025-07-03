//
//  MainScreenView.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        ZStack {
            // Фон
            viewModel.backgroundColor
                .ignoresSafeArea()
            
            // Текст
            if viewModel.isTextVisible {
                Text(viewModel.placeholderText)
                    .font(viewModel.font)
                    .foregroundColor(.black.opacity(0.8))
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
            }
             // Нижняя панель управления
             VStack(spacing: 12) {
                 Spacer()
                 ControlPanelView(viewModel: viewModel)
                     .background(.white)
             }
             .padding(.horizontal)
             .padding(.bottom, 24)
        }
    }
}
