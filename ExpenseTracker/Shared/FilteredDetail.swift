//
//  FilteredDetail.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/5/26.
//

import SwiftUI

struct FilteredDetail: View {
  @EnvironmentObject var store: Store
  @Environment(\.self) var env
  @Namespace var animation
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 12) {
        Header
        ExpenseCard()
        ExpenseTab
      }.padding()
    }
    .navigationBarHidden(true)
    .background {
      Color("bgc").ignoresSafeArea()
    }
  }

  var Header: some View {
    HStack(spacing: 15) {
      IconButton(systemName: "arrow.backward.circle.fill") {
        env.dismiss()
      }
      Text("Transactions")
        .font(.title2.bold())
        .opacity(0.7)
        .frame(maxWidth: .infinity, alignment: .leading)

      IconButton(systemName: "slider.horizontal.3") {

      }
    }
  }

  var ExpenseTab: some View {
    HStack(spacing: 0) {
      ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) { type in
        Text(type.rawValue)
          .fontWeight(.semibold)
          .foregroundColor(store.type == type ? .white : .black)
          .opacity(store.type == type ? 1 : 0.7)
          .padding(.vertical, 12)
          .frame(maxWidth: .infinity)
          .background {
            if store.type == type {
              RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                  LinearGradient(colors: [.pink, .purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .matchedGeometryEffect(id: "TAB", in: animation)
            }
          }
          .onTapGesture {
            withAnimation {
              store.type = type
            }
          }
      }
    }
    .padding(5)
    .background {
      RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
    }
  }

  private func IconButton(systemName: String, _ handler: @escaping () -> Void) -> some View {
    Button(action: handler) {
      Image(systemName: systemName)
        .font(.caption.bold())
        .foregroundColor(.gray)
        .frame(width: 40, height: 40)
        .background {
          RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
        }
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 0)
    }
  }
}

struct FilteredDetail_Previews: PreviewProvider {
  static var previews: some View {
    FilteredDetail()
      .environmentObject(Store())
  }
}
