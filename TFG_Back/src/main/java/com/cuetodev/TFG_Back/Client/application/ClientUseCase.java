package com.cuetodev.TFG_Back.Client.application;

import com.cuetodev.TFG_Back.Client.application.port.ClientPort;
import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input.ClientUpdateInputDTO;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.output.ClientOutputDTO;
import com.cuetodev.TFG_Back.Client.infrastructure.repository.port.ClientRepositoryPort;
import com.cuetodev.TFG_Back.shared.ErrorHandling.ErrorOutputDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ClientUseCase implements ClientPort {

    @Autowired
    ClientRepositoryPort clientRepositoryPort;

    @Override
    public Client findClientByEmailAndPassword(String email, String password) {
        return clientRepositoryPort.findClientByEmailAndByPassword(email, password);
    }

    @Override
    public Client findClientByEmailAndPasswordAndActive(String email, String password) {
        Client checkedClient = clientRepositoryPort.findClientByEmailAndPasswordAndActive(email, password);
        if (checkedClient == null) throw new ErrorOutputDTO("Invalid credentials");
        return checkedClient;
    }

    @Override
    public Client saveClient(Client client) {
        return clientRepositoryPort.clientSave(client);
    }

    @Override
    public Client checkAndSave(Client client) {
        Client finalClient;
        Client checkClientInBD = clientRepositoryPort.findClientByEmailAndByPassword(client.getEmail(), client.getPassword());

        if (checkClientInBD == null) finalClient = clientRepositoryPort.clientSave(client);
        else throw new ErrorOutputDTO("Email already exist");

        return finalClient;
    }

    @Override
    public Client findClientById(Integer id) {
        Client checkClient;
        checkClient = clientRepositoryPort.findClientById(id);
        if (checkClient == null) throw new ErrorOutputDTO("ID not found");
        return checkClient;
    }

    @Override
    public Client findClientByEmail(String email) {
        Client checkClient = clientRepositoryPort.findClientByEmail(email);
        if (checkClient == null) throw new ErrorOutputDTO("Email not found");
        return checkClient;
    }

    @Override
    public Page<ClientOutputDTO> findClientsByUserName(String userName, int page, int size) {
        List<Client> checkClients = clientRepositoryPort.findClientsByUserName(userName);
        if (checkClients.isEmpty()) throw new ErrorOutputDTO("Clients not found");

        //Transforming Client list to ClientOutputDto list
        List<ClientOutputDTO> clientOutputDTOList = new ArrayList<>();
        checkClients.forEach(client -> clientOutputDTOList.add(new ClientOutputDTO(client)));

        Pageable pageable = PageRequest.of(page, size);
        int start = (int) pageable.getOffset();
        int end = (int) (Math.min((start + pageable.getPageSize()), clientOutputDTOList.size()));
        return new PageImpl<ClientOutputDTO>(clientOutputDTOList.subList(start, end), pageable, checkClients.size());
    }

    @Override
    public Client updateClient(Integer id, ClientUpdateInputDTO client) {
        Client clientWantToUpdate = findClientById(id);

        if (client.getUserName() != null) clientWantToUpdate.setUserName(client.getUserName());
        if (client.getEmail() != null) clientWantToUpdate.setEmail(client.getEmail());
        if (client.getPassword() != null) clientWantToUpdate.setPassword(client.getPassword());
        if (client.getRole() != null) clientWantToUpdate.setRole(client.getRole());
        if (client.getActive() != null) clientWantToUpdate.setActive(client.getActive());

        return clientRepositoryPort.clientSave(clientWantToUpdate);
    }

    @Override
    public void deleteClient(Integer id) {
        Client client = findClientById(id);
        client.setActive(false);
        clientRepositoryPort.clientSave(client);
    }

    @Override
    public Page<ClientOutputDTO> findAllClients(int page, int size) {
        List<Client> checkClients = clientRepositoryPort.findAllClients();
        if (checkClients.isEmpty()) throw new ErrorOutputDTO("Clients not found");

        //Transforming Client list to ClientOutputDto list
        List<ClientOutputDTO> clientOutputDTOList = new ArrayList<>();
        checkClients.forEach(client -> clientOutputDTOList.add(new ClientOutputDTO(client)));

        Pageable pageable = PageRequest.of(page, size);
        int start = (int) pageable.getOffset();
        int end = (int) (Math.min((start + pageable.getPageSize()), clientOutputDTOList.size()));
        return new PageImpl<ClientOutputDTO>(clientOutputDTOList.subList(start, end), pageable, checkClients.size());
    }
}
