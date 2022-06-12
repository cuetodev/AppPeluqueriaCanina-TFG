package com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.output;

import com.cuetodev.TFG_Back.Pet.domain.Pet;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PetOutputDTO {

    private Integer id = null;

    @Size(max = 20, message = "Name can't be longer than 20 characters")
    @NotBlank(message = "Name can't be empty")
    private String name;

    @NotBlank(message = "Breed can't be empty")
    @Size(max = 150, message = "Breed can't be longer than 150 characters")
    private String breed;

    @NotBlank(message = "Type cant be empty")
    @Size(max = 30, message = "Type can't be longer than 30 characters")
    private String type;

    private Float weight = -1f;

    private String img = "";

    private Integer clientId;

    public PetOutputDTO (Pet pet) {
        this.id = pet.getPetId();
        this.name = pet.getName();
        this.breed = pet.getBreed();
        this.type = pet.getType();
        this.weight = pet.getWeight();
        this.img = pet.getImg();
        this.clientId = pet.getClient() == null ? null : pet.getClient().getClientId();
    }

}
