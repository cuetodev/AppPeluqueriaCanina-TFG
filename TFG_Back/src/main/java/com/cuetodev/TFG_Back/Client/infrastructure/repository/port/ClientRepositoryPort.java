package com.cuetodev.TFG_Back.Client.infrastructure.repository.port;

import com.cuetodev.TFG_Back.Client.domain.Client;

import java.util.List;

public interface ClientRepositoryPort {
    public Client findClientByEmailAndByPassword(String email, String password);
    public Client findClientByEmailAndPasswordAndActive(String email, String password);
    public Client clientSave(Client client);
    public Client findClientById(Integer id);
    public Client findClientByEmail(String email);
    public List<Client> findClientsByUserName(String userName);
    public List<Client> findAllClients();
}
