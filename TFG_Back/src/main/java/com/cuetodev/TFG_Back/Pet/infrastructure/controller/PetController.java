package com.cuetodev.TFG_Back.Pet.infrastructure.controller;


import com.cuetodev.TFG_Back.Pet.application.port.PetPort;
import com.cuetodev.TFG_Back.Pet.domain.Pet;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input.PetInputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.input.PetUpdateInputDTO;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.output.PetOutputDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("api/v0/pet")
public class PetController {

    @Autowired
    PetPort petPort;

    /*
    * ------------------ ------ ------------------
    *                    CREATE
    * ------------------ ------ ------------------
    */

    @PostMapping()
    public ResponseEntity<?> createPet(@RequestBody @Valid PetInputDTO petInputDTO) {
        Pet finalPet = petPort.createPet(petInputDTO);
        return new ResponseEntity<>(new PetOutputDTO(finalPet), HttpStatus.OK);
    }


    /*
     * ------------------ ---- ------------------
     *                    READ
     * ------------------ ---- ------------------
     */

    @GetMapping("/{id}/all")
    public ResponseEntity<?> findMyPets(@RequestParam(required = false, defaultValue = "0") int page,
                                        @RequestParam(required = false, defaultValue = "10") int size,
                                        @PathVariable Integer id) {
        Page<PetOutputDTO> checkedPets = petPort.findMyPets(id, page, size);
        return new ResponseEntity<>(checkedPets, HttpStatus.OK);
    }

    @GetMapping("{id}")
    public ResponseEntity<?> findByID(@PathVariable Integer id) {
        Pet pet = petPort.findById(id);
        return new ResponseEntity<>(new PetOutputDTO(pet), HttpStatus.OK);
    }

    /*
     * ------------------ ------ ------------------
     *                    UPDATE
     * ------------------ ------ ------------------
     */

    @PutMapping("{id}")
    public ResponseEntity<?> updatePet(@PathVariable Integer id,
                                       @RequestBody PetUpdateInputDTO petInputDTO) {
        Pet updatedPet = petPort.updatePet(id, petInputDTO);
        return new ResponseEntity<>(new PetOutputDTO(updatedPet), HttpStatus.OK);
    }

    /*
     * ------------------ ------ ------------------
     *                    DELETE
     * ------------------ ------ ------------------
     */

    @DeleteMapping("{id}")
    public ResponseEntity<?> deletePet(@PathVariable Integer id) {
        petPort.deletePet(id);
        return new ResponseEntity<>("", HttpStatus.OK);
    }


}
