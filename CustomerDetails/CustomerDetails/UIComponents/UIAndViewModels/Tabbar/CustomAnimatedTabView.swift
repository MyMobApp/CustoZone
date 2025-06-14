//
//  CustomAnimatedTabView.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 12/06/25.
//


import SwiftUI
import CoreData



struct CustomAnimatedTabView: View {
    @State private var selectedTab: CustomTab = .home
    @Environment(\.managedObjectContext) private var viewContext
    @Namespace private var animation

    var body: some View {
        VStack(spacing: 0) {
            // Tab Content
            ZStack {
                switch selectedTab {
                case .home:
                    HomeView(context: viewContext)
                 
                    
                case .userList:
                    UserListView(context: viewContext)
                case .add:
                    AddOrUpdateUserDetailsView(context: viewContext, customerToEdit: nil, isUpdate: .constant(false))
                case .products:
                    ProductListView(context: viewContext)
                case .purchaseList:
                    AddPurchaseView(context: viewContext)
                }
            }
            .animation(.easeInOut, value: selectedTab)

            // Custom Tab Bar
            ZStack {
                
                Capsule()
                    .fill(Color.blue)
                    .frame(height: 70)
                    .padding(.horizontal, 12)
                    .shadow(radius: 10)

                HStack {
                    ForEach(CustomTab.allCases, id: \.self) { tab in
                        Spacer()

                        Button(action: {
                            withAnimation(.spring()) {
                                selectedTab = tab
                            }
                        }) {
                            VStack(spacing: 1) {
                                if tab.isCenter {
                                    ZStack {
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width: 60, height: 60)
                                            .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 6)

                                        Image(systemName: "plus")
                                            .font(.system(size: 30, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                                else {
                                    ZStack {
                                        Image(systemName: selectedTab == tab ? "\(tab.rawValue).fill" : tab.rawValue)
                                            .font(.system(size: 20, weight: .semibold))
                                            .foregroundColor(selectedTab == tab ? .black : .white)
                                            .scaleEffect(selectedTab == tab ? 1.2 : 1.0)
                                            .padding(10)

                                        if selectedTab == tab {
                                            Circle()
                                                .fill(Color.blue)
                                                .frame(width: 6, height: 6)
                                                .offset(x: 12, y: -18)
                                                .transition(.scale)
                                                .animation(.easeInOut, value: selectedTab)
                                        }
                                    }

                                    Text(tab.title)
                                        .font(.caption)
                                        .foregroundColor(selectedTab == tab ? .black : .white)
                                }

                            }
                        }

                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 10)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview(){
    CustomAnimatedTabView()
}

