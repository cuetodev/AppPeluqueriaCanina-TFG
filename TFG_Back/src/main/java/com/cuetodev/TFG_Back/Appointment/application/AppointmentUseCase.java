package com.cuetodev.TFG_Back.Appointment.application;

import com.cuetodev.TFG_Back.Appointment.application.port.AppointmentPort;
import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentUpdateInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.output.AppointmentOutputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.repository.AppointmentRepository;
import com.cuetodev.TFG_Back.Pet.application.port.PetPort;
import com.cuetodev.TFG_Back.Pet.domain.Pet;
import com.cuetodev.TFG_Back.Pet.infrastructure.controller.dto.output.PetOutputDTO;
import com.cuetodev.TFG_Back.shared.ErrorHandling.ErrorOutputDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class AppointmentUseCase implements AppointmentPort {

    @Autowired
    AppointmentRepository appointmentRepository;

    @Autowired
    PetPort petPort;

    @Override
    public Appointment createAppointment(AppointmentInputDTO appointmentReceived) throws ParseException {
        Pet pet = petPort.findById(appointmentReceived.getPetId());
        if (pet.getClient() != null) {
            if (pet == null || !pet.getClient().getActive()) throw new ErrorOutputDTO("Pet not found");
        }
        // Validating duplicated appointments
        Set<Appointment> appointments = pet.getAppointments();
        appointments.forEach(appointment -> {
            String formatDate = formatDate(appointment.getDate());
            if (appointment.getHourCheck().equalsIgnoreCase(appointmentReceived.getHourCheck()) &&
                    formatDate.equalsIgnoreCase(appointmentReceived.getDate())) throw new ErrorOutputDTO("You already have this appointment");
        });

        Appointment appointment = appointmentReceived.convertDTOEntity();
        appointment.setPet(pet);
        return appointmentRepository.createAppointment(appointment);
    }

    @Override
    public Page<AppointmentOutputDTO> findAppointmentsByConditions(HashMap<String, Object> conditions, int page, int size) {
        // Converting Set to List
        List<Appointment> appointmentList = appointmentRepository.findAppointmentsByConditions(conditions);
        List<AppointmentOutputDTO> appointmentOutputDTOS = new ArrayList<>();

        appointmentList.forEach(appointment -> {
            appointmentOutputDTOS.add(new AppointmentOutputDTO(appointment));
        });

        Pageable pageable = PageRequest.of(page, size);
        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), appointmentOutputDTOS.size());
        return new PageImpl<>(appointmentOutputDTOS.subList(start, end), pageable, appointmentOutputDTOS.size());
    }

    @Override
    public Appointment findByID(Integer id) {
        return appointmentRepository.findByID(id);
    }

    @Override
    public Appointment updateAppointment(Integer id, AppointmentUpdateInputDTO appointmentUpdateInputDTO) throws ParseException {
        Appointment appointment = findByID(id);

        if (appointmentUpdateInputDTO.getDate() != null) appointment.setDate(new SimpleDateFormat("yyyy-MM-dd").parse(appointmentUpdateInputDTO.getDate()));
        if (appointmentUpdateInputDTO.getPhone() != null) appointment.setPhone(appointmentUpdateInputDTO.getPhone());
        if (appointmentUpdateInputDTO.getHourCheck() != null) appointment.setHourCheck(appointmentUpdateInputDTO.getHourCheck());
        if (appointmentUpdateInputDTO.getServices() != null) appointment.setServices(appointmentUpdateInputDTO.getServices());
        if (appointmentUpdateInputDTO.getStatus() != null) appointment.setStatus(appointmentUpdateInputDTO.getStatus());
        if (appointmentUpdateInputDTO.getPetId() != null) appointment.setPet(petPort.findById(appointmentUpdateInputDTO.getPetId()));

        return appointmentRepository.createAppointment(appointment);
    }

    @Override
    public void deleteAppointment(Integer id) {
        Appointment appointment = findByID(id);
        appointmentRepository.deleteAppointment(appointment);
    }

    private String formatDate(Date date) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(date);
    }
}
