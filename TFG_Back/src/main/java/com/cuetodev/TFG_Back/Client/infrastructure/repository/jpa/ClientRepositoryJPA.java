package com.cuetodev.TFG_Back.Client.infrastructure.repository.jpa;

import com.cuetodev.TFG_Back.Client.domain.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClientRepositoryJPA extends JpaRepository<Client, Integer> {
    public Client findByEmailAndPassword(String email, String password);
    public Client findByEmail(String email);
    public List<Client> findByUserNameContainingIgnoreCase(String userName);
    public Client findByEmailAndPasswordAndActive(String email, String password, Boolean active);
    public List<Client> findByActive(Boolean active);
    public Client findByActiveAndClientId(Boolean active, Integer id);
}
