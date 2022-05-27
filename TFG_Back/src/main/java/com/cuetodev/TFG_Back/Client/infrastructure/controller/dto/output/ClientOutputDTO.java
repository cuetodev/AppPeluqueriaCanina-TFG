package com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.output;

import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Pet.domain.Pet;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientOutputDTO {
    @NotNull
    private Integer id;

    @NotBlank
    private String userName;

    @NotBlank
    private String email;

    @NotBlank
    private String password;

    private String role;

    private Boolean active;

    private Set<Pet> pets;

    public ClientOutputDTO(Client client) {
        this.id = client.getClientId();
        this.userName = client.getUserName();
        this.email = client.getEmail();
        this.password = client.getPassword();
        this.role = client.getRole();
        this.active = client.getActive();
        this.pets = client.getPets();
    }
}
