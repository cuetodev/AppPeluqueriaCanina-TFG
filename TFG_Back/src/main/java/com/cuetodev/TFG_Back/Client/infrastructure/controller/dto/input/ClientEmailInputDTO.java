package com.cuetodev.TFG_Back.Client.infrastructure.controller.dto.input;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientEmailInputDTO {
    @NotBlank(message = "Email can't be null or empty")
    private String email = null;
}
