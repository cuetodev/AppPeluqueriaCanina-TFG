package com.cuetodev.TFG_Back.Pet.infrastructure.repository.jpa;

import com.cuetodev.TFG_Back.Pet.domain.Pet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PetRepositoryJPA extends JpaRepository<Pet, Integer> {

}
