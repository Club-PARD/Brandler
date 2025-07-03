//
//  TabBarView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/1/25.
//

import SwiftUI


struct TabBar: View {
        @Binding var selectedTab: String

        var body: some View {
//                Rectangle()
//                    .fill(Color.white)
//                    .cornerRadius(25)
//                    .shadow(color:.gray,radius: 1,y:-2)
//                    .frame(width:400,height:60)
//                    .ignoresSafeArea()
                HStack{
                    Spacer()
                    Button {
                        selectedTab = "main"
                    } label: {
                        Text("HOME")
                            .font(.system(size: 13,weight:.semibold))
                            .background(selectedTab == "main" ? Color("Tab") : Color.gray)
                            .frame(width: 117, height:37)
                    }
                    Spacer()
                    Button {
                        selectedTab = "scrap"
                    } label: {
                        ZStack{
                            
                        }
                    }
                    Spacer()
                    Button{
                        selectedTab = "my"
                    } label: {
                        Text("MY PAGE")
                            .font(.system(size: 13,weight:.semibold))
                            .background(selectedTab == "my" ? Color("Tab") : Color.gray)
                            .frame(width: 117, height:37)
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: 85)
            }
    }

//
//        HStack {
//            Button(action: {}) {
//                Text("HOME")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color("PrimaryBlue"))
//                    .clipShape(Capsule())
//            }
//
//            Button(action: {}) {
//                Text("MY PAGE")
//                    .font(.headline)
//                    .foregroundColor(Color("PrimaryBlue"))
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.white)
//                    .clipShape(Capsule())
//            }
//        }
//        .padding(.vertical)
//        .background(Color.black)
//    }
//}
