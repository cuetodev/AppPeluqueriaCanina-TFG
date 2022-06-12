package com.cuetodev.TFG_Back.Pet.infrastructure.repository;

import com.cuetodev.TFG_Back.Pet.domain.Pet;
import com.cuetodev.TFG_Back.Pet.infrastructure.repository.jpa.PetRepositoryJPA;
import com.cuetodev.TFG_Back.Pet.infrastructure.repository.port.PetRepositoryPort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PetRepository implements PetRepositoryPort {

    @Autowired
    PetRepositoryJPA petRepositoryJPA;

    @Override
    public Pet createPet(Pet petReceived) {
        return petRepositoryJPA.save(petReceived);
    }

    @Override
    public Pet findById(Integer id) {
        return petRepositoryJPA.findById(id).orElse(null);
    }

    @Override
    public void deletePet(Pet petGoingToDelete) {
        petRepositoryJPA.delete(petGoingToDelete);
    }
}
