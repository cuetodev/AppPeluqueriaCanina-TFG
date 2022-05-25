package com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.output;

import com.cuetodev.TFG_Back.Client.domain.Client;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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

    public ClientOutputDTO(Client client) {
        this.id = client.getId();
        this.userName = client.getUserName();
        this.email = client.getEmail();
        this.password = client.getPassword();
        this.role = client.getRole();
        this.active = client.getActive();
    }
}
