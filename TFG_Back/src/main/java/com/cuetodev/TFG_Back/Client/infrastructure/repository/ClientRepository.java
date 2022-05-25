package com.cuetodev.TFG_Back.Client.infrastructure.repository;

import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Client.infrastructure.repository.jpa.ClientRepositoryJPA;
import com.cuetodev.TFG_Back.Client.infrastructure.repository.port.ClientRepositoryPort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClientRepository implements ClientRepositoryPort {

    @Autowired
    ClientRepositoryJPA clientRepositoryJPA;

    @Override
    public Client findClientByEmailAndByPassword(String email, String password) {
        return clientRepositoryJPA.findByEmailAndPassword(email, password);
    }

    @Override
    public Client findClientByEmailAndPasswordAndActive(String email, String password) {
        // Active true because I just want to login people who are active in the app.
        return clientRepositoryJPA.findByEmailAndPasswordAndActive(email, password, true);
    }

    @Override
    public Client clientSave(Client client) {
        return clientRepositoryJPA.save(client);
    }

    @Override
    public Client findClientById(Integer id) {
        // Using optionals to check if I don't receive a client
        return clientRepositoryJPA.findById(id).orElse(null);
    }

    @Override
    public Client findClientByEmail(String email) {
        return clientRepositoryJPA.findByEmail(email);
    }

    @Override
    public List<Client> findClientsByUserName(String userName) {
        return clientRepositoryJPA.findByUserNameContainingIgnoreCase(userName);
    }

    @Override
    public List<Client> findAllClients() {
        return clientRepositoryJPA.findByActive(true);
    }

}
