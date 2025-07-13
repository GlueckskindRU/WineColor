// Generated file – do not edit manually
import Foundation

// Total 11 entities
enum L10n {
    enum Wines {
        /// Amber
        static let amberWine = String(localized: "amberWine.title")
        /// Rose
        static let roseWine = String(localized: "roseWine.title")
        /// Red
        static let redWine = String(localized: "redWine.title")
        /// White
        static let whiteWine = String(localized: "whiteWine.title")
    }
    
    enum Main {
        enum Button {
            /// Brightness
            static let brightness = String(localized: "main.button.brightness")
            /// Eyedropper
            static let eyedropper = String(localized: "main.button.eyedropper")
            /// Text
            static let text = String(localized: "main.button.text")
        }
        /// Wine Color
        static let title = String(localized: "main.title")
    }
    
    enum Slider {
        enum Brightness {
            /// Brightness
            static let hint = String(localized: "slider.brightness.hint")
        }
        
        enum Text {
            /// Text size
            static let hint = String(localized: "slider.text.hint")
        }
        
        enum Wine {
            /// Color tone
            static let hint = String(localized: "slider.wine.hint")
        }
    }
    
    enum Button {
        enum TorchSwitcher {
            enum Off {
                /// Switch the torch off
                static let title = String(localized: "button.TorchSwitcher.off.title")
            }
            
            enum On {
                /// Switch the torch on
                static let title = String(localized: "button.TorchSwitcher.on.title")
            }
        }
        
        enum RecognizeColor {
            /// Recognize color
            static let title = String(localized: "button.RecognizeColor.title")
        }
    }
    
    enum EyedropperView {
        enum Alert {
            /// Attention
            static let title = String(localized: "eyedropperView.alert.title")
            /// The accuracy of color detection may depend on the lighting and camera characteristics of the device.
            static let text = String(localized: "eyedropperView.alert.text")
            /// Got it
            static let buttonTitle = String(localized: "eyedropperView.alert.buttonTitle")
        }
    }
}
