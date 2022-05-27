package com.cuetodev.TFG_Back.Appointment.infrastructure.repository;

import com.cuetodev.TFG_Back.Appointment.infrastructure.repository.jpa.AppointmentRepositoryJPA;
import com.cuetodev.TFG_Back.Appointment.infrastructure.repository.port.AppointmentRepositoryPort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppointmentRepository implements AppointmentRepositoryPort {

    @Autowired
    AppointmentRepositoryJPA appointmentRepositoryJPA;

}
