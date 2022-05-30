package com.cuetodev.TFG_Back.Pet.infrastructure.repository.port;


import com.cuetodev.TFG_Back.Pet.domain.Pet;

public interface PetRepositoryPort {
    public Pet createPet(Pet petReceived);
    public Pet findById(Integer id);
    public void deletePet(Pet petGoingToDelete);
}
