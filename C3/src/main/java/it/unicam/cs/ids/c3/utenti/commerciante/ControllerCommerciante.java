package it.unicam.cs.ids.c3.utenti.commerciante;

import it.unicam.cs.ids.c3.prodotto.GestoreProdotti;
import it.unicam.cs.ids.c3.prodotto.Prodotto;
import it.unicam.cs.ids.c3.promozione.GestorePromozioni;
import it.unicam.cs.ids.c3.utilities.GestoreRicerche;
import it.unicam.cs.ids.c3.promozione.Promozione;
import it.unicam.cs.ids.c3.ritiro.GestoreRitiri;
import it.unicam.cs.ids.c3.ritiro.Ritiro;
import it.unicam.cs.ids.c3.ritiro.TipoConsegna;
import it.unicam.cs.ids.c3.database.*;
import it.unicam.cs.ids.c3.utilities.Controllore;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Objects;

public class ControllerCommerciante {
    private static ControllerCommerciante instance;
    private Commerciante commerciante;

    private ControllerCommerciante() {
    }

    public static ControllerCommerciante getInstance() {
        if (Objects.isNull(instance)) instance = new ControllerCommerciante();
        return instance;
    }

    public Commerciante getCommerciante() {
        return commerciante;
    }

    public void setCommerciante(Commerciante commerciante) {
        this.commerciante = commerciante;
    }

    public void creaCommerciante(String username, String password, String email, String ragioneSociale) throws SQLException {
        Controllore.getInstance().controllaCommerciante(username, password, email, ragioneSociale);
        Commerciante commerciante = new Commerciante(username, password, email, ragioneSociale);
        SerializerAggiunta.getInstance().serializzaCommerciante(commerciante);
    }

    public void modificaCommerciante(String username, String password, String email, String ragioneSociale, String telefono, String indirizzo) throws SQLException {
        Controllore.getInstance().controllaCommerciante(username, password, email, ragioneSociale);
        Commerciante commerciante = new Commerciante(this.commerciante.getID(), username, password, email, ragioneSociale);

        if (!indirizzo.isBlank()) {
            Controllore.getInstance().controllaIndirizzo(indirizzo);
            commerciante.setIndirizzo(indirizzo);
        }
        if (!telefono.isBlank()) {
            Controllore.getInstance().controllaNumero(telefono, 10);
            commerciante.setTelefono(telefono);
        }
        setCommerciante(commerciante);
        SerializerModifica.getInstance().modificaCommerciante(commerciante);
    }

    public void eliminaAccount() throws SQLException {
        SerializerElimina.getInstance().eliminaCommerciante(this.commerciante.getID());
        setCommerciante(null);
        GestoreRicerche.getInstance().reset();
    }

    public void logout() {
        GestoreRicerche.getInstance().reset();
        setCommerciante(null);
    }

    public boolean loginCommerciante(String username, String password) throws SQLException {
        String sql = "select * from commerciante where username = \"" + username + "\" and password = \"" + password + "\";";
        ResultSet resultSet = DBManager.getInstance().executeQuery(sql);

        if (resultSet.last()) {
            resultSet.beforeFirst();
            List<Commerciante> listaCommercianti = Deserializer.getInstance().deserializzaCommercianti(resultSet);
            this.commerciante = listaCommercianti.get(0);
            return true;
        } else return false;
    }

    public List<Prodotto> getProdotti() throws SQLException {
        return GestoreRicerche.getInstance().cercaProdotto(null, this.commerciante.getID());
    }

    public List<Ritiro> getRitiri() throws SQLException {
        return GestoreRicerche.getInstance().getRitiri(this.commerciante.getID(), null, null, null);
    }

    public void creaProdotto(String nome, Double prezzo, int quantita, String URLimmagine) throws SQLException {
        GestoreProdotti.getInstance().creaProdotto(nome, prezzo, quantita, this.commerciante.getID(), URLimmagine);
    }

    public void modificaProdotto(Prodotto prodotto) throws SQLException {
        GestoreProdotti.getInstance().modificaProdotto(prodotto);
    }

    public void eliminaProdotto(String IDProdotto) throws SQLException {
        GestoreProdotti.getInstance().eliminaProdotto(IDProdotto);
    }

    public void prenotaRitiro(String IDCliente, String IDCorriere, String destinazione, TipoConsegna tipoConsegna, List<String> listaIDProdotti) throws SQLException {
        GestoreRitiri.getInstance().creaRitiro(this.commerciante.getID(), IDCliente, IDCorriere, destinazione, tipoConsegna, listaIDProdotti);
    }

    public void eliminaRitiro(String ID) throws SQLException {
        GestoreRitiri.getInstance().eliminaRitiro(ID);
    }

    public List<Promozione> getPromozioni() throws SQLException {
        return GestoreRicerche.getInstance().getPromozioni(this.commerciante.getID());
    }

    public void creaPromozione(String nome, String descrizione, GregorianCalendar dataInizio, GregorianCalendar dataScadenza, List<String> listaIDProdotti) throws SQLException {
        GestorePromozioni.getInstance().creaPromozione(nome, this.commerciante.getID(), listaIDProdotti, descrizione, dataInizio, dataScadenza);
    }

    public void modificaPromozione(String IDPromozione, String nome, String descrizione, GregorianCalendar dataInizio, GregorianCalendar dataScadenza) throws SQLException {
        GestorePromozioni.getInstance().modificaPromozione(IDPromozione, this.commerciante.getID(), nome, descrizione, dataInizio, dataScadenza);
    }

    public void rimuoviPromozione(String IDPromozione) throws SQLException {
        GestorePromozioni.getInstance().rimuoviPromozione(IDPromozione);
    }
}