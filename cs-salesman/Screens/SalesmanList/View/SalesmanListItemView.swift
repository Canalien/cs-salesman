//
//  SalesmanListItemView.swift
//  cs-salesman
//
//  Created by Canalien on 23.11.22.
//

import SwiftUI

struct SalesmanListItemView: View {
    private let salesman: Salesman
    @State private var isExpanded = false

    init(salesman: Salesman) {
        self.salesman = salesman
    }

    var body: some View {
        HStack(spacing: 8) {
            Text(String(salesman.name.first ?? Character("")))
                .font(.system(size: 20))
                .frame(width: 43, height: 42)
                .background(Color(white: 0.85))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(salesman.name)
                    .font(.system(size: 17))
                    .foregroundColor(Color.black)

                if isExpanded {
                    Text(salesman.areas.joined(separator: ","))
                        .font(.system(size: 15))
                        .foregroundColor(Color("Gray-400"))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
            Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                .foregroundColor(Color("Gray-400"))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}

struct SalesmanListItemView_Previews: PreviewProvider {
    static var previews: some View {
        SalesmanListItemView(
            salesman: Salesman(
                name: "Hans Müller",
                areas: [
                    "12345",
                    "12345",
                    "12345",
                    "12345",
                    "12345",
                    "12345",
                    "12345",
                    "12345",
                    "12345",
                ]
            )
        )
    }
}
