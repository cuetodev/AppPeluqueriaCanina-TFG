package com.cuetodev.TFG_Back.Appointment.application;

import com.cuetodev.TFG_Back.Appointment.application.port.AppointmentPort;
import com.cuetodev.TFG_Back.Appointment.infrastructure.repository.AppointmentRepository;
import com.cuetodev.TFG_Back.Pet.application.port.PetPort;
import com.cuetodev.TFG_Back.Pet.infrastructure.repository.port.PetRepositoryPort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppointmentUseCase implements AppointmentPort {

    @Autowired
    AppointmentRepository appointmentRepository;


}
