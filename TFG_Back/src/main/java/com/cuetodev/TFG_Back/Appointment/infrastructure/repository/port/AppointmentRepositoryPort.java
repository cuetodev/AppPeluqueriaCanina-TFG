package com.cuetodev.TFG_Back.Appointment.infrastructure.repository.port;


import com.cuetodev.TFG_Back.Appointment.domain.Appointment;

import java.util.HashMap;
import java.util.List;

public interface AppointmentRepositoryPort {
    public Appointment createAppointment(Appointment appointment);
    public List<Appointment> findAppointmentsByConditions(HashMap<String, Object> conditions);
    public Appointment findByID(Integer id);
    public void deleteAppointment(Appointment appointment);
}
