//
//  InterviewViewController.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 1501--2021.
//

import UIKit

class InterviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyDataSendingDelegateProtocol {

    //private var vragen: [Vragen] = []
    //var vraagItem: Vragen?
    var vragenLijst = [Vragen]()
    var huidigeVraag: Vragen?
    var aantalAntwoorden = 0
    var keuze: String = ""
    var score: Double = 0
    var totaalScore: Double = 0
    
    private var currentQuestionIndex: Int = 0
    
    @IBOutlet var label_vraagNummer: UILabel!
    @IBOutlet var label_vraag: UILabel!
    @IBOutlet var tabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        ophalenVragenLijst()
        tabel.delegate = self
        tabel.dataSource = self
        
        tabel.rowHeight = UITableView.automaticDimension
        tabel.estimatedRowHeight = 600
        //label_vraagNummer.text = "Vraag \(currentQuestionIndex + 1)"
        //configureUI(vraag: vragenLijst.first ?? vragenLijst[currentQuestionIndex])
    }
       
    func configureUI(vraag: Vragen) {
        label_vraagNummer.text = "Vraag \(currentQuestionIndex + 1)"
        label_vraag.text = vraag.vraag
        huidigeVraag = vraag
        aantalAntwoorden = huidigeVraag!.antwoorden.count
        tabel.reloadData()
    }

    // MARK delegate implementation
    func sendDataToFirstViewController(vragenLijst: [Vragen]) {
        self.vragenLijst = vragenLijst
        tabel.reloadData()
        configureUI(vraag: vragenLijst.first ?? vragenLijst[currentQuestionIndex])
        //label_vraag.text = vragen[currentQuestionIndex].vraag
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if vragenLijst.count == 0 {
            return 0
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aantalAntwoorden
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_antwoord = tableView.dequeueReusableCell(withIdentifier: "cell_antwoord", for: indexPath) as! AntwoordenTableViewCell
        //let vraagItem = vragen[indexPath.row]
        cell_antwoord.antwoord_cellen.text = huidigeVraag?.antwoorden[indexPath.row].antwoord
        cell_antwoord.detailTextLabel?.numberOfLines = 0
    
        return cell_antwoord
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vraag = huidigeVraag else {
            return
        }
        
        keuze = vraag.antwoorden[indexPath.row].antwoordID
        score = vraag.antwoorden[indexPath.row].score
        totaalScore = totaalScore + score
        
        //let alertKeuze = UIAlertController(title: "Keuze", message: keuze, preferredStyle: .alert)
        //alertKeuze.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        //present(alertKeuze, animated: true)
        //let alertScore = UIAlertController(title: "Score", message: String(format: "%f", score), preferredStyle: .alert)
        //alertScore.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        //present(alertScore, animated: true)

        if let index = vragenLijst.firstIndex(where: { $0.vraag == vraag.vraag}) {
            if index < (vragenLijst.count-1) {
                let volgendeVraag = vragenLijst[index+1]
                currentQuestionIndex = currentQuestionIndex + 1
                configureUI(vraag: volgendeVraag)
                tabel.reloadData()
            }
            else {
                let alertTotaalScore = UIAlertController(title: "Totaal Score", message: String(format: "%f", totaalScore), preferredStyle: .alert)
                alertTotaalScore.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                present(alertTotaalScore, animated: true)

            }
        }
    }
}

