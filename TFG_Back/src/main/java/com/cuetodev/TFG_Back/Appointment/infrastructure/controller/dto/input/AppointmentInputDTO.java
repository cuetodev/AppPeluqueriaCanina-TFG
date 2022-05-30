package com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input;

import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.shared.Validator.DatePatternConstraint.DatePatternCheckConstraint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AppointmentInputDTO {
    @DatePatternCheckConstraint
    @NotBlank(message = "Date can't be empty")
    private String date;

    @NotBlank(message = "Hour can't be empty")
    private String hourCheck;

    @NotBlank(message = "Services can't be empty")
    private String services;

    @NotNull(message = "Phone can't be empty")
    private String phone;

    @NotNull(message = "Pet can't be empty")
    private Integer petId;

    private String status = "active";

    public Appointment convertDTOEntity() throws ParseException {
        Date dateFormatted = new SimpleDateFormat("yyyy-MM-dd").parse(this.date);
        return new Appointment(null, dateFormatted, this.hourCheck, this.services, this.phone, this.status, null);
    }
}
