package com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.output;

import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.output.PetOutputDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AppointmentOutputDTO {
    private Integer id;

    private String date;

    private String hourCheck;

    private String services;

    private String phone;

    private String status;

    private PetOutputDTO pet;

    public AppointmentOutputDTO(Appointment appointment) {
        this.id = appointment.getAppointmentId();
        this.date = formatDate(appointment.getDate());
        this.hourCheck = appointment.getHourCheck();
        this.services = appointment.getServices();
        this.phone = appointment.getPhone();
        this.status = appointment.getStatus();
        this.pet = new PetOutputDTO(appointment.getPet());
    }

    private String formatDate(Date date) {
        DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        return dateFormat.format(date);
    }
}
