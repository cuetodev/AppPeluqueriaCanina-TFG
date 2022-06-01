package com.cuetodev.TFG_Back.Appointment.application.port;

import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentUpdateInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.output.AppointmentOutputDTO;
import org.springframework.data.domain.Page;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

public interface AppointmentPort {
    public Appointment createAppointment(AppointmentInputDTO appointmentReceived) throws ParseException;
    public Page<AppointmentOutputDTO> findAppointmentsByConditions(HashMap<String, Object> hashMap, int page, int size);
    public Appointment findByID(Integer id);
    public Appointment updateAppointment(Integer id, AppointmentUpdateInputDTO appointmentUpdateInputDTO) throws ParseException;
    public void deleteAppointment(Integer id);
    public Set<AppointmentOutputDTO> findMyAppointments(Integer clientID);
}
