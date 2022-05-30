package com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppointmentUpdateInputDTO {

    private String date;

    private String hourCheck;

    private String services;

    private String phone;

    private Integer petId;

    private String status;
}
