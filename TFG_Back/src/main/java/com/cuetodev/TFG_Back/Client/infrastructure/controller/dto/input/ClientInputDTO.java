package com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input;

import com.cuetodev.TFG_Back.Client.domain.Client;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.HashSet;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientInputDTO {
    private Integer id = null;

    @NotBlank(message = "userName can't be empty")
    @Size(min = 3, max = 20)
    private String userName;

    @NotBlank(message = "email can't be empty")
    private String email;

    @NotBlank(message = "password can't be empty")
    private String password;

    private String role = "ROLE_USER";

    private Boolean active = true;

    public Client convertEntityToDTO() {
        return new Client(this.id, this.userName, this.email, this.password, this.role, this.active, new HashSet<>());
    }
}
