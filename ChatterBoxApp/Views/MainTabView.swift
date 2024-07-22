// Marie Haccandy

import SwiftUI

struct MainTabView: View {
    var body: some View {
        Tabview{
            StatusUpdate()
                .tabItem{
                    Image(SystemName: Tab.updates.icon)
                    Text(Tab.updates.title)
                }
            placeholderItemView("Calls")
                .tabItem{
                    Image(SystemName: Tab.calls.icon)
                    Text(Tab.calls.title)
                }
            placeholderItemView("Chats")
                .tabItem{
                    Image(SystemName: Tab.chats.icon)
                    Text(Tab.chats.title)
                }
            placeholderItemView("Settings")
                .tabItem{
                    Image(SystemName: Tab.settings.icon)
                    Text(Tab.settings.title)
                }
        }
    }
}
extension MainTabView{
    private func placeholderItemView(_ title: String) -> some view {
        Scrollview{
            VStack{
                ForEach(0..<120) { _ in
                    Text(title)
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .frame(height: 120)
                        .background(Color.green.opcacity(0.5))
                    
                }
            }
        }
    }
    private enum Tab: String {
        case updates, calls, chats, settings
        
        fileprivate var title: String{
            return rawValue.capitalized
        }
        
        fileprivate var icon: Strig{
            switch self{
            case .updates:
                return "circle.dashed.inset.filled"
            case .calls:
                return "phone"
            case .chats:
                return "message"
            case .settings:
                return"gear"
                
            }
        }
    }
}

#Preview {
    MainTabView()
}
