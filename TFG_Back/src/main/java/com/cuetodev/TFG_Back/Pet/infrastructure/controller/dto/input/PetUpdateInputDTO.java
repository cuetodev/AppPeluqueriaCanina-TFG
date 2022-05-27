package com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Size;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PetUpdateInputDTO {
    private Integer id = null;

    @Size(max = 20, message = "Name can't be longer than 20 characters")
    private String name;

    @Size(max = 150, message = "Breed can't be longer than 150 characters")
    private String breed;

    @Size(max = 30, message = "Type can't be longer than 30 characters")
    private String type;

    private Float weight = null;

    private String img = null;
}
