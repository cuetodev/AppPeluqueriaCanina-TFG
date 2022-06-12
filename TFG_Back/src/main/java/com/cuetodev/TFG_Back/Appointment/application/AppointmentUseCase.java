package com.cuetodev.TFG_Back.Appointment.application;

import com.cuetodev.TFG_Back.Appointment.application.port.AppointmentPort;
import com.cuetodev.TFG_Back.Appointment.domain.Appointment;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.input.AppointmentUpdateInputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.controller.dto.output.AppointmentOutputDTO;
import com.cuetodev.TFG_Back.Appointment.infrastructure.repository.AppointmentRepository;
import com.cuetodev.TFG_Back.Client.application.port.ClientPort;
import com.cuetodev.TFG_Back.Client.domain.Client;
import com.cuetodev.TFG_Back.Pet.application.port.PetPort;
import com.cuetodev.TFG_Back.Pet.domain.Pet;
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
    ClientPort clientPort;

    @Autowired
    PetPort petPort;

    @Override
    public Appointment createAppointment(AppointmentInputDTO appointmentReceived) throws ParseException {
        Pet pet = petPort.findById(appointmentReceived.getPetId());
        if (pet.getClient() != null) {
            if (pet == null || !pet.getClient().getActive()) throw new ErrorOutputDTO("Pet not found");
        }

        // Getting datetime from today minus 1 day to compare
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DATE, -1);
        Date todayMinus1Day = c.getTime();
        String todaMinus1DayString = formatDate(todayMinus1Day);

        HashMap<String, Object> conditions = new HashMap<>();
        conditions.put("lowerDate", todaMinus1DayString);

        // Validating duplicated appointments
        Set<Appointment> petAppointments = pet.getAppointments();
        if (!petAppointments.isEmpty()) {
            petAppointments.forEach(appointment -> {
                if (appointment.getStatus().equalsIgnoreCase("active")) throw new ErrorOutputDTO("You already have an appointment with this pet");
            });
        }

        List<Appointment> appointments = appointmentRepository.findAppointmentsByConditions(conditions);
        appointments.forEach(appointment -> {
            String formatDate = formatDate(appointment.getDate());
            if (appointment.getHourCheck().equalsIgnoreCase(appointmentReceived.getHourCheck()) &&
                    formatDate.equalsIgnoreCase(appointmentReceived.getDate())) throw new ErrorOutputDTO("This date and hour is already occupied");
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
        Appointment appointmentReceived = findByID(id);
        Pet pet = appointmentReceived.getPet();

        // Getting datetime from today minus 1 day to compare
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DATE, -1);
        Date todayMinus1Day = c.getTime();
        String todaMinus1DayString = formatDate(todayMinus1Day);

        HashMap<String, Object> conditions = new HashMap<>();
        conditions.put("lowerDate", todaMinus1DayString);

        if (appointmentUpdateInputDTO.getDate() != null || appointmentUpdateInputDTO.getHourCheck() != null) {
            List<Appointment> appointments = appointmentRepository.findAppointmentsByConditions(conditions);
            appointments.forEach(appointment -> {
                // Updating Date AND Hour
                if (appointmentUpdateInputDTO.getDate() != null && appointmentUpdateInputDTO.getHourCheck() != null) {
                    String formatDate = formatDate(appointment.getDate());
                    if (appointmentUpdateInputDTO.getHourCheck().equalsIgnoreCase(appointment.getHourCheck()) &&
                            formatDate.equalsIgnoreCase(appointmentUpdateInputDTO.getDate())) throw new ErrorOutputDTO("This date and hour is already occupied");
                } else if (appointmentUpdateInputDTO.getDate() != null) { // Updating only Date
                    String formatDate = formatDate(appointment.getDate());
                    if (appointment.getHourCheck().equalsIgnoreCase(appointmentReceived.getHourCheck()) &&
                            formatDate.equalsIgnoreCase(appointmentUpdateInputDTO.getDate())) throw new ErrorOutputDTO("This date and hour is already occupied");
                } else { // Updating only hour
                    String formatDate = formatDate(appointment.getDate());
                    if (appointment.getHourCheck().equalsIgnoreCase(appointmentUpdateInputDTO.getHourCheck()) &&
                            formatDate.equalsIgnoreCase(formatDate(appointmentReceived.getDate()))) throw new ErrorOutputDTO("This date and hour is already occupied");
                }
            });
        }

        if (appointmentUpdateInputDTO.getDate() != null) appointmentReceived.setDate(new SimpleDateFormat("yyyy-MM-dd").parse(appointmentUpdateInputDTO.getDate()));
        if (appointmentUpdateInputDTO.getPhone() != null) appointmentReceived.setPhone(appointmentUpdateInputDTO.getPhone());
        if (appointmentUpdateInputDTO.getHourCheck() != null) appointmentReceived.setHourCheck(appointmentUpdateInputDTO.getHourCheck());
        if (appointmentUpdateInputDTO.getServices() != null) appointmentReceived.setServices(appointmentUpdateInputDTO.getServices());
        if (appointmentUpdateInputDTO.getStatus() != null) appointmentReceived.setStatus(appointmentUpdateInputDTO.getStatus());
        if (appointmentUpdateInputDTO.getPetId() != null) appointmentReceived.setPet(petPort.findById(appointmentUpdateInputDTO.getPetId()));

        return appointmentRepository.createAppointment(appointmentReceived);
    }

    @Override
    public void deleteAppointment(Integer id) {
        Appointment appointment = findByID(id);
        appointmentRepository.deleteAppointment(appointment);
    }

    @Override
    public Set<AppointmentOutputDTO> findMyAppointments(Integer clientID) {
        Client client = clientPort.findClientById(clientID);
        Set<Pet> pets = client.getPets();
        Set<AppointmentOutputDTO> appointmentOutputDTOS = new HashSet<>();
        pets.forEach(pet -> {
            pet.getAppointments().forEach(appointment -> {
                appointmentOutputDTOS.add(new AppointmentOutputDTO(appointment));
            });
        });

        return appointmentOutputDTOS;
    }

    @Override
    public List<String> getTimesByDate(String date) {
        List<String> availableTimes = new LinkedList<String>(Arrays.asList("9:00", "10:00", "11:00", "12:00", "13:00", "17:00", "18:00", "19:00", "20:00"));
        Set<String> timesOccupied = new HashSet<>();

        HashMap<String, Object> conditions = new HashMap<>();
        conditions.put("equalDate", date);

        List<Appointment> appointmentList = appointmentRepository.findAppointmentsByConditions(conditions);
        if (!appointmentList.isEmpty()) {
            appointmentList.forEach(appointment -> {
                timesOccupied.add(appointment.getHourCheck());
            });

            availableTimes.removeAll(timesOccupied);
        }

        return availableTimes;
    }

    private String formatDate(Date date) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(date);
    }
}
