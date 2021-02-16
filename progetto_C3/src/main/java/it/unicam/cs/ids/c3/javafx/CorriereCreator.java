package it.unicam.cs.ids.c3.javafx;

import it.unicam.cs.ids.c3.controller.ControllerCorriere;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

import java.io.IOException;

public class CorriereCreator implements JavaFXController {
    private final ControllerCorriere controllerCorriere;

    public CorriereCreator(ControllerCorriere controllerCorriere) {
        this.controllerCorriere = controllerCorriere;
    }

    public ControllerCorriere getControllerCorriere() {
        return controllerCorriere;
    }

    @FXML
    TextField ragioneSocialeTextField;
    @FXML
    TextField emailTextField;
    @FXML
    TextField usernameTextField;
    @FXML
    PasswordField passwordTextField;
    @FXML
    PasswordField confermaPasswordTextField;

    @FXML
    Button procediButton;
    @FXML
    Button annullaButton;

    @FXML
    public void procedi() {
        try {
            confrontaPassword();
            controllerCorriere.creaCorriere(usernameTextField.getText(),
                    passwordTextField.getText(), emailTextField.getText(),
                    ragioneSocialeTextField.getText());
            close(procediButton);

        } catch (IllegalArgumentException | IllegalStateException e) {
            createErrorAlert(e.getMessage());
        }
    }

    @FXML
    public void annulla() throws IOException {
        close(annullaButton);
        startWindow("Registrati", "/tipoAccount.fxml", new AccountTypePicker());
    }

    private void confrontaPassword() {
        if (!passwordTextField.getText().equals(confermaPasswordTextField.getText()))
            throw new IllegalStateException("Le due password non coincidono");
    }

    @FXML
    private void controllaCampiCompilati() {
        boolean sblocca = true;
        if (ragioneSocialeTextField.getText().isEmpty()) sblocca = false;
        if (emailTextField.getText().isEmpty()) sblocca = false;
        if (usernameTextField.getText().isEmpty()) sblocca = false;
        if (passwordTextField.getText().isEmpty()) sblocca = false;
        if (confermaPasswordTextField.getText().isEmpty()) sblocca = false;
        if (sblocca)
            procediButton.setDisable(false);

        controllaContenutoTextField(ragioneSocialeTextField);
        controllaContenutoTextField(emailTextField);
        controllaContenutoTextField(usernameTextField);
        controllaContenutoTextField(passwordTextField);
        controllaContenutoTextField(confermaPasswordTextField);

    }

    public void controllaContenutoTextField(TextField textField) {
        textField.textProperty().addListener((observable, oldValue, newValue) -> {
            if (textField.getText().isEmpty()) procediButton.setDisable(true);
        });
    }
}