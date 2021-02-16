package it.unicam.cs.ids.c3.javafx;

import it.unicam.cs.ids.c3.controller.ControllerCliente;
import it.unicam.cs.ids.c3.controller.ControllerCommerciante;
import it.unicam.cs.ids.c3.controller.ControllerCorriere;
import it.unicam.cs.ids.c3.controller.ControllerPuntoRitiro;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.image.ImageView;

import java.io.IOException;

public class AccountTypePicker implements JavaFXController {

    @FXML
    RadioButton clienteRadioButton;
    @FXML
    RadioButton commercianteRadioButton;
    @FXML
    RadioButton puntoRitiroRadioButton;
    @FXML
    RadioButton corriereRadioButton;

    @FXML
    ImageView clienteImageView;
    @FXML
    ImageView commercianteImageView;
    @FXML
    ImageView puntoRitiroImageView;
    @FXML
    ImageView corriereImageView;

    @FXML
    Button procediButton;
    @FXML
    Button annullaButton;

    @FXML
    public void procedi() throws IOException {
        if (clienteRadioButton.isSelected()) {
            startWindow("Crea il tuo profilo cliente",
                    "/clienteCreator.fxml",
                    new ClienteCreator(ControllerCliente.getInstance()));
            close(clienteRadioButton);
        } else if (commercianteRadioButton.isSelected()) {
            startWindow("Crea il tuo profilo Commerciante",
                    "/attivitaCreator.fxml",
                    new AttivitaCreator(ControllerCommerciante.getInstance(),
                            "Commerciante",
                            "https://www.flaticon.com/free-icon/shops_273177"));
            close(commercianteRadioButton);
        } else if (puntoRitiroRadioButton.isSelected()) {
            startWindow("Crea il tuo profilo Punto di Ritiro",
                    "/attivitaCreator.fxml",
                    new AttivitaCreator(ControllerPuntoRitiro.getInstance(), "Punto di Ritiro", "images/warehouse.png"));
            close(puntoRitiroRadioButton);
        } else if (corriereRadioButton.isSelected()) {
            startWindow("Crea il tuo profilo Corriere",
                    "/attivitaCreator.fxml",
                    new AttivitaCreator(ControllerCorriere.getInstance(), "Corriere", "images/delivery-truck.png"));
            close(corriereRadioButton);
        }
    }

    @FXML
    public void annulla() {
        close(annullaButton);
    }

    @FXML
    public void selezionaCliente() {
        clienteRadioButton.setSelected(true);
        commercianteRadioButton.setSelected(false);
        puntoRitiroRadioButton.setSelected(false);
        corriereRadioButton.setSelected(false);
        procediButton.setDisable(false);
    }

    @FXML
    public void selezionaCommerciante() {
        commercianteRadioButton.setSelected(true);
        clienteRadioButton.setSelected(false);
        puntoRitiroRadioButton.setSelected(false);
        corriereRadioButton.setSelected(false);
        procediButton.setDisable(false);
    }

    @FXML
    public void selezionaPuntoRitiro() {
        puntoRitiroRadioButton.setSelected(true);
        clienteRadioButton.setSelected(false);
        commercianteRadioButton.setSelected(false);
        corriereRadioButton.setSelected(false);
        procediButton.setDisable(false);
    }

    @FXML
    public void selezionaCorriere() {
        corriereRadioButton.setSelected(true);
        clienteRadioButton.setSelected(false);
        commercianteRadioButton.setSelected(false);
        puntoRitiroRadioButton.setSelected(false);
        procediButton.setDisable(false);
    }
}