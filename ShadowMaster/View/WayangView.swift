//
//  WayangView.swift
//  ShadowMaster
//
//  Created by WanSen on 26/04/24.
//

import Foundation
import SwiftUI


struct WayangView: View {
    let model: WayangModel
    let wayangDictionary: [String: String] = [
        "Abimanyu": "Abimanyu is a central character in the Mahabharata, known for his exceptional skills in archery and combat.",
        "Gatotkaca": "GatotKaca is a strong and powerful character in Javanese mythology, known for his bravery and loyalty.",
        "Yudhistira": "Yudhistira is one of the Pandava brothers in the Mahabharata, known for his righteousness and adherence to dharma (duty).",
        "Togog": "Togog is a humorous and witty character in traditional Javanese wayang performances, often depicted as a clown or jester.",
        "Sengkuni": "Sengkuni, also known as Sakuni, is a complex character in the Mahabharata, known for his cunning and role in the Kurukshetra War.",
        "Semar": "Semar is a revered figure in Javanese mythology, often depicted as a wise and benevolent figure associated with protection and guidance.",
        "Petruk": "Petruk is a comedic character in Javanese wayang performances, known for his humor and antics.",
        "Patih_Sabrang": "Patih Sabrang is a noble and loyal character often depicted as a warrior or advisor in wayang stories.",
        "Nakula_Sadewa": "Nakula and Sadewa are twin brothers and two of the Pandava brothers in the Mahabharata, known for their bravery and skills in combat.",
        "Kresna": "Krishna, also known as Kresna or Krshna, is a central figure in Hindu mythology and the Mahabharata, known for his wisdom, charisma, and role as a divine advisor and protector.",
        "Karna": "Karna, also known as Radheya, is a tragic hero in the Mahabharata, known for his loyalty, valor, and complex moral dilemmas.",
        "Hanoman": "Hanuman, also known as Hanoman or Anoman, is a central character in the Ramayana, known for his strength, devotion, and loyalty to Lord Rama.",
        "Gareng": "Gareng is a beloved comic character in Javanese wayang performances, known for his wit and humor.",
        "Duryudana": "Duryodhana, also known as Duryudana, is a complex and controversial character in the Mahabharata, known for his ambition, pride, and rivalry with the Pandavas.",
        "Dursana": "Dushasana, also known as Dursana, is a character in the Mahabharata, known for his role in the Kurukshetra War and his actions against the Pandavas.",
        "Durna": "Drona, also known as Durna or Dronacharya, is a revered figure in the Mahabharata, known for his skills as a warrior, teacher, and strategist.",
        "Cepot": "Cepot is a popular comedic character in Sundanese wayang performances, known for his humor and playful nature.",
        "Cakil": "Cakil is a humorous and mischievous character often depicted as a trickster in Javanese wayang stories.",
        "Buta": "Buta, also known as Buto or Buta Kurung, is a demonic character in Javanese mythology, often depicted as a fearsome figure associated with darkness and chaos.",
        "Bima": "Bima, also known as Bhima, is one of the Pandava brothers in the Mahabharata, known for his strength, courage, and prowess in battle.",
        "Baladewa": "Baladewa, also known as Baladewa or Balarama, is a divine figure in Hindu mythology and the Mahabharata, known for his strength, loyalty, and role as Krishna's brother.",
        "Bagong": "Bagong is a popular comedic character in Javanese wayang performances, known for his wit, humor, and cleverness.",
        "Arjuna": "Arjuna is one of the Pandava brothers in the Mahabharata, known for his skill in archery, devotion to duty, and complex moral dilemmas.",
        "Antasena": "Antasena is a mythical creature often depicted as a snake or serpent in Javanese mythology, associated with protection and guardianship.",
        "Anoman": "Hanuman, also known as Anoman or Hanuman, is a central character in the Ramayana, known for his strength, devotion, and loyalty to Lord Rama."
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(model.title.replacingOccurrences(of: "_", with: " "))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.leading,36)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
            }
            
            
            Text("Probability: \(model.prob1)")
                .font(.system(size: 12))
                .padding(.top, 5)
            
            Image(model.title.lowercased())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .padding(.vertical, 10)
            
            if let description = wayangDictionary[model.title] {
                Text(description)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(8)
                    .lineLimit(nil)
                   
            }
            Spacer()
            HStack {
                           VStack(alignment: .leading) {
                               Text("Second Probability")
                               Text(model.second)
                                   .font(.system(size: 14))
                               Text("Probability: \(model.prob2)")
                                   .font(.system(size: 12))
                           }
                           Spacer()
                           VStack(alignment: .leading) {
                               Text("Third Probability")
                               Text(model.third)
                                   .font(.system(size: 14))
                               Text("Probability: \(model.prob3)")
                                   .font(.system(size: 12))
                           }
                       }
            .padding(.bottom,16)
        }
        .padding()
    }
}
