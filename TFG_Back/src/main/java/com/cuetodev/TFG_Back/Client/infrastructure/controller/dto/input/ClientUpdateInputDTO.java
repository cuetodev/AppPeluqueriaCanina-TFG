package com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Size;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientUpdateInputDTO {
    @Size(min = 3, max = 20)
    private String userName = null;

    private String email = null;

    private String password = null;

    private String role = null;

    private Boolean active = null;
}
