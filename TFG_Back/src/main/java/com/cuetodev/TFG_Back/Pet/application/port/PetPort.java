package com.cuetodev.TFG_Back.Pet.application.port;

import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input.ClientUpdateInputDTO;
import com.cuetodev.TFG_Back.Pet.domain.Pet;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input.PetInputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input.PetUpdateInputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.output.PetOutputDTO;
import org.springframework.data.domain.Page;

public interface PetPort {
    public Pet createPet(PetInputDTO petReceived);
    public Page<PetOutputDTO> findMyPets(Integer id, int page, int size);
    public Pet updatePet(Integer id, PetUpdateInputDTO pet);
}
