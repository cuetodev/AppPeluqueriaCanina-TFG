package com.cuetodev.TFG_Back.Client.application.port;

import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input.ClientUpdateInputDTO;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.output.ClientOutputDTO;
import org.springframework.data.domain.Page;

public interface ClientPort {
    public Client findClientByEmailAndPassword(String email, String password);
    public Client findClientByEmailAndPasswordAndActive(String email, String password);
    public Client saveClient(Client client);
    public Client checkAndSave(Client client);
    public Client findClientById(Integer id);
    public Client findClientByEmail(String email);
    public Page<ClientOutputDTO> findClientsByUserName(String userName, int page, int size);
    public Client updateClient(Integer id, ClientUpdateInputDTO client);
    public void deleteClient(Integer id);
    public Page<ClientOutputDTO> findAllClients(int page, int size);
}
