package com.cuetodev.TFG_Back.Pet.application;

import com.cuetodev.TFG_Back.Client.application.port.ClientPort;
import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Pet.application.port.PetPort;
import com.cuetodev.TFG_Back.Pet.domain.Pet;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input.PetInputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input.PetUpdateInputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.output.PetOutputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.repository.port.PetRepositoryPort;
import com.cuetodev.TFG_Back.shared.ErrorHandling.ErrorOutputDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class PetUseCase implements PetPort {

    @Autowired
    PetRepositoryPort petRepositoryPort;

    @Autowired
    ClientPort clientPort;


    @Override
    public Pet createPet(PetInputDTO petReceived) {
        Pet pet = petReceived.convertDTOEntiy();
        if (petReceived.getClient_id() != null) {
            Client searchedClient = clientPort.findClientById(petReceived.getClient_id());
            Client savedClient= clientPort.saveClient(searchedClient);
            pet.setClient(savedClient);
        }
        return petRepositoryPort.createPet(pet);
    }

    @Override
    public Page<PetOutputDTO> findMyPets(Integer id, int page, int size) {
        Client client = clientPort.findClientById(id);

        Set<Pet> pets = client.getPets();
        // Converting Set to List
        List<Pet> petList = new ArrayList<>(pets);
        List<PetOutputDTO> petOutputDTOList = new ArrayList<>();

        petList.forEach(pet -> {
            petOutputDTOList.add(new PetOutputDTO(pet));
        });

        Pageable pageable = PageRequest.of(page, size);
        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), petOutputDTOList.size());
        return new PageImpl<PetOutputDTO>(petOutputDTOList.subList(start, end), pageable, petOutputDTOList.size());
    }

    @Override
    public Pet updatePet(Integer id, PetUpdateInputDTO pet) {
        Pet petWantToUpdate = petRepositoryPort.findById(id);
        if (petWantToUpdate == null || !petWantToUpdate.getClient().getActive()) throw new ErrorOutputDTO("Pet not found");

        if (pet.getName() != null) petWantToUpdate.setName(pet.getName());
        if (pet.getBreed() != null) petWantToUpdate.setBreed(pet.getBreed());
        if (pet.getType() != null) petWantToUpdate.setType(pet.getType());
        if (pet.getWeight() != null) petWantToUpdate.setWeight(pet.getWeight());
        if (pet.getImg() != null) petWantToUpdate.setImg(pet.getImg());
        return petRepositoryPort.createPet(petWantToUpdate);
    }

    @Override
    public void deletePet(Integer id) {
        Pet petGoingToDelete = petRepositoryPort.findById(id);
        if (petGoingToDelete == null || !petGoingToDelete.getClient().getActive()) throw new ErrorOutputDTO("Pet not found");

        petRepositoryPort.deletePet(petGoingToDelete);
    }

    @Override
    public Pet findById(Integer id) {
        Pet pet = petRepositoryPort.findById(id);
        if (pet == null) throw new ErrorOutputDTO("Pet not found");
        return pet;
    }
}
