//
//  MainScreenViewModel.swift
//  WineColor
//
//  Created by Yuri Ivashin on 18.06.2025.
//

import SwiftUI
import Combine

@MainActor
final class MainScreenViewModel: ObservableObject {
    // MARK: - Input State

    @Published var mode: ActiveMode = .brightness {
        didSet {
            logModeChange()
        }
    }

    // MARK: - Properties
    
    let backgroundColor = Color.white
    let appState: AppState

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization

    init(appState: AppState) {
        self.appState = appState

        appState.deps.text.$fontSize
            .receive(on: RunLoop.main)
            .sink { [weak self] newSize in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Mode Checks

    var isBrightnessMode: Bool { mode.isBrightness }
    var isTextMode: Bool { mode.isText }
    var isEyedropperMode: Bool { mode.isEyedropperMode }

    // MARK: - Text

    var fontSize: CGFloat {
        let base: CGFloat = 14
        let max: CGFloat = 40
        return base + (max - base) * appState.deps.text.fontSize
    }
    
    var font: Font {
        return .system(size: fontSize)
    }

    var placeholderText: String {
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed feugiat non erat non condimentum. Morbi cursus condimentum libero, id venenatis urna iaculis ut. Sed quis velit arcu. Aenean vitae lorem at erat vulputate feugiat in et nisi. Proin nec eros augue. Sed scelerisque in lacus a tincidunt. Proin sed neque at odio interdum tempus. Integer consectetur felis vel arcu auctor, eu hendrerit sapien gravida. Aliquam sit amet eleifend est, vel pretium turpis. Nam risus ipsum, pharetra vitae rhoncus eget, venenatis et mi. In volutpat eget nunc quis gravida. Praesent semper turpis ut tellus pharetra, non elementum ligula aliquet. Nulla facilisi. Donec laoreet nisl quis massa vulputate interdum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris elit ante, semper eu imperdiet sodales, ullamcorper sit amet urna.

        In sagittis quis dolor at volutpat. Mauris sed odio in arcu scelerisque sollicitudin vitae at odio. Duis ac consequat ligula. Etiam venenatis porta risus a condimentum. Duis quis ante quis lacus varius lobortis ut et nibh. Maecenas pulvinar fringilla mi, id molestie ex placerat vel. Sed rhoncus maximus sapien, non consectetur justo maximus sit amet.

        Aliquam pretium nisl leo, eget dignissim nunc fringilla nec. Maecenas nec libero tempor, pulvinar sapien eu, pretium odio. Nullam sit amet quam quis dolor cursus aliquet. Pellentesque pretium finibus porta. Donec consectetur dui vel commodo lobortis. Curabitur dapibus urna augue, sit amet laoreet urna tincidunt finibus. Maecenas molestie massa nec est aliquet, vel porta justo blandit.

        Proin maximus nisl commodo, ultrices nisi eu, tempus mauris. Mauris id lectus auctor, iaculis augue nec, viverra ipsum. Maecenas finibus fermentum eros sit amet mattis. Aliquam erat volutpat. Fusce sollicitudin, ex vehicula fermentum interdum, ex magna semper magna, ac imperdiet dolor odio et libero. Sed mollis laoreet pellentesque. Aliquam nec ultrices lorem.

        Mauris egestas libero semper lacus elementum, sed ultricies felis pulvinar. Aenean volutpat dignissim nunc. Aenean sed leo turpis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam sed congue neque, nec porttitor felis. Nunc congue sagittis justo, faucibus congue mi consectetur pulvinar. Vivamus leo lacus, egestas non sollicitudin at, facilisis sit amet nibh. Donec fringilla sagittis erat congue ultricies. Suspendisse tincidunt lorem ac tellus maximus scelerisque. Etiam eget libero risus. Nam porta rhoncus erat, eget pharetra urna gravida id. Suspendisse vel urna eu massa congue sagittis sed at diam.
        """
    }

    // MARK: - Slider Binding

    var sliderValue: Binding<CGFloat> {
        Binding {
            switch self.mode {
                case .brightness:
                    return self.appState.deps.brightness.value
                case .text:
                    return self.appState.deps.text.fontSize
                case .eyedropper:
                    return .zero
            }
        } set: { newValue in
            switch self.mode {
                case .brightness:
                    self.appState.deps.brightness.value = newValue
                case .text:
                    self.appState.deps.text.fontSize = newValue
                case .eyedropper:
                    break
            }
        }
    }
    
    // MARK: - Analytics
    
    private func logModeChange() {
        let event: AnalyticsEvent

        switch mode {
            case .brightness:
                event = AnalyticsEvent(name: "mode_brightness")
            case .text:
                event = AnalyticsEvent(name: "mode_text")
            case .eyedropper:
                event = AnalyticsEvent(name: "mode_eyedropper")
        }

        Analytics.log(event)
    }
}
