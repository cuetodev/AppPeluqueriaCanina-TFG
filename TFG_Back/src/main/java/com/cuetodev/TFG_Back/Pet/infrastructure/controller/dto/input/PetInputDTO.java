package com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input;

import com.cuetodev.TFG_Back.Pet.domain.Pet;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.HashSet;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PetInputDTO {

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

    private Integer client_id;

    public Pet convertDTOEntiy() {
        return new Pet(this.id, this.name, this.breed, this.type, this.weight, this.img, null, new HashSet<>());
    }
}
