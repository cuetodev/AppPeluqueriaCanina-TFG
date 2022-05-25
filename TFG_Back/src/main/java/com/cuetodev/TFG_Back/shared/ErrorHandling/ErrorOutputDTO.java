package com.cuetodev.TFG_Back.shared.ErrorHandling;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ErrorOutputDTO extends RuntimeException {
    private String error;

    public ErrorOutputDTO(String error) {
        this.error = error;
    }
}
