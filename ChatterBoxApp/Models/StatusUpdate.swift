// Marie Haccandy

import SwiftUI

struct StatusUpdate: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            List {
                StatusSectionHeader()
                    .listRowBackground(Color.clear)
                StatusSection()
                
                Section{
                    RecentUpdatesItemView()
                } header: {
                    Text("Recent Updates")
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Updates")
            .searchable(text: $searchText)
        }
    }
}
extension StatusUpdate{
    enum Constant{
        static let imageDimen: CGFloat = 55
    }
}

private struct StatusSectionHeader: View {
    var body: some view {
        HStack(alignment: .top) {
            Image(systemName: "circle.dashed")
                .foregroundStyle(.blue)
                .imageScale(.large)
            (
            Text("Use status to share photos, text and videos that disappear in 24 hours.")
            +
            Text(" ")
            +
            Text("Stats privacy")
                .foregroundColor(.blue).bold()
            )
            Image(systemName: "xmark")
                .foregroundStyle(.gray)
        }
        .padding()
        .background(.whatsAppWhite)
        .clipShape(RoundedRectangle(cornerSize: 10, style: .continuous))
    }
}
private struct StatusSection: View {
    var body: some view{
        var body: some view {
            
            Hstack {
                Circle()
                    .frame(width: StatusUpdate.Constant.imageDimen, height: StatusUpdate.Constant.imageDimen)
                VStack(alignment: .leading) {
                    Text("My Status")
                        .font(.callout)
                        .bold()
                    Text("Add to my status")
                        .foregroundStyle(.gray)
                        .font(.system(size: 15))
                    
                }
                Spacer()
                cameraButton()
                pencilButton()
            }
        }
    }
    private func cameraButton() -> some view {
        Button{
            
        } label: {
            Image(SystemName: "camera.fill")
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .bold()
        }
    }
    
    private func pencilButton() -> some view {
        Button{
            
        } label: {
            Image(SystemName: "pencil")
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .bold()
        }
    }
}
private struct RecentUpdatesItemView: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width:StatusUpdate.Constant.imageDimen, height: StatusUpdate.Constant.imageDimen)
                        
            VStack(alignment: .leading) {
                Text("Javier Guevara")
                    .font(.callout)
                    .bold()
                Text("1h ago")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
                
            }
        }
        
        HStack{
            Circle()
                .frame(width:StatusUpdate.Constant.imageDimen, height: StatusUpdate.Constant.imageDimen)
                        
            VStack(alignment: .leading) {
                Text("Elle Passler")
                    .font(.callout)
                    .bold()
                Text("3h ago")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
                
            }
        }
        HStack{
            Circle()
                .frame(width:StatusUpdate.Constant.imageDimen, height: StatusUpdate.Constant.imageDimen)
                        
            VStack(alignment: .leading) {
                Text("Marie Haccamdy")
                    .font(.callout)
                    .bold()
                Text("5h ago")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
                
            }
        }
        HStack{
            Circle()
                .frame(width:StatusUpdate.Constant.imageDimen, height: StatusUpdate.Constant.imageDimen)
                        
            VStack(alignment: .leading) {
                Text("Matthew Neal")
                    .font(.callout)
                    .bold()
                Text("13h ago")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
                
            }
        }
    }
}

extension StatusUpdate {
    @ToolbarContentBuilder
    private func leadingNavItems() -> some ToolbarContent{
        ToolbarItem(placement: .topBarLeading){
            Menu{
                Button{
                    
                }label: {
                    label("Create channel")
                    label("Status Privacy")
                }
                
            } label: {
                Image(SystemName: "ellipsis.circle")
            }
        }
    }
}
#Preview {
    StatusUpdate()
}
